import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_prime/core/route/route.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_images.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/core/utils/style.dart';
import 'package:flutter_prime/data/controller/exam_zone/exam_zone_controller.dart';
import 'package:flutter_prime/data/controller/exam_zone/exam_zone_quiz_controller.dart';
import 'package:flutter_prime/data/repo/exam_zone/exam_zone_repo.dart';
import 'package:flutter_prime/data/services/api_service.dart';
import 'package:flutter_prime/view/components/app-bar/custom_category_appBar.dart';
import 'package:flutter_prime/view/components/buttons/level_card_button.dart';
import 'package:flutter_prime/view/components/custom_loader/custom_loader.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Exam_zone_quiz_screen extends StatefulWidget {
  const Exam_zone_quiz_screen({super.key});

  @override
  State<Exam_zone_quiz_screen> createState() => _Exam_zone_quiz_screenState();
}

class _Exam_zone_quiz_screenState extends State<Exam_zone_quiz_screen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(ExamZoneRepo(apiClient: Get.find()));

    ExamZoneQuizController controller = Get.put(ExamZoneQuizController(
      examZoneRepo: Get.find(),
    ));

    controller.quizInfoID = Get.arguments[0];
    controller.enterExamKey = Get.arguments[1];

    // print("++++++++++===============this is id"+quizinfoID.toString());
    super.initState();

    print("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"+controller.enterExamKey + controller.quizInfoID.toString());
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getExamZoneQuestions(controller.quizInfoID.toString(), controller.enterExamKey);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ExamZoneQuizController>(
        builder: (controller) => Scaffold(
                appBar: CustomCategoryAppBar(title: "title"),
                
                body:
                
                controller.loading?CustomLoader():
                controller.examQuestionsList.isEmpty
            ? Text('Empty')
            :  PageView(onPageChanged: (value) {}, children: [
                  PageView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    controller: controller.pageController,
                    onPageChanged: (int page) {
                      print(page);
                      controller.changePage(page);
                      print("1234" + controller.pageController.toString());
                    },
                    itemCount: controller.examQuestionsList.length,
                    itemBuilder: (context, questionsIndex) {
                      controller.setCurrentOption(questionsIndex);

                      print('current question index: ${questionsIndex}');

                      return SingleChildScrollView(
                        padding: const EdgeInsets.all(Dimensions.space20),
                        child: Stack(
                          children: [
                            Container(
                              key: ValueKey<int>(controller.currentQuestionIndex),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.space20), color: MyColor.colorWhite),
                              padding: const EdgeInsets.all(Dimensions.space15),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      LevelCardButton(text: "${controller.currentPage + 1} / ${controller.examQuestionsList.length.toString()}", hasIcon: false, hasImage: false),
                                    ],
                                  ),
                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.only(top: Dimensions.space40, left: Dimensions.space8, right: Dimensions.space8),
                                    child: Image.asset(
                                      MyImages.greatWallPNG,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Container(padding: const EdgeInsets.only(top: Dimensions.space20), child: Text(controller.examQuestionsList[questionsIndex].question!, style: semiBoldExtraLarge.copyWith(fontWeight: FontWeight.w500), textAlign: TextAlign.center)),
                                  const SizedBox(height: Dimensions.space25),
                                  ListView.builder(
                                      physics: const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: controller.examQuestionsList[questionsIndex].options!.length,
                                      itemBuilder: (BuildContext context, int optionIndex) {
                                        return Column(
                                          children: [
                                            Row(
                                              children: [
                                                InkWell(
                                                  onTap: () async {
                                                    if (controller.examQuestionsList[questionsIndex].selectedOptionId!.isNotEmpty) {
                                                        return;
                                                      }

                                                      controller.selectAnswer(optionIndex, questionsIndex);

                                                      await Future.delayed(const Duration(seconds: 3));

                                                      if (controller.pageController.page! < controller.examQuestionsList.length - 1) {
                                                        controller.pageController.nextPage(
                                                          duration: const Duration(milliseconds: 500),
                                                          curve: Curves.easeInOut,
                                                        );
                                                      }
                                                      if (controller.selectedOptionIndex.toString() == "0" && controller.selectedOptionIndex.toString() == "1") {
                                                        controller.selectedQuestionsId.add(controller.examQuestionsList[questionsIndex].id);
                                                      }
                                                      controller.selectedAnswerId.add(controller.examQuestionsList[questionsIndex].selectedOptionId);

                                                      if (questionsIndex == controller.examQuestionsList.length - 1) {
                                                        controller.submitAnswer();
                                                         Get.toNamed(RouteHelper.examZoneResultScreen, arguments: MyStrings.quizResult);
                                                      
                                                      }
                                                  },
                                                  child: Container(
                                                    margin: const EdgeInsets.all(Dimensions.space8),
                                                    padding: const EdgeInsets.symmetric(vertical: Dimensions.space15, horizontal: Dimensions.space15),
                                                    height: Dimensions.space55,
                                                    width: controller.audienceVote == true && controller.audienceVoteIndex == questionsIndex ? MediaQuery.of(context).size.width * .65 : MediaQuery.of(context).size.width * .75,
                                                    decoration: BoxDecoration(
                                                        color: controller.examQuestionsList[questionsIndex].selectedOptionId!.isEmpty
                                                            ? MyColor.transparentColor
                                                            : controller.selectedOptionIndex == optionIndex
                                                                ? controller.isValidAnswer(questionsIndex, optionIndex)
                                                                    ? MyColor.rightAnswerbgColor
                                                                    : MyColor.wrongAnsColor
                                                                : MyColor.transparentColor,
                                                        borderRadius: BorderRadius.circular(Dimensions.space8),
                                                        border: Border.all(color: MyColor.colorLightGrey)),
                                                    child: Row(
                                                      children: [
                                                        const SizedBox(width: Dimensions.space8),
                                                        Text(
                                                          controller.examQuestionsList[questionsIndex].options![optionIndex].option.toString(),
                                                          style: regularMediumLarge.copyWith(
                                                              color: controller.examQuestionsList[questionsIndex].selectedOptionId!.isEmpty
                                                                  ? MyColor.textColor
                                                                  : controller.selectedOptionIndex == optionIndex
                                                                      ? controller.isValidAnswer(questionsIndex, optionIndex)
                                                                          ? MyColor.colorWhite
                                                                          : MyColor.colorWhite
                                                                      : MyColor.textColor),
                                                        ),
                                                        const Spacer(),
                                                        SizedBox(
                                                            height: Dimensions.space10,
                                                            child: SvgPicture.asset(
                                                                "${controller.examQuestionsList[questionsIndex].selectedOptionId!.isEmpty ? const SizedBox() : controller.selectedOptionIndex == optionIndex ? controller.isValidAnswer(questionsIndex, optionIndex) ? MyImages.whiteTikSVG : MyImages.wrongAnswerSVG : const SizedBox()}",
                                                                fit: BoxFit.cover))
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                const Spacer(),
                                                controller.audienceVote == true && controller.audienceVoteIndex == questionsIndex ? Text(MyStrings.fifteenPercent, style: semiBoldExtraLarge.copyWith(color: MyColor.colorQuizBodyAudText)) : const SizedBox()
                                              ],
                                            ),
                                          ],
                                        );
                                      }),
                                  const SizedBox(height: Dimensions.space25),
                                  // LifeLinesWidget(questionIndex: questionsIndex),
                                  const SizedBox(height: Dimensions.space25),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * .4),
                              child: CircularCountDownTimer(
                                duration: Dimensions.space2.toInt(),
                                initialDuration: 0,
                                controller: controller.countDownController,
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
                                  if (controller.selectedOptionIndex.toString() == "-1") {
                                    controller.selectedQuestionsId.add(controller.examQuestionsList[questionsIndex].id);
                                  }
                                  controller.selectedOptionIndex.toString().isNotEmpty ? print("this is selectedoption index" + controller.selectedOptionIndex.toString()) : print;
                                  if (questionsIndex == controller.examQuestionsList.length - 1) {
                                    controller.submitAnswer();

                                    Get.toNamed(RouteHelper.examZoneResultScreen, arguments: MyStrings.quizResult);
                                  } else {
                                    controller.pageController.nextPage(
                                      duration: const Duration(milliseconds: 500),
                                      curve: Curves.easeInOut,
                                    );
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ]),
              ));
  }
}