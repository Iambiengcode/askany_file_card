import 'package:askany_file_card/colors/package_color.dart';
import 'package:askany_file_card/models/file_box_paramenters.dart';
import 'package:askany_file_card/widgets/file_card.dart';
import 'package:flutter/material.dart';

class ListFileCard extends StatelessWidget {
  final List<String> listPath;
  final FileBoxParamenters fileBoxParamenters;
  final FileBoxParamenters? fileBoxParamentersCard;
  final Function(String) onTapCard;

  final ScrollController? controller;
  final ScrollPhysics? physics;
  final String textOpen;
  const ListFileCard({
    Key? key,
    required this.listPath,
    required this.fileBoxParamenters,
    this.fileBoxParamentersCard,
    required this.onTapCard,
    this.controller,
    this.physics = const BouncingScrollPhysics(),
    this.textOpen = 'Mở',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: fileBoxParamenters.brightness == Brightness.dark
            ? backgroundFileCardDark
            : backgroundFileCardLight,
        borderRadius: BorderRadius.circular(fileBoxParamenters.radiusBox),
      ),
      child: ListView.builder(
        physics: physics,
        itemCount: listPath.length,
        controller: controller,
        shrinkWrap: true,
        itemBuilder: ((context, index) {
          return Column(
            children: [
              FileCard(
                onActionTap: () {},
                onTap: onTapCard,
                fileBoxParamenters:
                    fileBoxParamentersCard ?? FileBoxParamenters(),
                filePath: listPath[index],
                textOpen: textOpen,
                localFilePath: '',
                filePathDownload: '',
              ),
              index != listPath.length - 1
                  ? Column(
                      children: [
                        const SizedBox(
                          height: 2,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width:
                                  (fileBoxParamentersCard?.iconSize ?? 32) + 16,
                            ),
                            Expanded(
                              child: Container(
                                height: 0.2,
                                color: fileBoxParamenters.brightness ==
                                        Brightness.dark
                                    ? colorCapacityDark
                                    : colorCapacityLight,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                      ],
                    )
                  : const SizedBox(),
            ],
          );
        }),
      ),
    );
  }
}
