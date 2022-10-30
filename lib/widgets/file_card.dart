import 'dart:io';

import 'package:askany_file_card/colors/package_color.dart';
import 'package:askany_file_card/models/file_box_paramenters.dart';
import 'package:askany_file_card/models/string_of_file.dart';
import 'package:flutter/material.dart';

class FileCard extends StatefulWidget {
  final FileBoxParamenters fileBoxParamenters;
  final String filePath;
  final Function onTap;
  const FileCard({
    super.key,
    required this.fileBoxParamenters,
    required this.filePath,
    required this.onTap,
  });

  @override
  State<FileCard> createState() => _FileCardState();
}

class _FileCardState extends State<FileCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap(),
      child: Container(
        decoration: BoxDecoration(
          color: widget.fileBoxParamenters.brightness == Brightness.dark
              ? backgroundFileCardDark
              : backgroundFileCardLight,
          borderRadius:
              BorderRadius.circular(widget.fileBoxParamenters.radiusBox),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: widget.fileBoxParamenters.paddingHorizontal,
          vertical: widget.fileBoxParamenters.paddingVertical,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              StringOfFile().assetImage(filePath: widget.filePath),
              height: widget.fileBoxParamenters.iconSize,
              width: widget.fileBoxParamenters.iconSize,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    StringOfFile().getTitleFile(widget.filePath),
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: widget.fileBoxParamenters.brightness ==
                              Brightness.dark
                          ? colorTitleFileDark
                          : colorTitleFileLight,
                    ),
                  ),
                  Text(
                    (widget.filePath.isEmpty
                            ? 0
                            : StringOfFile().getFileSize(widget.filePath))
                        .toString(),
                    style: TextStyle(
                      fontSize: 13,
                      color: widget.fileBoxParamenters.brightness ==
                              Brightness.dark
                          ? colorCapacityDark
                          : colorCapacityLight,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            FileSystemEntity.typeSync(widget.filePath) !=
                    FileSystemEntityType.notFound
                ? const SizedBox()
                : Image.asset(
                    'packages/askany_file_card/icons/ic_download.png',
                    height: 17,
                    width: 17,
                    color:
                        widget.fileBoxParamenters.brightness == Brightness.dark
                            ? colorTitleFileDark
                            : colorTitleFileLight,
                  ),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}
