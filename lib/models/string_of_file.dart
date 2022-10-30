import 'dart:io';
import 'dart:math';

import 'package:askany_file_card/models/icon_file.dart';

class StringOfFile {
  String assetImage({required String filePath}) {
    return 'packages/askany_file_card/icons/ic_${enumIconFile(filePath: filePath).name.toLowerCase()}.png';
  }

  IconFile enumIconFile({required String filePath}) {
    String file = filePath.split('.').last;
    switch (file) {
      case 'pdf':
        return IconFile.pdf;
      case 'doc':
        return IconFile.doc;
      case 'docs':
        return IconFile.doc;
      case 'docx':
        return IconFile.doc;
      case 'txt':
        return IconFile.txt;
      case 'ppt':
        return IconFile.ppt;
      case 'xls':
        return IconFile.xls;
      default:
        return IconFile.none;
    }
  }

  String getFileSize(String path) {
    var file = File(path);
    int bytes = file.lengthSync();
    return getSizeFromBytes(bytes);
  }

  String getSizeFromBytes(int bytes) {
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(bytes) / log(1024)).floor();
    return '${(bytes / pow(1024, i)).toStringAsFixed(1)} ${suffixes[i]}';
  }

  String getTitleFile(String path) {
    return path.split('/').last;
  }
}
