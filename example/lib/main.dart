import 'dart:isolate';
import 'dart:ui';

import 'package:askany_file_card/models/file_box_paramenters.dart';
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
  late List<String> listFile;
  ReceivePort receivePort = ReceivePort();
  int percentProgress = 10;
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

  _downloadFile() async {
    var status = await Permission.storage.request();
    if (status.isGranted) {
      setState(() {
        isDownloading = true;
      });
      final baseStorage = await getExternalStorageDirectory();
      await FlutterDownloader.enqueue(
          url:
              'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/SubaruOutbackOnStreetAndDirt.mp4',
          savedDir: baseStorage!.path,
          showNotification: true,
          openFileFromNotification: true,
          saveInPublicStorage: true);
    } else {
      // print('Not permission');
    }
  }

  listenDownloadFile() {
    IsolateNameServer.registerPortWithName(
        receivePort.sendPort, "downloadFile");
    receivePort.listen((dynamic data) {
      DownloadTaskStatus status = data[1];
      // print('status status: ${status.value}');
      // print('step progress: ${data[2]}');
      setState(() {
        percentProgress = data[2];
        if (status.value == 3) {
          // print('Download sucess sucess');
          // download file success and callBack update isExist
          isDownloading = false;
        }
      });
    });
    FlutterDownloader.registerCallback(downloadCallBack);
  }

  @pragma('vm:entry-point')
  static downloadCallBack(String id, DownloadTaskStatus status, int progress) {
    SendPort? sendPort = IsolateNameServer.lookupPortByName('downloadFile');
    sendPort!.send([id, status, progress]);
  }

  @override
  void initState() {
    super.initState();
    listenDownloadFile();
    listFile = [];
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloadFile');
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
                  // ignore: use_build_context_synchronously
                  // Navigator.of(context).pop();
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
                  // print('aaaabbbb: $val');
                  _downloadFile();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
