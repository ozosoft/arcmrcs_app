import 'package:flutter/material.dart';
import 'package:flutter_prime/core/route/route.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_images.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/view/components/app-bar/custom_category_appBar.dart';
import 'package:get/get.dart';
import '../../components/category-card/categories_card.dart';

class AllCategoriesScreen extends StatefulWidget {
  const AllCategoriesScreen({super.key});

  @override
  State<AllCategoriesScreen> createState() => _AllCategoriesScreenState();
}

class _AllCategoriesScreenState extends State<AllCategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomCategoryAppBar(title: MyStrings.allCategory),
      body: SingleChildScrollView(
        physics:const ScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListView.builder(
              physics:const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.only(top: Dimensions.space25),
                shrinkWrap: true,
                itemCount: MyStrings().allCategoryies.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                          Get.toNamed(RouteHelper.topCategories,arguments: MyStrings().allCategoryies[index]["title"].toString());},
                    child: CategoriesCard(
                      title:MyStrings().allCategoryies[index]["title"].toString(),
                      questions: MyStrings()
                          .allCategoryies[index]["questions"]
                          .toString(),
                      image: MyImages().categoryImages[index],
                      expansionVisible: false,
                      fromViewAll: true,
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
