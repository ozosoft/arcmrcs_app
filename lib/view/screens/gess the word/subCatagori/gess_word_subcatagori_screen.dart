import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_prime/core/route/route.dart';
import 'package:flutter_prime/data/controller/gesstheword/gess_the_word_Controller.dart';
import 'package:flutter_prime/data/repo/gess_the_word/gessThewordRepo.dart';
import 'package:flutter_prime/data/services/api_service.dart';
import 'package:flutter_prime/view/components/app-bar/custom_appbar.dart';
import 'package:flutter_prime/view/components/custom_loader/custom_loader.dart';
import 'package:flutter_prime/view/screens/gess%20the%20word/catagori/widget/gess_catagori_card.dart';
import 'package:flutter_prime/view/screens/gess%20the%20word/subCatagori/widget/gess_word_subCat_card.dart';
import 'package:get/get.dart';

class GessWordSubCatagoriScreen extends StatefulWidget {
  const GessWordSubCatagoriScreen({super.key});

  @override
  State<GessWordSubCatagoriScreen> createState() => _GessWordSubCatagoriScreenState();
}

class _GessWordSubCatagoriScreenState extends State<GessWordSubCatagoriScreen> {
  int id = 0;
  @override
  void initState() {
    id = Get.arguments;
    super.initState();
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(GessTheWordRepo(apiClient: Get.find()));
    final controller = Get.put(GessThewordController(gessTheWordRepo: Get.find()));
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getAllsubcatagories(id.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Sub-catagories', isShowBackBtn: true),
      body: GetBuilder<GessThewordController>(builder: (controller) {
        return controller.isLoading
            ? const CustomLoader()
            : ListView.builder(
                itemCount: controller.subCatagories.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // Get.toNamed(RouteHelper.gessTheword, arguments: controller.subCatagories[index].id);
                    },
                    child: GessWordSubCatagoriCard(
                      subcategory: controller.subCatagories[index],
                      //attention: change img base url
                      image: 'https://url8.viserlab.com/quizlab/assets/admin/images/subcategory/${controller.subCatagories[index].image}',
                    ),
                  );
                },
              );
      }),
    );
  }
}
