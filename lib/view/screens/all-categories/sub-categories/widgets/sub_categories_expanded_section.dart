import 'package:flutter/material.dart';
import 'package:flutter_prime/core/route/route.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_images.dart';
import 'package:flutter_prime/core/utils/style.dart';
import 'package:flutter_prime/view/components/animated_widget/expanded_widget.dart';
import 'package:flutter_prime/view/components/divider/custom_horizontal_divider.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../data/controller/sub_categories/sub_categories_controller.dart';

class SubCategoriesExpandedSection extends StatelessWidget {
  final int categoryindex;
  final bool isExpand;
  final String title;
  final SubCategoriesController? controller;
  const SubCategoriesExpandedSection({super.key, required this.categoryindex, required this.isExpand, required this.title, this.controller});

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
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(childAspectRatio: 2.3, crossAxisCount: 3),
                itemCount: controller!.subCategoriesList[categoryindex].quizInfos!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                      padding: const EdgeInsets.symmetric(vertical: Dimensions.space5, horizontal: Dimensions.space5),
                      child: InkWell(
                        onTap: () {
                          Get.toNamed(RouteHelper.quizQuestionsScreen, arguments: [title, controller!.subCategoriesList[categoryindex].quizInfos![index].id]);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: Dimensions.space8, vertical: Dimensions.space8),
                          decoration: BoxDecoration(color: controller!.subCategoriesList[categoryindex].quizInfos![index].playInfo != null ? MyColor.completedlevel : MyColor.lockedLevel, borderRadius: BorderRadius.circular(Dimensions.space7), border: Border.all(color: controller!.subCategoriesList[categoryindex].quizInfos![index].playInfo != null ? MyColor.completedlevel : MyColor.lockedLevel)),
                          child: Row(
                            children: [
                              SvgPicture.asset(controller!.subCategoriesList[categoryindex].quizInfos![index].playInfo != null ? MyImages.levelGreenTikSVG : MyImages.lockLevelSVG),
                              const SizedBox(width: Dimensions.space4),
                              Text(
                                controller!.subCategoriesList[categoryindex].quizInfos![index].level!.title.toString(),
                                style: regularLarge,
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
