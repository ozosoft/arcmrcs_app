import 'package:flutter/material.dart';
import 'package:flutter_prime/core/route/route.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_images.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/core/utils/style.dart';
import 'package:flutter_prime/data/controller/all_categories/all_categories_controller.dart';
import 'package:flutter_prime/data/repo/allcategories/all_categories_repo.dart';
import 'package:flutter_prime/data/services/api_service.dart';
import 'package:flutter_prime/view/components/animated_widget/expanded_widget.dart';
import 'package:flutter_prime/view/components/custom_loader/custom_loader.dart';
import 'package:flutter_prime/view/components/divider/custom_horizontal_divider.dart';
import 'package:flutter_prime/view/components/text/custom_text_with_underline.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ExpandedSections extends StatefulWidget {
  final int categoryindex;
  final bool isExpand;
  final String title;
  const ExpandedSections({super.key, required this.categoryindex, required this.isExpand, required this.title});

  @override
  State<ExpandedSections> createState() => _ExpandedSectionsState();
}

class _ExpandedSectionsState extends State<ExpandedSections> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(AllCategoriesRepo(apiClient: Get.find()));
    Get.put(AllCategoriesController(
      allCategoriesRepo: Get.find(),
    ));
    AllCategoriesController controller = Get.put(AllCategoriesController(allCategoriesRepo: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getdata();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AllCategoriesController>(
      builder: (controller) => controller.loader
          ? const CustomLoader()
          : ExpandedSection(
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
                        itemCount: controller.allCategoriesList[widget.categoryindex].quizInfos!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                              padding: const EdgeInsets.symmetric(vertical: Dimensions.space5, horizontal: Dimensions.space5),
                              child: InkWell(
                                onTap: () {
                                  Get.toNamed(RouteHelper.quizQuestionsScreen, arguments: [widget.title, controller.allCategoriesList[widget.categoryindex].quizInfos![index].id]);
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.space8, vertical: Dimensions.space8),
                                  decoration: BoxDecoration(
                                      color: controller.allCategoriesList[widget.categoryindex].quizInfos![index].playInfo != null ? MyColor.completedlevel : MyColor.lockedLevel, borderRadius: BorderRadius.circular(Dimensions.space7), border: Border.all(color: controller.allCategoriesList[widget.categoryindex].quizInfos![index].playInfo != null ? MyColor.completedlevel : MyColor.lockedLevel)),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(controller.allCategoriesList[widget.categoryindex].quizInfos![index].playInfo != null ? MyImages.levelGreenTikSVG : MyImages.lockLevelSVG),
                                      const SizedBox(width: Dimensions.space4),
                                      Text(
                                        controller.allCategoriesList[widget.categoryindex].quizInfos![index].level!.title.toString(),
                                        style: regularLarge.copyWith(
                                            // color: textcolor
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ));
                        }),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: Dimensions.space20),
                    child: CustomTextWithUndeline(
                      text: MyStrings.viewMore,
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
