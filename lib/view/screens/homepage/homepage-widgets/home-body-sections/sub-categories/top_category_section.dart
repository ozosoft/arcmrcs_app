import 'package:flutter/material.dart';
import 'package:flutter_prime/core/route/route.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_images.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/core/utils/style.dart';
import 'package:flutter_prime/core/utils/url_container.dart';
import 'package:flutter_prime/data/controller/dashboard/dashboard_controller.dart';
import 'package:flutter_prime/data/controller/sub_categories/sub_categories_controller.dart';
import 'package:flutter_prime/data/repo/dashboard/dashboard_repo.dart';
import 'package:flutter_prime/data/repo/sub_categories/sub_categories_repo.dart';
import 'package:flutter_prime/data/services/api_service.dart';
import 'package:get/get.dart';
import '../../../../../components/category-card/custom_top_category_card.dart';

class TopCategorySection extends StatefulWidget {
  const TopCategorySection({super.key});

  @override
  State<TopCategorySection> createState() => _TopCategorySectionState();
}

class _TopCategorySectionState extends State<TopCategorySection> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(DashBoardRepo(apiClient: Get.find()));
    Get.put(DashBoardController(dashRepo: Get.find()));
    Get.put(SubCategoriesRepo(apiClient: Get.find()));
    Get.put(SubCategoriesController(subCategoriesRepo: Get.find()));
    SubCategoriesController controllers =
        Get.put(SubCategoriesController(subCategoriesRepo: Get.find()));
    DashBoardController controller =
        Get.put(DashBoardController(dashRepo: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getdata();
    });
  }

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
                          const Text(
                            MyStrings.topCategory,
                            style: semiBoldMediumLarge,
                          ),
                          InkWell(
                              onTap: () {
                                Get.toNamed(RouteHelper.allCategories);
                              },
                              child: Text(
                                MyStrings.viewAll,
                                style: semiBoldLarge.copyWith(
                                    color: MyColor.colorlighterGrey,
                                    fontSize: Dimensions.space15),
                              )),
                        ],
                      ),
                    ),
                  ),
                  GetBuilder<SubCategoriesController>(
                    builder: (controllers) => GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3, childAspectRatio: .8),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.categorylist.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              Get.toNamed(
                                RouteHelper.subCategories,
                                arguments: [
                                  controller.categorylist[index].name
                                      .toString(),
                                  controller.categorylist[index].id.toString()
                                ],
                              );
                              controllers.changeExpandIndex(index);
                            },
                            child: CustomTopCategoryCard(
                              index: index,
                              title: controller.categorylist[index].name
                                  .toString(),
                              questionsQuantaty: controller
                                  .categorylist[index].questionsCount
                                  .toString(),
                              image: UrlContainer.dashBoardCategoryImage +
                                  controller.categorylist[index].image
                                      .toString(),
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
