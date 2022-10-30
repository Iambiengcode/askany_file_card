import 'dart:io';

import 'package:askany_file_card/colors/package_color.dart';
import 'package:askany_file_card/models/file_box_paramenters.dart';
import 'package:askany_file_card/models/icon_file.dart';
import 'package:flutter/material.dart';

class FileCard extends StatelessWidget {
  final FileBoxParamenters fileBoxParamenters;
  final String filePath;

  const FileCard({
    super.key,
    required this.fileBoxParamenters,
    required this.filePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: fileBoxParamenters.brightness == Brightness.dark
            ? backgroundFileCardDark
            : backgroundFileCardLight,
        borderRadius: BorderRadius.circular(fileBoxParamenters.radiusBox),
      ),
      margin: const EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.symmetric(
        horizontal: fileBoxParamenters.paddingHorizontal,
        vertical: fileBoxParamenters.paddingVertical,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            StringIconFile().assetImage(filePath: filePath),
            height: fileBoxParamenters.iconSize,
            width: fileBoxParamenters.iconSize,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dao-Hong-Vinh-...0213123873.pdf',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: fileBoxParamenters.brightness == Brightness.dark
                        ? colorTitleFileDark
                        : colorTitleFileLight,
                  ),
                ),
                Text(
                  // StringIconFile().getFileSize(),
                  (filePath.isEmpty ? 0 : File(filePath).lengthSync())
                      .toString(),
                  style: TextStyle(
                    fontSize: 13,
                    color: fileBoxParamenters.brightness == Brightness.dark
                        ? colorCapacityDark
                        : colorCapacityLight,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Directory(filePath).existsSync()
              ? const SizedBox()
              : Image.asset(
                  'packages/askany_file_card/icons/ic_download.png',
                  height: 17,
                  width: 17,
                  color: fileBoxParamenters.brightness == Brightness.dark
                      ? colorTitleFileDark
                      : colorTitleFileLight,
                ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}
