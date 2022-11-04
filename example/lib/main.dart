import 'package:askany_file_card/askany_file_card.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

void main() {
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
  List<String> listFile = [];

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

  @override
  void initState() {
    super.initState();
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
              // ListFileCard(
              //   listPath: listFile,
              //   fileBoxParamenters: FileBoxParamenters(
              //     brightness: widget.brightness,
              //   ),
              //   fileBoxParamentersCard: FileBoxParamenters(
              //     brightness: widget.brightness,
              //     paddingVertical: 12,
              //     paddingHorizontal: 12,
              //   ),
              //   onTapCard: (val) {},
              // ),
              FileCard(
                fileBoxParamenters: FileBoxParamenters(
                  brightness: widget.brightness,
                ),
                filePath:
                    'data/user/0/com.askany/cache/file_picker/Dang-Quoc-Trung-asjkldhaskld-123123123147184.pdf',
                onTap: (val) async {},
                fileSize: 123123,
                filePathUrl:
                    '/storage/emulated/0/Download/8e6824e6-7605-46d1-abc1-0c16bf49825f.pdf',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
