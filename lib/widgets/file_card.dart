import 'dart:io';

import 'package:askany_file_card/colors/package_color.dart';
import 'package:askany_file_card/models/file_box_paramenters.dart';
import 'package:askany_file_card/models/string_of_file.dart';
import 'package:askany_file_card/widgets/button_action_file.dart';
import 'package:flutter/material.dart';

class FileCard extends StatefulWidget {
  final FileBoxParamenters fileBoxParamenters;
  final String filePath;
  final Function(String) onTap;
  final String textOpen;
  final double sizeTextTitle;
  final double sizeTextCapacity;
  final Color? colorIconDownload;
  final int? fileSize;
  final int currentProgress;
  final int currentStatus;
  final String? filePathUrl;
  const FileCard({
    super.key,
    required this.fileBoxParamenters,
    required this.filePath,
    required this.onTap,
    this.textOpen = 'Mở',
    this.sizeTextCapacity = 11,
    this.sizeTextTitle = 13,
    this.colorIconDownload,
    this.fileSize,
    this.currentProgress = 0,
    this.currentStatus = 0,
    this.filePathUrl,
  });

  @override
  State<FileCard> createState() => _FileCardState();
}

class _FileCardState extends State<FileCard> {
  int percent = 0;
  int statusDownload = 0;
  @override
  void initState() {
    super.initState();
    print(File(widget.filePath).existsSync() ||
        File(widget.filePathUrl ?? '').existsSync());
    print(
        'hahah ${widget.filePath} ${FileSystemEntity.typeSync(widget.filePath) != FileSystemEntityType.notFound}');

    print(
        'hahaha ${widget.filePathUrl} ${FileSystemEntity.typeSync(widget.filePathUrl ?? '') != FileSystemEntityType.notFound}');
  }

  @override
  void didUpdateWidget(covariant FileCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    percent = widget.currentProgress;
    statusDownload = widget.currentStatus;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap(widget.filePath);
      },
      child: Container(
        height: widget.fileBoxParamenters.height,
        margin: widget.fileBoxParamenters.margin,
        decoration: BoxDecoration(
          color: widget.fileBoxParamenters.backgroundColor ??
              (widget.fileBoxParamenters.brightness == Brightness.dark
                  ? backgroundFileCardDark
                  : backgroundFileCardLight),
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
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: widget.sizeTextTitle,
                      fontWeight: FontWeight.w600,
                      color: widget.fileBoxParamenters.colorTitle ??
                          (widget.fileBoxParamenters.brightness ==
                                  Brightness.dark
                              ? colorTitleFileDark
                              : colorTitleFileLight),
                    ),
                  ),
                  const SizedBox(height: 2),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: widget.sizeTextCapacity,
                        color: widget.fileBoxParamenters.colorCapacity ??
                            (widget.fileBoxParamenters.brightness ==
                                    Brightness.dark
                                ? colorCapacityDark
                                : colorCapacityLight),
                      ),
                      children: [
                        TextSpan(
                          text:
                              '${(widget.filePath.isEmpty ? '' : StringOfFile().getTypeFile(widget.filePath)).toString().toUpperCase()} - ',
                        ),
                        TextSpan(
                          text: widget.fileSize != null
                              ? StringOfFile()
                                  .getSizeFromBytes(widget.fileSize!)
                              : ((widget.filePath.isEmpty
                                      ? 0
                                      : StringOfFile()
                                          .getFileSize(widget.filePath)))
                                  .toString(),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            ButtonActionFile(
              textOpen: widget.textOpen,
              percent: percent,
              isExist: File(widget.filePathUrl ?? '').existsSync() ||
                  File(widget.filePath).existsSync(),
              onTap: widget.onTap,
              fileBoxParamenters: widget.fileBoxParamenters,
              status: statusDownload,
              filePath: widget.filePath,
            ),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}
