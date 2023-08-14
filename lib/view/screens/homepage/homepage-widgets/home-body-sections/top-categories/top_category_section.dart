import 'package:flutter/material.dart';
import 'package:flutter_prime/core/route/route.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_images.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/core/utils/style.dart';
import 'package:get/get.dart';
import '../../../../../components/category-card/custom_top_category_card.dart';

class TopCategorySection extends StatefulWidget {
  const TopCategorySection({super.key});

  @override
  State<TopCategorySection> createState() => _TopCategorySectionState();
}

class _TopCategorySectionState extends State<TopCategorySection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin:const EdgeInsets.symmetric(horizontal: Dimensions.space5),
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
                              style: semiBoldLarge.copyWith(color: MyColor.colorlighterGrey,fontSize: Dimensions.space15),
                            )
                          ),
                      ],
                    ),
                  ),
                ),
                FittedBox(
                  fit: BoxFit.cover,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.toNamed(
                            RouteHelper.topCategories,
                            arguments: MyStrings.generalKnowledge,
                          );
                        },
                        child: const CustomTopCategoryCard(
                          title: MyStrings.generalKnowledge,
                          questionsQuantaty: MyStrings.quantity,
                          image: MyImages.knowledgeSVG,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.toNamed(RouteHelper.topCategories,arguments: MyStrings.gameandSports);},
                        child: const CustomTopCategoryCard(
                          title: MyStrings.gameandSports,
                          questionsQuantaty: MyStrings.quantity,
                          image: MyImages.sportsCategorySVG,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.toNamed(RouteHelper.topCategories,arguments: MyStrings.historyAndCulture);},
                        child: const CustomTopCategoryCard(
                          title: MyStrings.historyAndCulture,
                          questionsQuantaty: MyStrings.quantity,
                          image: MyImages.historySVG,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
