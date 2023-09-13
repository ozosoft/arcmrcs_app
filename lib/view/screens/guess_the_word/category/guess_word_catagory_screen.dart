import 'package:flutter/material.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/data/controller/gesstheword/gess_the_word_Controller.dart';
import 'package:quiz_lab/data/repo/gess_the_word/gessThewordRepo.dart';
import 'package:quiz_lab/data/services/api_service.dart';

import 'package:quiz_lab/view/components/app-bar/custom_category_appBar.dart';
import 'package:quiz_lab/view/components/custom_loader/custom_loader.dart';
import 'package:quiz_lab/view/screens/guess_the_word/category/widget/guess_category_card.dart';
import 'package:get/get.dart';

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
      appBar: CustomCategoryAppBar(title: MyStrings.allCategory.tr),
      body: GetBuilder<GuessThewordController>(builder: (controller) {
        return controller.isLoading
            ? const CustomLoader()
            : controller.categoryList.isEmpty
                ? NoDataWidget(
                    messages: MyStrings.sorryNoCategory.tr,
                  )
                : Padding(
                    padding: const EdgeInsetsDirectional.only(top: Dimensions.space20),
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: controller.categoryList.length,
                      itemBuilder: (context, i) {
                        return GuessCategoryCard(
                          categories: controller.categoryList[i],
                          image: '${controller.imgPath}/${controller.categoryList[i].image}',
                        );
                      },
                    ),
                  );
      }),
    );
  }
}
