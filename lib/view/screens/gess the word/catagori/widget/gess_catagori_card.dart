// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_images.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/core/utils/style.dart';

import 'package:flutter_svg/svg.dart';

class GessCatagroiCard extends StatefulWidget {
  final String title, questions, image;
  // final bool expansionVisible, fromViewAll, fromBookmark, fromExam;

  const GessCatagroiCard({
    super.key,
    required this.title,
    this.questions = "",
    this.image = "",
  });
  @override
  State<GessCatagroiCard> createState() => _GessCatagroiCardState();
}

class _GessCatagroiCardState extends State<GessCatagroiCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.space12, vertical: Dimensions.space10),
      child: Container(
          decoration: BoxDecoration(
            color: MyColor.colorWhite,
            borderRadius: BorderRadius.circular(Dimensions.space10),
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(61, 158, 158, 158),
                blurRadius: 7,
                spreadRadius: .5,
                offset: Offset(
                  .4,
                  .4,
                ),
              )
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: Dimensions.space3),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(width: Dimensions.space20),
                  widget.image != null
                      ? Padding(
                          padding: const EdgeInsets.only(top: Dimensions.space20, bottom: Dimensions.space20),
                          child: Image.network(
                            widget.image,
                            height: Dimensions.space40,
                          ),
                        )
                      : const SizedBox.shrink(),
                  const SizedBox(width: Dimensions.space30),
                  Padding(
                    padding: const EdgeInsets.only(top: Dimensions.space15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.title, style: semiBoldMediumLarge),
                        const SizedBox(height: Dimensions.space12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.space3), color: MyColor.cardColor, border: Border.all(color: MyColor.colorDarkGrey, width: 0.3)),
                              padding: const EdgeInsets.symmetric(vertical: Dimensions.space2, horizontal: Dimensions.space5),
                              child: Center(child: Text(widget.questions + MyStrings.questionse, style: regularDefault.copyWith(color: MyColor.colorGrey))),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(top: Dimensions.space20),
                    child: SvgPicture.asset(MyImages.playSVG, height: Dimensions.space35),
                  ),
                  const SizedBox(width: Dimensions.space20),
                ],
              ),
            ],
          )),
    );
  }
}
