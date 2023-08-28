import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/view/components/expanded_widget/expanded_widget.dart';
import 'package:flutter_prime/view/screens/all-categories/widgets/allCategories_expanded_section.dart';
import 'package:flutter_prime/view/screens/play_diffrent/fun_n_learn/widgets/expanded_section_for_level.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/my_color.dart';
import '../../../core/utils/my_images.dart';
import '../../../core/utils/style.dart';

class CategoriesCard extends StatefulWidget {
  final String title, questions, image, levels, minute, marks, date, subCategoryId;
  final bool expansionVisible, fromViewAll, fromBookmark, fromExam, fromFunNlearn, fromAllCategory;
  final bool isExpand;
  final int index;

  const CategoriesCard({super.key, required this.title, this.questions = "", this.image = "", this.subCategoryId = "", this.expansionVisible = false, this.fromFunNlearn = false, this.fromAllCategory = false, this.fromBookmark = false, required this.fromViewAll, this.levels = "1", this.fromExam = false, this.minute = "", this.marks = "", this.isExpand = false, required this.index, this.date = ""});
  @override
  State<CategoriesCard> createState() => _CategoriesCardState();
}

class _CategoriesCardState extends State<CategoriesCard> {
  @override
  Widget build(BuildContext context) {
    print("this is from expand++++++++++++++++++++++++++++++++" + widget.fromAllCategory.toString()+ widget.expansionVisible.toString()+widget.fromFunNlearn.toString());
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.space12, vertical: Dimensions.space8),
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
                  widget.image.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(top: Dimensions.space20, bottom: Dimensions.space20),
                          child: Image.network(
                            widget.image ?? "",
                            height: Dimensions.space40,
                          ),
                        )
                      :const SizedBox(),
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
                            widget.fromViewAll == false
                                ? Container(
                                    decoration: BoxDecoration(color: MyColor.cardColor, borderRadius: BorderRadius.circular(Dimensions.space3), border: Border.all(color: MyColor.colorDarkGrey, width: 0.3)),
                                    padding: const EdgeInsets.symmetric(vertical: Dimensions.space2, horizontal: Dimensions.space5),
                                    child: Center(child: Text(widget.fromExam ? widget.marks : widget.levels, style: regularDefault.copyWith(color: MyColor.colorGrey))),
                                  )
                                : const SizedBox(),
                            const SizedBox(width: Dimensions.space10),
                            Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.space3), color: MyColor.cardColor, border: Border.all(color: MyColor.colorDarkGrey, width: 0.3)),
                              padding: const EdgeInsets.symmetric(vertical: Dimensions.space2, horizontal: Dimensions.space5),
                              child: Center(child: Text(widget.fromExam ? widget.date : widget.questions + MyStrings.questionse, style: regularDefault.copyWith(color: MyColor.colorGrey))),
                            ),
                            const SizedBox(width: Dimensions.space10),
                            widget.fromExam
                                ? Container(
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.space3), color: MyColor.cardColor, border: Border.all(color: MyColor.colorDarkGrey, width: 0.3)),
                                    padding: const EdgeInsets.symmetric(vertical: Dimensions.space2, horizontal: Dimensions.space5),
                                    child: Center(child: Text(widget.fromExam ? widget.minute : widget.questions, style: regularDefault.copyWith(color: MyColor.colorGrey))),
                                  )
                                : const SizedBox(),
                            widget.fromViewAll == false
                                ? Align(
                                    alignment: Alignment.topCenter,
                                    child: widget.fromExam ? const SizedBox() : SvgPicture.asset(widget.fromBookmark ? MyImages.deleteSVG : MyImages.bookmarkSVG, height: Dimensions.space20),
                                  )
                                : const SizedBox(),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  widget.fromExam
                      ? const SizedBox()
                      : Padding(
                          padding: const EdgeInsets.only(top: Dimensions.space20),
                          child: SvgPicture.asset(widget.isExpand ? MyImages.arrowDownSVG : MyImages.playSVG, height: Dimensions.space35),
                        ),
                  const SizedBox(width: Dimensions.space20),
                ],
              ),
              SizedBox(height: widget.expansionVisible ? Dimensions.space3 : Dimensions.space10),
              widget.expansionVisible
                  ? ExpandedSections(
                      categoryindex: widget.index,
                      isExpand: widget.isExpand,
                      title: widget.title,
                    )
                  : widget.fromFunNlearn
                      ? FunNLearnExpandedSections(
                          categoryindex: widget.index,
                          isExpand: widget.isExpand,
                          title: widget.title,
                        )
                      : widget.fromViewAll
                          ? AllCategoriesExpandedSection(
                              categoryindex: widget.index,
                              isExpand: widget.isExpand,
                              title: widget.title,
                            )
                          : const SizedBox(),
              const SizedBox(
                height: Dimensions.space5,
              )
            ],
          )),
    );
  }
}
