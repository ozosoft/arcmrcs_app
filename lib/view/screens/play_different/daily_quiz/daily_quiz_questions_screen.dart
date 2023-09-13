import 'package:audioplayers/audioplayers.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';
import 'package:quiz_lab/core/utils/my_color.dart';
import 'package:quiz_lab/core/utils/my_images.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/core/utils/style.dart';
import 'package:quiz_lab/core/utils/url_container.dart';
import 'package:quiz_lab/data/controller/play_different_quizes/daily_quiz/daily_quiz_questions_controller.dart';
import 'package:quiz_lab/data/repo/play_different_quizes/daily_quiz/daily_quiz_repo.dart';
import 'package:quiz_lab/data/services/api_service.dart';
import 'package:quiz_lab/view/components/app-bar/custom_category_appBar.dart';
import 'package:quiz_lab/view/components/buttons/level_card_button.dart';
import 'package:quiz_lab/view/components/custom_loader/custom_loader.dart';
import 'package:quiz_lab/view/components/no_data.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class DailyQuizQuestionsScreen extends StatefulWidget {
  const DailyQuizQuestionsScreen({super.key});

  @override
  State<DailyQuizQuestionsScreen> createState() => _DailyQuizQuestionsScreenState();
}

class _DailyQuizQuestionsScreenState extends State<DailyQuizQuestionsScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(DailyQuizRepo(apiClient: Get.find()));

    DailyQuizQuestionsController controller = Get.put(DailyQuizQuestionsController(dailyQuizRepo: Get.find()));

    // debugPrint("++++++++++===============this is id"+quizinfoID.toString());
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getDailyQuizQuestions();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DailyQuizQuestionsController>(
        builder: (controller) => Scaffold(
              appBar: CustomCategoryAppBar(title: MyStrings.dailyQuiz.tr),
              body: controller.loading
                  ? const CustomLoader()
                  : controller.examQuestionsList.isEmpty
                      ? NoDataWidget(
                          showBack: true,
                          messages: "${controller.alreadyPlayed == true ? MyStrings.sorryAlreadyPlayedQuiz.tr : MyStrings.sorryNoQuizFound.tr} ",
                        )
                      : PageView(onPageChanged: (value) {}, children: [
                          PageView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            controller: controller.pageController,
                            onPageChanged: (int page) {
                              controller.changePage(page);
                            },
                            itemCount: controller.examQuestionsList.length,
                            itemBuilder: (context, questionsIndex) {
                              controller.setCurrentOption(questionsIndex);

                              debugPrint('current question index: $questionsIndex');

                              return SingleChildScrollView(
                                padding: const EdgeInsets.all(Dimensions.space20),
                                child: Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.space20), color: MyColor.colorWhite),
                                      padding: const EdgeInsets.all(Dimensions.space15),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              LevelCardButton(text: "${controller.currentPage + 1} / ${controller.examQuestionsList.length.toString()}", hasIcon: false, hasImage: false),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: Dimensions.space10,
                                          ),
                                          Container(
                                            width: double.infinity,
                                            padding: const EdgeInsetsDirectional.only(top: Dimensions.space40, start: Dimensions.space8, end: Dimensions.space8),
                                            child: controller.examQuestionsList[questionsIndex].image != null
                                                ? Image.network(
                                                    UrlContainer.dailyQuizQuestionsImage + controller.examQuestionsList[questionsIndex].image,
                                                    fit: BoxFit.cover,
                                                  )
                                                : const SizedBox(),
                                          ),
                                          Container(padding: const EdgeInsetsDirectional.only(top: Dimensions.space20), child: Text(controller.examQuestionsList[questionsIndex].question!, style: semiBoldExtraLarge.copyWith(fontWeight: FontWeight.w500), textAlign: TextAlign.center)),
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
                                                        Expanded(
                                                          child: InkWell(
                                                            onTap: () async {
                                                              if (controller.examQuestionsList[questionsIndex].selectedOptionId!.isNotEmpty) {
                                                                return;
                                                              }

                                                              controller.selectAnswer(optionIndex, questionsIndex);

                                                              controller.examQuestionsList[questionsIndex].selectedOptionId!.isEmpty
                                                                  ? null
                                                                  : controller.selectedOptionIndex == optionIndex
                                                                      ? controller.isValidAnswer(questionsIndex, optionIndex)
                                                                          ? AudioPlayer().play(AssetSource('audios/correct_ans.mp3'))
                                                                          : AudioPlayer().play(AssetSource('audios/wrong_ans.mp3'))
                                                                      : null;

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
                                                              }
                                                            },
                                                            child: Container(
                                                              margin: const EdgeInsets.all(Dimensions.space8),
                                                              padding: const EdgeInsets.symmetric(vertical: Dimensions.space15, horizontal: Dimensions.space15),
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
                                                                  Expanded(
                                                                    child: Text(
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
                                                                  ),
                                                                  SizedBox(
                                                                      height: Dimensions.space10,
                                                                      child: SvgPicture.asset(
                                                                          "${controller.examQuestionsList[questionsIndex].selectedOptionId!.isEmpty ? const SizedBox() : controller.selectedOptionIndex == optionIndex ? controller.isValidAnswer(questionsIndex, optionIndex) ? MyImages.whiteTikSVG : MyImages.wrongAnswerSVG : const SizedBox()}",
                                                                          fit: BoxFit.cover))
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        controller.audienceVote == true && controller.audienceVoteIndex == questionsIndex ? Text(MyStrings.fifteenPercent.tr, style: semiBoldExtraLarge.copyWith(color: MyColor.colorQuizBodyAudText)) : const SizedBox()
                                                      ],
                                                    ),
                                                  ],
                                                );
                                              }),
                                          const SizedBox(height: Dimensions.space25),
                                          // DailyQuizLifeLinesWidget(questionIndex: questionsIndex),
                                          const SizedBox(height: Dimensions.space25),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.only(start: MediaQuery.of(context).size.width * .4),
                                      child: CircularCountDownTimer(
                                        duration: Dimensions.space70.toInt(),
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
                                          controller.selectedOptionIndex.toString().isNotEmpty ? debugPrint("this is selectedoption index${controller.selectedOptionIndex}") : print;
                                          if (questionsIndex == controller.examQuestionsList.length - 1) {
                                            controller.submitAnswer();
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
