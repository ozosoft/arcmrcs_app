import 'package:flutter/material.dart';
import 'package:flutter_prime/core/route/route.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/my_color.dart';
import '../../../core/utils/my_images.dart';
import '../../../core/utils/style.dart';
import '../animated_widget/expanded_widget.dart';
import '../divider/custom_horizontal_divider.dart';
import '../text/custom_text_with_underline.dart';

class CategoriesCard extends StatefulWidget {
  final String title, questions, image, levels;
  final bool expansionVisible, fromViewAll, fromBookmark;

  const CategoriesCard(
      {super.key,
      required this.title,
      required this.questions,
      required this.image,
      this.expansionVisible = false,
      this.fromBookmark = false,
      required this.fromViewAll,
      this.levels = "1"});

  @override
  State<CategoriesCard> createState() => _CategoriesCardState();
}

class _CategoriesCardState extends State<CategoriesCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.space12, vertical: Dimensions.space10),
      child: InkWell(
        onTap: () {
          setState(() {
            isExpanded = !isExpanded;
            Get.toNamed(RouteHelper.topCategories,
                arguments: widget.title);
          });
        },
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
                    Padding(
                      padding: const EdgeInsets.only(
                          top: Dimensions.space20, bottom: Dimensions.space20),
                      child: SvgPicture.asset(
                        widget.image,
                        height: Dimensions.space40,
                      ),
                    ),
                    const SizedBox(
                      width: Dimensions.space30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: Dimensions.space15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.title,
                            style: semiBoldMediumLarge,
                          ),
                          const SizedBox(height: Dimensions.space12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              widget.fromViewAll == false
                                  ? Container(
                                      decoration: BoxDecoration(
                                          color: MyColor.cardColor,
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.space3),
                                          border: Border.all(
                                              color: MyColor.colorDarkGrey,
                                              width: 0.3)),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: Dimensions.space2,
                                          horizontal: Dimensions.space5),
                                      child: Center(
                                          child: Text(widget.levels,
                                              style: regularDefault.copyWith(
                                                  color: MyColor.colorGrey))),
                                    )
                                  : const SizedBox(),
                              const SizedBox(width: Dimensions.space10),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.space3),
                                    color: MyColor.cardColor,
                                    border: Border.all(
                                        color: MyColor.colorDarkGrey,
                                        width: 0.3)),
                                padding: const EdgeInsets.symmetric(
                                    vertical: Dimensions.space2,
                                    horizontal: Dimensions.space5),
                                child: Center(
                                    child: Text(widget.questions,
                                        style: regularDefault.copyWith(
                                            color: MyColor.colorGrey))),
                              ),
                              const SizedBox(width: Dimensions.space10),
                              widget.fromViewAll == false
                                  ? Align(
                                      alignment: Alignment.topCenter,
                                      child: SvgPicture.asset(
                                        widget.fromBookmark
                                            ? MyImages.deleteSVG
                                            : MyImages.bookmarkSVG,
                                        height: Dimensions.space20,
                                      ),
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(top: Dimensions.space20),
                      child: SvgPicture.asset(
                        isExpanded ? MyImages.arrowDownSVG : MyImages.playSVG,
                        height: Dimensions.space35,
                      ),
                    ),
                    const SizedBox(width: Dimensions.space20),
                  ],
                ),
                const SizedBox(height: Dimensions.space3),
                widget.expansionVisible
                    ? ExpandedSection(
                        duration: 300,
                        expand: isExpanded,
                        child: Column(
                          children: [
                            const CustomHorizontalDivider(),
                            Container(
                              color: MyColor.colorWhite,
                              padding: const EdgeInsets.all(Dimensions.space10),
                              child: GridView.builder(
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          childAspectRatio: 2.3,
                                          crossAxisCount: 3),
                                  itemCount: 6,
                                  itemBuilder: (BuildContext context, index) {
                                    Color bodycolor =
                                        MyColor().containerBodyColors[index %
                                            MyColor()
                                                .containerBodyColors
                                                .length];
                                    Color textcolor =
                                        MyColor().containertextColors[index %
                                            MyColor()
                                                .containertextColors
                                                .length];
                                    Color bordercolor =
                                        MyColor().containerBorderColors[index %
                                            MyColor()
                                                .containerBorderColors
                                                .length];
                                    return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: Dimensions.space5,
                                            horizontal: Dimensions.space5),
                                        child: InkWell(
                                          onTap: () {
                                            Get.toNamed(
                                              RouteHelper.quizQuestionsScreen,
                                              arguments: widget.title,
                                            );
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: Dimensions.space8,
                                                vertical: Dimensions.space8),
                                            decoration: BoxDecoration(
                                                color: bodycolor,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Dimensions.space7),
                                                border: Border.all(
                                                    color: bordercolor)),
                                            child: Row(
                                              children: [
                                                SvgPicture.asset(MyImages()
                                                    .containerimages[index]
                                                    .toString()),
                                                const SizedBox(
                                                    width: Dimensions.space4),
                                                Text(
                                                  MyStrings.level1,
                                                  style: regularLarge.copyWith(
                                                      color: textcolor),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ));
                                  }),
                            ),
                            const Padding(
                              padding:
                                  EdgeInsets.only(bottom: Dimensions.space20),
                              child: CustomTextWithUndeline(
                                text: MyStrings.viewMore,
                              ),
                            )
                          ],
                        ),
                      )
                    : SizedBox(),
              ],
            )),
      ),
    );
  }
}
