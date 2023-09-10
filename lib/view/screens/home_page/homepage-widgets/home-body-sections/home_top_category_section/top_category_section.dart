import 'package:flutter/material.dart';
import 'package:flutter_prime/core/route/route.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/core/utils/style.dart';
import 'package:flutter_prime/core/utils/url_container.dart';
import 'package:flutter_prime/data/controller/dashboard/dashboard_controller.dart';
import 'package:flutter_prime/data/controller/sub_categories/sub_categories_controller.dart';
import 'package:get/get.dart';
import '../../../../../components/category-card/custom_top_category_card.dart';

class TopCategorySection extends StatefulWidget {
  const TopCategorySection({super.key});

  @override
  State<TopCategorySection> createState() => _TopCategorySectionState();
}

class _TopCategorySectionState extends State<TopCategorySection> {
  @override


  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashBoardController>(
      builder: (controller) => Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: Dimensions.space5),
            decoration: BoxDecoration(
              color: MyColor.colorWhite,
              borderRadius: BorderRadius.circular(Dimensions.space10),
              boxShadow: const [
                BoxShadow(
                  color: MyColor.cardShaddowColor2,
                  offset: Offset(0, 8),
                  blurRadius: 60,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(Dimensions.space12),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(Dimensions.space5),
                    child: SizedBox(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                           Text(
                            MyStrings.topCategory.tr,
                            style: semiBoldMediumLarge,
                          ),
                          InkWell(
                            onTap: () {
                              Get.toNamed(RouteHelper.allCategories);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(Dimensions.space5),
                              child: Text(
                                MyStrings.viewAll.tr,
                                style: semiBoldLarge.copyWith(color: MyColor.colorlighterGrey, fontSize: Dimensions.space15),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: Dimensions.space15,
                  ),
                  GetBuilder<SubCategoriesController>(
                    builder: (controllers) => GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: context.isLandscape ? 5 : 3, childAspectRatio: .7),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.categorylist.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              Get.toNamed(
                                RouteHelper.subCategories,
                                arguments: [controller.categorylist[index].name.toString(), controller.categorylist[index].id.toString()],
                              );
                              controllers.changeExpandIndex(index);
                            },
                            child: CustomTopCategoryCard(
                              index: index,
                              title: controller.categorylist[index].name.toString(),
                              questionsQuantaty: controller.categorylist[index].questionsCount.toString(),
                              image: UrlContainer.dashBoardCategoryImage + controller.categorylist[index].image.toString(),
                            ),
                          );
                        }),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
