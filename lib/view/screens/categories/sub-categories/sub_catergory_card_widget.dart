import 'package:flutter/material.dart';
import 'package:flutter_prime/core/route/route.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_images.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/core/utils/style.dart';
import 'package:flutter_prime/view/components/animated_widget/expanded_widget.dart';
import 'package:flutter_prime/view/components/card/custom_card.dart';
import 'package:flutter_prime/view/components/card/info_outlined_card.dart';
import 'package:flutter_prime/view/components/divider/custom_horizontal_divider.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter_prime/data/model/sub_categories/sub_categories_model.dart';

import 'SubCategoryLevelList.dart';

class SubCategoriesListItem extends StatefulWidget {
  final String title, questions, image, subCategoryId;
  // final bool  fromAllCategory;
  final bool isExpand;
  final int index;
  final List<QuizInfo> levelList;

  const SubCategoriesListItem({super.key, required this.levelList, required this.title, this.questions = "", this.image = "", this.subCategoryId = "", this.isExpand = false, required this.index});
  @override
  State<SubCategoriesListItem> createState() => _SubCategoriesListItemState();
}

class _SubCategoriesListItemState extends State<SubCategoriesListItem> {
  @override
  Widget build(BuildContext context) {
    return CustomCard(
        marginBottom: Dimensions.cardMargin,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: Dimensions.space3),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(width: Dimensions.space20),
                widget.image.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(top: Dimensions.space20, bottom: Dimensions.space20),
                        child: Image.network(
                          widget.image ?? "",
                          height: Dimensions.space40,
                        ),
                      )
                    : const SizedBox(),
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
                          Visibility(
                            visible: widget.subCategoryId == '',
                            child: InfoOutlinedCard(text: '${MyStrings.level.tr} ${widget.levelList.length}'),
                          ),
                          SizedBox(width: widget.subCategoryId != '' ? 0 : Dimensions.space10),
                          InfoOutlinedCard(text: widget.questions + MyStrings.questionse.tr),
                        ],
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(top: Dimensions.space20),
                  child: SvgPicture.asset(widget.isExpand ? MyImages.arrowDownSVG : MyImages.playSVG, height: Dimensions.space35),
                ),
                const SizedBox(width: Dimensions.space20),
              ],
            ),
            const SizedBox(height: Dimensions.space3),
            widget.subCategoryId != "null"
                ? ExpandedSection(
                    duration: 300,
                    expand: widget.isExpand,
                    child: Column(
                      children: [
                        const CustomHorizontalDivider(),
                        Container(
                          color: MyColor.colorWhite,
                          padding: const EdgeInsets.all(Dimensions.space10),
                          child: GridView.builder(
                              shrinkWrap: true,
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(childAspectRatio: 2.3, crossAxisCount: 3),
                              itemCount: widget.levelList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return SubCategoryLevelListCard(
                                  press: () {
                                    Get.toNamed(RouteHelper.quizQuestionsScreen, arguments: [widget.title, widget.levelList[index].id]);
                                  },
                                  levelName: widget.levelList[index].level?.title ?? '',
                                  isLocked: widget.levelList[index].playInfo != null,
                                  isAlreadyPlayed: widget.levelList[index].playInfo != null && widget.levelList[index].playInfo?.isWin == '1',
                                );
                              }),
                        ),
                      ],
                    ),
                  )
                : const SizedBox(),
            const SizedBox(
              height: Dimensions.space5,
            )
          ],
        ));
  }
}
