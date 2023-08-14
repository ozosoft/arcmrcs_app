import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_images.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/view/components/category-card/categories_card.dart';
import 'package:get/get.dart';
import '../../../../../components/app-bar/custom_category_appBar.dart';

class TopCategoriesCardScreen extends StatefulWidget {
  final String title;
  const TopCategoriesCardScreen({super.key, required this.title});

  @override
  State<TopCategoriesCardScreen> createState() =>
      _TopCategoriesCardScreenState();
}

class _TopCategoriesCardScreenState extends State<TopCategoriesCardScreen> {
  final title = Get.arguments as String;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomCategoryAppBar(
        title: title,
      ),
      body: SingleChildScrollView(
        physics:const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              ListView.builder(
                physics:const NeverScrollableScrollPhysics(),
                padding:const EdgeInsets.only(top: Dimensions.space25),
                shrinkWrap: true,
                itemCount: MyStrings().allCategoryies.length,
                itemBuilder: (BuildContext context, int index) {
                  return CategoriesCard(
                    title: MyStrings().subCategoryies[index]["title"].toString(),
                    questions: MyStrings().allCategoryies[index]["questions"].toString(),
                    image: MyImages().categoryImages[index],
                    expansionVisible: true,
                    fromViewAll: false,
                    levels: MyStrings().allCategoryies[index]["level"].toString(),
                  );
                }),
         ],
        ),
      ),
    );
  }
}
