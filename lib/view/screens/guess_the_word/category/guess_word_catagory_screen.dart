import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/data/controller/gesstheword/gess_the_word_Controller.dart';
import 'package:flutter_prime/data/repo/gess_the_word/gessThewordRepo.dart';
import 'package:flutter_prime/data/services/api_service.dart';

import 'package:flutter_prime/view/components/app-bar/custom_category_appBar.dart';
import 'package:flutter_prime/view/components/custom_loader/custom_loader.dart';
import 'package:flutter_prime/view/screens/guess_the_word/category/widget/guess_category_card.dart';
import 'package:get/get.dart';

import '../../../../core/utils/my_color.dart';
import '../../../components/no_data.dart';

class GestheWordCategoryScreen extends StatefulWidget {
  const GestheWordCategoryScreen({super.key});

  @override
  State<GestheWordCategoryScreen> createState() => _GestheWordCategoryScreenState();
}

class _GestheWordCategoryScreenState extends State<GestheWordCategoryScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(GuessTheWordRepo(apiClient: Get.find()));
    final controller = Get.put(GuessThewordController(gessTheWordRepo: Get.find()));
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getAllcataroy();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.colorWhite,
      appBar: const CustomCategoryAppBar(title: MyStrings.allCategory),
      body: GetBuilder<GuessThewordController>(builder: (controller) {
        return controller.isLoading
            ? const CustomLoader()
            : controller.categoryList.isEmpty
                ? const NoDataWidget(
                    messages: MyStrings.sorryNoCategory,
                  )
                : ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: controller.categoryList.length,
                    itemBuilder: (context, i) {
                      return GuessCategoryCard(
                        categories: controller.categoryList[i],
                        image: '${controller.imgPath}/${controller.categoryList[i].image}',
                      );
                    },
                  );
      }),
    );
  }
}
