import 'dart:io';
import 'dart:math';

import 'package:askany_file_card/models/icon_file.dart';

class StringOfFile {
  String assetImage({required String filePath}) {
    return 'packages/askany_file_card/icons/ic_${enumIconFile(filePath: filePath).name.toLowerCase()}.png';
  }

  IconFile enumIconFile({required String filePath}) {
    String file = filePath.split('.').last;
    if (file.startsWith('pdf')) {
      return IconFile.pdf;
    }
    if (file.startsWith('doc')) {
      return IconFile.doc;
    }
    if (file.startsWith('txt')) {
      return IconFile.txt;
    }
    if (file.startsWith('ppt')) {
      return IconFile.ppt;
    }
    if (file.startsWith('xls')) {
      return IconFile.xls;
    } else {
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
    String first = '';
    String last = '';
    String between = '...';
    String fileName = path.split('/').last;
    if (fileName.length > 30) {
      first = fileName.substring(0, 15);
      last = fileName.substring(fileName.length - 11, fileName.length);
      return first + between + last;
    } else {
      return fileName;
    }
    // return path.split('/').last;
  }
}
