import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/data/controller/gesstheword/gess_the_word_Controller.dart';
import 'package:flutter_prime/data/repo/gess_the_word/gessThewordRepo.dart';
import 'package:flutter_prime/data/services/api_service.dart';
import 'package:flutter_prime/view/components/app-bar/custom_category_appBar.dart';
import 'package:flutter_prime/view/components/custom_loader/custom_loader.dart';
import 'package:flutter_prime/view/screens/gess%20the%20word/result/widget/result_body.dart';
import 'package:get/get.dart';

class GessWordResultScreen extends StatefulWidget {
  const GessWordResultScreen({super.key});

  @override
  State<GessWordResultScreen> createState() => _GessWordResultScreenState();
}

class _GessWordResultScreenState extends State<GessWordResultScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(GessTheWordRepo(apiClient: Get.find()));
    Get.put(GessThewordController(gessTheWordRepo: Get.find()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Scaffold(
          backgroundColor: MyColor.primaryColor,
          appBar: const CustomCategoryAppBar(title: MyStrings.quizResult),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.space15, vertical: Dimensions.space50),
              child: GetBuilder<GessThewordController>(builder: (controller) {
                return controller.isLoading ? const CustomLoader() : const GessResultBody();
              }),
            ),
          )),
    );
  }
}
