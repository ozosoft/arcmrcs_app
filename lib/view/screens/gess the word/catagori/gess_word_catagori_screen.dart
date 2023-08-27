import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_prime/core/route/route.dart';
import 'package:flutter_prime/data/controller/gesstheword/gess_the_word_Controller.dart';
import 'package:flutter_prime/data/repo/gess_the_word/gessThewordRepo.dart';
import 'package:flutter_prime/data/services/api_service.dart';

import 'package:flutter_prime/view/components/app-bar/custom_appbar.dart';
import 'package:flutter_prime/view/components/custom_loader/custom_loader.dart';
import 'package:flutter_prime/view/components/snack_bar/show_custom_snackbar.dart';
import 'package:flutter_prime/view/screens/gess%20the%20word/catagori/widget/gess_catagori_card.dart';
import 'package:get/get.dart';

class GestheWordCatagoriScreen extends StatefulWidget {
  const GestheWordCatagoriScreen({super.key});

  @override
  State<GestheWordCatagoriScreen> createState() => _GestheWordCatagoriScreenState();
}

class _GestheWordCatagoriScreenState extends State<GestheWordCatagoriScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(GessTheWordRepo(apiClient: Get.find()));
    final controller = Get.put(GessThewordController(gessTheWordRepo: Get.find()));
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getAllcataroy();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Select Catagroi'),
      body: GetBuilder<GessThewordController>(builder: (controller) {
        return controller.isLoading
            ? const CustomLoader()
            : ListView.builder(
                itemCount: controller.catagoriList.length,
                itemBuilder: (context, i) {
                  return GessCatagroiCard(
                    catagories: controller.catagoriList[i],
                    image: '${controller.imgPath}/${controller.catagoriList[i].image}',
                  );
                },
              );
      }),
    );
  }
}
