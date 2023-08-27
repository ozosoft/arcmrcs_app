import 'dart:developer';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_prime/core/route/route.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/core/utils/style.dart';
import 'package:flutter_prime/data/controller/gesstheword/gess_the_word_Controller.dart';
import 'package:flutter_prime/data/repo/gess_the_word/gessThewordRepo.dart';
import 'package:flutter_prime/data/services/api_service.dart';
import 'package:flutter_prime/view/components/app-bar/custom_appbar.dart';
import 'package:flutter_prime/view/components/buttons/level_card_button.dart';
import 'package:flutter_prime/view/components/buttons/rounded_button.dart';
import 'package:flutter_prime/view/components/custom_loader/custom_loader.dart';
import 'package:flutter_prime/view/components/snack_bar/show_custom_snackbar.dart';
import 'package:flutter_prime/view/screens/gess%20the%20word/widget/answar_field.dart';
import 'package:flutter_prime/view/screens/gess%20the%20word/widget/question_button.dart';
import 'package:flutter_prime/view/screens/quiz-questions/quiz-screen-widgets/life_line_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../core/utils/my_images.dart';

class GessThewordScreen extends StatefulWidget {
  const GessThewordScreen({super.key});

  @override
  State<GessThewordScreen> createState() => _GessThewordScreenState();
}

class _GessThewordScreenState extends State<GessThewordScreen> {
  int id = 0;
  @override
  void initState() {
    id = Get.arguments;
    log(id.toString());
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(GessTheWordRepo(apiClient: Get.find()));
    final controller = Get.put(GessThewordController(gessTheWordRepo: Get.find()));
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getQuestion(id.toString());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: MyColor.primaryColor,
        leading: GestureDetector(
          onTap: () {
            Get.offAllNamed(RouteHelper.gessThewordCatagori);
          },
          child: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text("Gess the Word"),
      ),
      body: GetBuilder<GessThewordController>(builder: (controller) {
        return controller.isLoading
            ? const CustomLoader()
            : PageView(
                // physics: NeverScrollableScrollPhysics(),
                onPageChanged: (value) {},
                children: [
                  PageView.builder(
                    controller: controller.pageController,
                    itemCount: controller.gessThewordQuesstionList.length,
                    physics: const NeverScrollableScrollPhysics(),
                    onPageChanged: (index) {},
                    itemBuilder: (context, questionsIndex) {
                      return SingleChildScrollView(
                        padding: const EdgeInsets.all(Dimensions.space20),
                        child: Stack(
                          children: [
                            Container(
                              key: ValueKey<int>(questionsIndex),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.space20), color: MyColor.colorWhite),
                              padding: const EdgeInsets.all(Dimensions.space15),
                              child: Column(
                                children: [
                                  const Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      LevelCardButton(text: MyStrings.oneFiftycoins, hasIcon: false, hasImage: false),
                                      LevelCardButton(text: MyStrings.quiestionsLimit, hasIcon: false, hasImage: false),
                                    ],
                                  ),
                                  // skip: use  preloader or something like this
                                  controller.gessThewordQuesstionList[questionsIndex].image != null
                                      ? Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.only(top: Dimensions.space40, left: Dimensions.space8, right: Dimensions.space8),
                                          child: Image.network(
                                            '${controller.questionImgPath}/${controller.gessThewordQuesstionList[questionsIndex].image}',
                                            fit: BoxFit.cover,
                                            height: 220,
                                          ),
                                        )
                                      : const SizedBox.shrink(),
                                  Container(padding: const EdgeInsets.only(top: Dimensions.space20), child: Text(controller.gessThewordQuesstionList[questionsIndex].question.toString(), style: semiBoldExtraLarge.copyWith(fontWeight: FontWeight.w500), textAlign: TextAlign.center)),
                                  const SizedBox(height: Dimensions.space40),
                                  AnswarField(length: controller.gessThewordQuesstionList[questionsIndex].options![0].option!.length),
                                  const SizedBox(height: Dimensions.space20),
                                  IconButton(onPressed: () {}, icon: Icon(Icons.delete_forever_outlined)),
                                  const SizedBox(height: Dimensions.space40),
                                  QuestionButton(
                                    ans: controller.gessThewordQuesstionList[questionsIndex].options![0].option.toString(),
                                  ),
                                  const SizedBox(height: Dimensions.space40),
                                  RoundedButton(
                                    text: MyStrings.submit,
                                    press: () {
                                      controller.addAns(controller.gessThewordQuesstionList[questionsIndex].id.toString(), controller.tempAns.join(''));
                                      controller.gessThewordQuesstionList.length == questionsIndex ? controller.submit() : controller.nextPage();
                                    },
                                  ),
                                  const SizedBox(height: Dimensions.space40),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * .4),
                              child: CircularCountDownTimer(
                                duration: controller.ansDuration,
                                initialDuration: 0,
                                width: Dimensions.space60,
                                height: Dimensions.space80,
                                ringColor: MyColor.primaryColor,
                                ringGradient: null,
                                fillColor: MyColor.timerbgColor,
                                fillGradient: null,
                                backgroundColor: MyColor.timerbgColor,
                                strokeWidth: Dimensions.space5,
                                strokeCap: StrokeCap.round,
                                textStyle: semiBoldExtraLarge.copyWith(color: MyColor.primaryColor),
                                textFormat: CountdownTextFormat.S,
                                isReverse: true,
                                isReverseAnimation: false,
                                isTimerTextShown: true,
                                autoStart: true,
                                onComplete: () {
                                  controller.addAns(controller.gessThewordQuesstionList[questionsIndex].id.toString(), controller.tempAns.join(''));
                                  controller.nextPage();
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              );
      }),
    );
  }
}
