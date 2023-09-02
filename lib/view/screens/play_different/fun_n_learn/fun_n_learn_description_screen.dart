import 'package:flutter/material.dart';
import 'package:flutter_prime/core/route/route.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/data/controller/play_different_quizes/fun_n_learn/fun_n_learn_description.dart';
import 'package:flutter_prime/data/controller/play_different_quizes/fun_n_learn/fun_n_learn_quiz_controller.dart';
import 'package:flutter_prime/data/repo/play_different_quizes/fun_n_learn/fun_n_learn_repo.dart';
import 'package:flutter_prime/data/services/api_service.dart';
import 'package:flutter_prime/view/components/app-bar/custom_appbar.dart';
import 'package:flutter_prime/view/components/app-bar/custom_category_appBar.dart';
import 'package:flutter_prime/view/components/buttons/rounded_button.dart';
import 'package:get/get.dart';

class FunNLearnDescription extends StatefulWidget {
  const FunNLearnDescription({super.key});

  @override
  State<FunNLearnDescription> createState() => _FunNLearnDescriptionState();
}

class _FunNLearnDescriptionState extends State<FunNLearnDescription> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(FunNLearnRepo(apiClient: Get.find()));

    FunNLearnListController controller = Get.put(FunNLearnListController(
      funNLearnRepo: Get.find(),
    ));

    controller.title = Get.arguments[0] as String;
    controller.subCategoryId = Get.arguments[1];
    controller.description = Get.arguments[2];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FunNLearnListController>(
      builder: (controller) => Scaffold(
        appBar: CustomCategoryAppBar(title: controller.title),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                margin: const EdgeInsets.all(Dimensions.space10),
                child: Padding(
                  padding: const EdgeInsets.all(Dimensions.space15),
                  child: Column(
                    children: [
                      Text(controller.description),
                      const SizedBox(height: Dimensions.space20),
                      RoundedButton(
                          text: MyStrings.letsPlay,
                          press: () {
                            Get.offAndToNamed(RouteHelper.funNlearnQuizScreen, arguments: [controller.title, controller.subCategoryId]);
                          })
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
