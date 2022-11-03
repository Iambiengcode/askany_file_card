import 'package:askany_file_card/askany_file_card.dart';
import 'package:askany_file_card/colors/package_color.dart';
import 'package:askany_file_card/widgets/progress_cirlce.dart';
import 'package:flutter/material.dart';

class ButtonActionFile extends StatelessWidget {
  final String textOpen;
  final int percent;
  final bool isExist;
  final Function onTap;
  final FileBoxParamenters fileBoxParamenters;
  final int status;
  const ButtonActionFile({
    super.key,
    required this.textOpen,
    required this.percent,
    required this.isExist,
    required this.onTap,
    required this.fileBoxParamenters,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return buildButtonEnd(
        status: status,
        fileBoxParamenters: fileBoxParamenters,
        isExist: isExist,
        ontap: onTap,
        percent: percent,
        textOpen: textOpen,
      );
    });
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
}) {
  if (isExist) {
    return GestureDetector(
      onTap: () {
        // open File
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
