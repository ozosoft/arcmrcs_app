import 'package:flutter/material.dart';
import 'package:quiz_lab/data/controller/gesstheword/gess_the_word_Controller.dart';
import 'package:quiz_lab/data/repo/gess_the_word/gessThewordRepo.dart';
import 'package:quiz_lab/data/services/api_service.dart';
import 'package:quiz_lab/view/components/custom_loader/custom_loader.dart';
import 'package:quiz_lab/view/screens/guess_the_word/sub_category/widget/guess_word_sub_cat_card.dart';
import 'package:get/get.dart';

import '../../../../core/utils/my_strings.dart';
import '../../../components/app-bar/custom_category_appBar.dart';

class GuessWordSubCategoryScreen extends StatefulWidget {
  const GuessWordSubCategoryScreen({super.key});

  @override
  State<GuessWordSubCategoryScreen> createState() => _GuessWordSubCategoryScreenState();
}

class _GuessWordSubCategoryScreenState extends State<GuessWordSubCategoryScreen> {
  int id = 0;
  @override
  void initState() {
    id = Get.arguments;
    super.initState();
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(GuessTheWordRepo(apiClient: Get.find()));
    final controller = Get.put(GuessThewordController(gessTheWordRepo: Get.find()));
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getAllsubcategories(id.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomCategoryAppBar(
        title: MyStrings.subcategory.tr,
      ),
      body: GetBuilder<GuessThewordController>(builder: (controller) {
        return controller.isLoading
            ? const CustomLoader()
            : ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: controller.subCategories.length,
                itemBuilder: (context, index) {
                  return GuessWordSubCategoryCard(
                    subcategory: controller.subCategories[index],
                    image: '${controller.subImgPath}/${controller.subCategories[index].image}',
                  );
                },
              );
      }),
    );
  }
}
