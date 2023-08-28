// ignore_for_file: unnecessary_null_comparison

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_prime/core/route/route.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_images.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/core/utils/style.dart';
import 'package:flutter_prime/data/model/gesstheword/gess_catagroi_model.dart';
import 'package:flutter_prime/view/components/animated_widget/expanded_widget.dart';
import 'package:flutter_prime/view/components/divider/custom_horizontal_divider.dart';
import 'package:flutter_prime/view/components/text/custom_text_with_underline.dart';

import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class GessCatagroiCard extends StatefulWidget {
  final GeusCatagories catagories;
  String image;
  // final bool expansionVisible, fromViewAll, fromBookmark, fromExam;

  GessCatagroiCard({
    super.key,
    required this.catagories,
    this.image = "",
  });
  @override
  State<GessCatagroiCard> createState() => _GessCatagroiCardState();
}

class _GessCatagroiCardState extends State<GessCatagroiCard> {
  bool isExpande = false;
  int labelCount = 0;
  void toggleExpande() {
    setState(() {
      isExpande = !isExpande;
    });
  }

  @override
  void initState() {
    labelCount = widget.catagories.quizInfos!.length > 3 ? 3 : widget.catagories.quizInfos!.length;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.catagories.subcategoriesCount == "0") {
          toggleExpande();
        } else {
          Get.toNamed(RouteHelper.gessThewordsubCatagori, arguments: widget.catagories.id);
        }
      },
      child: Padding(
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
                          Text(widget.catagories.name.toString(), style: semiBoldMediumLarge),
                          const SizedBox(height: Dimensions.space12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.space3), color: MyColor.cardColor, border: Border.all(color: MyColor.colorDarkGrey, width: 0.3)),
                                padding: const EdgeInsets.symmetric(vertical: Dimensions.space2, horizontal: Dimensions.space5),
                                child: Center(child: Text(widget.catagories.questionsCount.toString() + MyStrings.questionse, style: regularDefault.copyWith(color: MyColor.colorGrey))),
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
                widget.catagories.quizInfos != null
                    ? ExpandedSection(
                        duration: 300,
                        expand: isExpande,
                        child: Column(
                          children: [
                            const CustomHorizontalDivider(),
                            Container(
                              color: MyColor.colorWhite,
                              padding: const EdgeInsets.all(Dimensions.space10),
                              child: GridView.builder(
                                  shrinkWrap: true,
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(childAspectRatio: 2.3, crossAxisCount: 3),
                                  itemCount: labelCount,
                                  itemBuilder: (BuildContext context, int index) {
                                    return Padding(
                                        padding: const EdgeInsets.symmetric(vertical: Dimensions.space5, horizontal: Dimensions.space5),
                                        child: InkWell(
                                          onTap: () {
                                            if (widget.catagories.quizInfos![index].playInfo != null) {
                                              Get.toNamed(
                                                RouteHelper.gessTheword,
                                                arguments: widget.catagories.quizInfos![index].id,
                                              );
                                            }
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(horizontal: Dimensions.space8, vertical: Dimensions.space8),
                                            decoration: BoxDecoration(color: widget.catagories.quizInfos![index].playInfo != null ? MyColor.completedlevel : MyColor.lockedLevel, borderRadius: BorderRadius.circular(Dimensions.space7), border: Border.all(color: widget.catagories.quizInfos![index].playInfo != null ? MyColor.completedlevel : MyColor.lockedLevel)),
                                            child: Row(
                                              children: [
                                                SvgPicture.asset(widget.catagories.quizInfos![index].playInfo != null ? MyImages.levelGreenTikSVG : MyImages.lockLevelSVG),
                                                const SizedBox(width: Dimensions.space4),
                                                Text(
                                                  widget.catagories.quizInfos![index].level!.title.toString(),
                                                  style: regularLarge.copyWith(color: MyColor.textColor),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ));
                                  }),
                            ),
                            // attention: view more logic
                            widget.catagories.quizInfos!.length > 3
                                ? GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        labelCount = widget.catagories.quizInfos!.length;
                                      });
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.only(bottom: Dimensions.space20),
                                      child: CustomTextWithUndeline(
                                        text: MyStrings.viewMore,
                                      ),
                                    ),
                                  )
                                : const SizedBox.shrink(),
                          ],
                        ),
                      )
                    : const SizedBox.shrink()
              ],
            )),
      ),
    );
  }
}
