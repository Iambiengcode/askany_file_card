import 'dart:io';

import 'package:askany_file_card/colors/package_color.dart';
import 'package:askany_file_card/models/file_box_paramenters.dart';
import 'package:askany_file_card/models/string_of_file.dart';
import 'package:askany_file_card/widgets/custom_circle_indicator.dart';
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
  final int percentDownload;
  final Function() onActionTap;
  final int? downloadStatus;
  final int? statusWhenDrop;
  final String localFilePath;
  final String filePathDownload;
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
    this.percentDownload = 0,
    required this.onActionTap,
    this.downloadStatus = 0,
    this.statusWhenDrop = 0,
    required this.localFilePath,
    required this.filePathDownload,
  });

  @override
  State<FileCard> createState() => _FileCardState();
}

class _FileCardState extends State<FileCard> {
  late int percent;
  late int statusDownload = 0;
  late bool checkFileOnlineExist;
  late bool isExistFile = false;
  @override
  void initState() {
    percent = widget.percentDownload;
    String lastFilename = widget.filePathDownload.split('/').last;
    if (FileSystemEntity.typeSync(widget.localFilePath + lastFilename) !=
        FileSystemEntityType.notFound) {
      isExistFile = true;
    }
    super.initState();
  }

  @override
  void didUpdateWidget(covariant FileCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    percent = widget.percentDownload;
    statusDownload = widget.downloadStatus!;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
            child: GestureDetector(
              onTap: () {
                widget.onTap(widget.filePath);
              },
              child: Container(
                color: Colors.transparent,
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
            ),
          ),
          const SizedBox(width: 8),
          buildButtonEnd(statusDownload, widget.onActionTap),
          const SizedBox(width: 8),
        ],
      ),
    );
  }

  Widget buildButtonEnd(int status, Function ontap) {
    if (isExistFile) {
      return GestureDetector(
        onTap: () {
          print('hello1: ${widget.localFilePath}');
          ontap();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 7,
          ),
          decoration: BoxDecoration(
            color: widget.fileBoxParamenters.brightness == Brightness.dark
                ? backgroundOpenDark
                : backgroundOpenLight,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            widget.textOpen,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: widget.fileBoxParamenters.brightness == Brightness.dark
                  ? colorOpenDark
                  : colorOpenLight,
            ),
          ),
        ),
      );
    } else {
      switch (status) {
        case 2:
          return GestureDetector(
            onTap: () {
              ontap();
            },
            child: CircleProgressIndicator(
              percentProgress: percent,
              onActionTap: widget.onActionTap,
            ),
          );
        case 3:
          return GestureDetector(
            onTap: () {
              print('hello2: ${widget.localFilePath}');
              ontap();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 7,
              ),
              decoration: BoxDecoration(
                color: widget.fileBoxParamenters.brightness == Brightness.dark
                    ? backgroundOpenDark
                    : backgroundOpenLight,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                widget.textOpen,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: widget.fileBoxParamenters.brightness == Brightness.dark
                      ? colorOpenDark
                      : colorOpenLight,
                ),
              ),
            ),
          );
        case 5:
          return GestureDetector(
            onTap: () {
              ontap();
            },
            child: Image.asset(
              'packages/askany_file_card/icons/ic_download.png',
              height: 17,
              width: 17,
              color: widget.colorIconDownload ??
                  (widget.fileBoxParamenters.brightness == Brightness.dark
                      ? colorTitleFileDark
                      : colorTitleFileLight),
            ),
          );
        default:
          return GestureDetector(
            onTap: () {
              ontap();
            },
            child: Image.asset(
              'packages/askany_file_card/icons/ic_download.png',
              height: 17,
              width: 17,
              color: widget.colorIconDownload ??
                  (widget.fileBoxParamenters.brightness == Brightness.dark
                      ? colorTitleFileDark
                      : colorTitleFileLight),
            ),
          );
      }
    }
  }
  //   if (FileSystemEntity.typeSync(widget.filePath) ==
  //       FileSystemEntityType.notFound) {
  //     return GestureDetector(
  //       onTap: () {
  //         ontap();
  //       },
  //       child: Container(
  //         padding: const EdgeInsets.symmetric(
  //           horizontal: 15,
  //           vertical: 7,
  //         ),
  //         decoration: BoxDecoration(
  //           color: widget.fileBoxParamenters.brightness == Brightness.dark
  //               ? backgroundOpenDark
  //               : backgroundOpenLight,
  //           borderRadius: BorderRadius.circular(20),
  //         ),
  //         child: Text(
  //           widget.textOpen,
  //           style: TextStyle(
  //             fontSize: 11,
  //             fontWeight: FontWeight.w600,
  //             color: widget.fileBoxParamenters.brightness == Brightness.dark
  //                 ? colorOpenDark
  //                 : colorOpenLight,
  //           ),
  //         ),
  //       ),
  //     );
  //   } else {

  // }
}
