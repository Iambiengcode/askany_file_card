import 'package:askany_file_card/askany_file_card.dart';
import 'package:askany_file_card/colors/package_color.dart';
import 'package:askany_file_card/widgets/progress_cirlce.dart';
import 'package:flutter/material.dart';
import 'package:open_file_plus/open_file_plus.dart';

class ButtonActionFile extends StatelessWidget {
  final String textOpen;
  final int percent;
  final bool isExist;
  final Function onTap;
  final FileBoxParamenters fileBoxParamenters;
  final int status;
  final String filePath;
  const ButtonActionFile({
    super.key,
    required this.textOpen,
    required this.percent,
    required this.isExist,
    required this.onTap,
    required this.fileBoxParamenters,
    required this.status,
    required this.filePath,
  });

  @override
  Widget build(BuildContext context) {
    return buildButtonEnd(
      status: status,
      fileBoxParamenters: fileBoxParamenters,
      isExist: isExist,
      ontap: onTap,
      percent: percent,
      textOpen: textOpen,
      filePath: filePath,
    );
  }
}

Widget buildButtonEnd({
  required int status,
  required Function ontap,
  required String textOpen,
  required int percent,
  required bool isExist,
  required FileBoxParamenters fileBoxParamenters,
  Colors? colorIconDownload,
  required String filePath,
}) {
  if (isExist) {
    return GestureDetector(
      onTap: () async {
        await OpenFile.open(filePath);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 7,
        ),
        decoration: BoxDecoration(
          color: fileBoxParamenters.brightness == Brightness.dark
              ? backgroundOpenDark
              : backgroundOpenLight,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          textOpen,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: fileBoxParamenters.brightness == Brightness.dark
                ? colorOpenDark
                : colorOpenLight,
          ),
        ),
      ),
    );
  } else {
    switch (status) {
      case 2:
        return ProgressCircle(
          percentProgress: percent,
          onActionTap: ontap,
        );
      case 3:
        return GestureDetector(
          onTap: ontap(),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 7,
            ),
            decoration: BoxDecoration(
              color: fileBoxParamenters.brightness == Brightness.dark
                  ? backgroundOpenDark
                  : backgroundOpenLight,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              textOpen,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: fileBoxParamenters.brightness == Brightness.dark
                    ? colorOpenDark
                    : colorOpenLight,
              ),
            ),
          ),
        );
      case 5:
        return GestureDetector(
          onTap: ontap(),
          child: Image.asset('packages/askany_file_card/icons/ic_download.png',
              height: 17,
              width: 17,
              color: (fileBoxParamenters.brightness == Brightness.dark
                  ? colorTitleFileDark
                  : colorTitleFileLight)),
        );
      default:
        return GestureDetector(
          onTap: ontap(),
          child: Image.asset(
            'packages/askany_file_card/icons/ic_download.png',
            height: 17,
            width: 17,
            color: (fileBoxParamenters.brightness == Brightness.dark
                ? colorTitleFileDark
                : colorTitleFileLight),
          ),
        );
    }
  }
}
