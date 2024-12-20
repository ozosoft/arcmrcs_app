import 'package:flutter/material.dart';
import 'package:quiz_lab/core/route/route.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';
import 'package:quiz_lab/core/utils/my_color.dart';
import 'package:quiz_lab/core/utils/my_images.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/core/utils/style.dart';
import 'package:quiz_lab/data/controller/all_audio_sub_category/all_audio_sub_category_conntroller.dart';
import 'package:quiz_lab/data/controller/sub_categories/sub_categories_controller.dart';
import 'package:quiz_lab/data/controller/true_false_sub_category/true_false_sub_category_controller.dart';
import 'package:quiz_lab/view/components/animated_widget/expanded_widget.dart';
import 'package:quiz_lab/view/components/divider/custom_horizontal_divider.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';



class TrueFalseSectionSubCategoriesLabelSection extends StatelessWidget {
  final int categoryindex;
  final bool isExpand;
  final String title;
  final TrueFalseSubcategory? controller;
  const TrueFalseSectionSubCategoriesLabelSection({super.key, required this.categoryindex, required this.isExpand, required this.title, this.controller});

  @override
  Widget build(BuildContext context) {
    return ExpandedSection(
      duration: 300,
      expand: isExpand,
      child: Column(
        children: [
          const CustomHorizontalDivider(),
          Container(
            color: MyColor.colorWhite,
            padding: const EdgeInsets.all(Dimensions.space10),
            child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(childAspectRatio: context.width > 600 ? 3 : 2.3, crossAxisCount: 3),
                itemCount: controller!.subCategoriesList[categoryindex].quizInfos!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: Dimensions.space5, horizontal: Dimensions.space5),
                    child: InkWell(
                      onTap: () {
                        if (controller!.subCategoriesList[categoryindex].quizInfos![index].levelStatus == MyStrings.unlock) {
                             print("rhis is quiz in>>>>>>>>>>>>>>>>>${controller!.subCategoriesList[categoryindex].quizInfos![index].id}");
                         Get.toNamed(RouteHelper.trueFalseQuestionsScreen, arguments: [title, controller!.subCategoriesList[categoryindex].quizInfos![index].id]);
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: Dimensions.space8, vertical: Dimensions.space8),
                        decoration: BoxDecoration(
                            color: controller!.subCategoriesList[categoryindex].quizInfos![index].levelStatus == MyStrings.lock
                                ? MyColor.lockedLevel
                                : controller!.subCategoriesList[categoryindex].quizInfos![index].playInfo != null && controller!.subCategoriesList[categoryindex].quizInfos![index].playInfo?.isWin =='1'
                                    ? MyColor.completedlevel
                                    : MyColor.unlockedLevel,
                            borderRadius: BorderRadius.circular(Dimensions.space7),
                            border: Border.all(color: controller!.subCategoriesList[categoryindex].quizInfos![index].playInfo != null && controller!.subCategoriesList[categoryindex].quizInfos![index].playInfo?.isWin =='1'? MyColor.completedlevel : MyColor.lockedLevel)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(controller!.subCategoriesList[categoryindex].quizInfos![index].levelStatus == MyStrings.lock
                                ? MyImages.lockLevelSVG
                                : controller!.subCategoriesList[categoryindex].quizInfos![index].playInfo != null && controller!.subCategoriesList[categoryindex].quizInfos![index].playInfo?.isWin =='1'
                                    ? MyImages.levelGreenTikSVG
                                    : MyImages.unlockSVG),
                            const SizedBox(width: Dimensions.space5),
                            Expanded(
                              child: Text(
                                controller!.subCategoriesList[categoryindex].quizInfos![index].level!.title.toString(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: regularLarge.copyWith(
                                  color: controller!.subCategoriesList[categoryindex].quizInfos![index].levelStatus == MyStrings.lock
                                      ? MyColor.textColor
                                      : controller!.subCategoriesList[categoryindex].quizInfos![index].playInfo != null && controller!.subCategoriesList[categoryindex].quizInfos![index].playInfo?.isWin =='1'
                                          ? MyColor.completedlevelTEXT
                                          : MyColor.colorBlack,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ));
                }),
          ),
        ],
      ),
    );
  }
}
