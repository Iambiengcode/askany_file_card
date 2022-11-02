import 'dart:isolate';
import 'dart:ui';

import 'package:askany_file_card/models/file_box_paramenters.dart';
import 'package:askany_file_card/widgets/file_card.dart';
import 'package:askany_file_card/widgets/list_file_card.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(debug: true, ignoreSsl: true);
  runApp(const MyApp());
}

class Downloadlass {
  static void callBack(String id, DownloadTaskStatus status, int progress) {
    SendPort sendPort =
        IsolateNameServer.lookupPortByName('downloader_send_port')!;
    sendPort.send([id, status, progress]);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const Example(
        brightness: Brightness.dark,
      ),
    );
  }
}

class Example extends StatefulWidget {
  final Brightness brightness;
  const Example({Key? key, this.brightness = Brightness.light})
      : super(key: key);

  @override
  State<Example> createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  final String localFile =
      '/data/user/0/com.example.example/cache/file_picker/';
  late List<String> listFile;
  ReceivePort receivePort = ReceivePort();
  String taskID = '';
  int downloadStatus = 0;
  int percentProgress = 0;
  bool isDownloading = false;
  bool isDownloadSuccess = false;
  bool isExist = false;

  Future<void> pickFileExcel() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        setState(() {
          listFile.add(result.files.first.path.toString());
        });
      }
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  Future<void> _pauseDownload(String? taskId) async {
    await FlutterDownloader.pause(taskId: taskId!);
  }

  Future<void> _resumeDownload(String? taskId) async {
    final newTaskId = await FlutterDownloader.resume(taskId: taskId!);
    taskId = newTaskId;
  }

  Future<void> _retryDownload(String? taskId) async {
    final newTaskId = await FlutterDownloader.retry(taskId: taskId!);
    taskId = newTaskId;
  }

  Future<bool> _openDownloadedFile(String? taskId) {
    if (taskId != null) {
      return FlutterDownloader.open(taskId: taskId);
    } else {
      return Future.value(false);
    }
  }

  Future<void> _cancelDownloadFile(String? taskID) async {
    await FlutterDownloader.cancel(
      taskId: taskID!,
    );

    setState(() {
      percentProgress = 0;
    });
  }

  _downloadFile() async {
    var status = await Permission.storage.request();
    if (status.isGranted) {
      setState(() {
        isDownloading = true;
      });
      final baseStorage = await getExternalStorageDirectory();
      print(baseStorage!.path);
      await FlutterDownloader.enqueue(
        url:
            'https://s3.ap-southeast-1.amazonaws.com/askany.dev/files/db3e607a-007c-4e08-887e-7478e3cfc4e4.pdf',
        savedDir: baseStorage.path,
        showNotification: true,
        openFileFromNotification: true,
        saveInPublicStorage: true,
        requiresStorageNotLow: true,
      );
    } else {
      // print('Not permission');
    }
  }

  listenDownloadFile() {
    IsolateNameServer.registerPortWithName(
        receivePort.sendPort, "downloader_send_port");
    receivePort.listen((dynamic data) {
      DownloadTaskStatus status = data[1];
      taskID = data[0];
      setState(() {
        percentProgress = data[2];
        downloadStatus = status.value;
        print(downloadStatus);
        if (status.value == 3) {
          isDownloading = false;
        }
      });
    });
    FlutterDownloader.registerCallback(Downloadlass.callBack);
  }

  @pragma('vm:entry-point')
  static void downloadCallBack(
      String id, DownloadTaskStatus status, int progress) {
    SendPort sendPort =
        IsolateNameServer.lookupPortByName('downloader_send_port')!;
    sendPort.send([id, status, progress]);
  }

  @override
  void initState() {
    super.initState();
    listFile = [];
    listenDownloadFile();
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: widget.brightness == Brightness.light
              ? const Color(0xFFF5F5F5)
              : const Color(0xFF14171A),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () async {
                  await pickFileExcel();
                },
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.folder,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              ListFileCard(
                listPath: listFile,
                fileBoxParamenters: FileBoxParamenters(
                  brightness: widget.brightness,
                ),
                fileBoxParamentersCard: FileBoxParamenters(
                  brightness: widget.brightness,
                  paddingVertical: 12,
                  paddingHorizontal: 12,
                ),
                onTapCard: (val) {
                  _downloadFile();
                },
              ),
              const SizedBox(
                height: 20,
              ),
              listFile.isNotEmpty
                  ? FileCard(
                      onTap: (val) {
                        print('status1: $downloadStatus');
                        _handleOnTap();
                        print(val);
                      },
                      fileBoxParamenters: FileBoxParamenters(
                        brightness: widget.brightness,
                      ),
                      filePath: listFile[0],
                      textOpen: 'Mở',
                      percentDownload: percentProgress,
                      onActionTap: () {
                        print('status2: $downloadStatus');
                        _handleOnTap();
                      },
                      downloadStatus: downloadStatus,
                      localFilePath: localFile,
                      filePathDownload:
                          'https://s3.ap-southeast-1.amazonaws.com/askany.dev/files/db3e607a-007c-4e08-887e-7478e3cfc4e4.pdf',
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  _handleOnTap() {
    if (downloadStatus == 2) {
      _cancelDownloadFile(taskID);
    } else if (downloadStatus == 5) {
      _retryDownload(taskID);
    } else if (downloadStatus == 3) {
      _openDownloadedFile(taskID);
    } else {
      // _resumeDownload(taskID);
      _downloadFile();
    }
  }
}
