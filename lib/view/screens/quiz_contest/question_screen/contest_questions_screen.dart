import 'package:audioplayers/audioplayers.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';
import 'package:quiz_lab/core/utils/my_color.dart';
import 'package:quiz_lab/core/utils/my_images.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/core/utils/style.dart';
import 'package:quiz_lab/core/utils/url_container.dart';
import 'package:quiz_lab/data/controller/quiz_contest/quiz_contest_questions_controller.dart';
import 'package:quiz_lab/data/repo/quiz_contest/quiz_contest_repo.dart';
import 'package:quiz_lab/data/services/api_service.dart';
import 'package:quiz_lab/view/components/app-bar/custom_category_appBar.dart';
import 'package:quiz_lab/view/components/buttons/level_card_button.dart';
import 'package:quiz_lab/view/components/custom_loader/custom_loader.dart';
import 'package:quiz_lab/view/components/no_data.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../core/route/route.dart';
import '../../../components/alert-dialog/custom_alert_dialog.dart';
import '../../../components/image_widget/my_image_widget.dart';
import '../../../components/mobile_ads/quiz_banner_ads_widget.dart';

class QuizContestQuestions extends StatefulWidget {
  const QuizContestQuestions({super.key});

  @override
  State<QuizContestQuestions> createState() => _QuizContestQuestionsState();
}

class _QuizContestQuestionsState extends State<QuizContestQuestions> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(QuizContestRepo(apiClient: Get.find()));

    QuizContestQuestionsController controller = Get.put(QuizContestQuestionsController(quizContestRepo: Get.find()));

    controller.quizInfoID = Get.arguments[0];
    controller.title = Get.arguments[1];

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getQuizContestQuestions();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        GetBuilder<QuizContestQuestionsController>(
          builder: (controller) => Scaffold(
            appBar: CustomCategoryAppBar(
              title: controller.title.toString(),
            ),
            body: controller.loading
                ? const CustomLoader()
                : controller.examQuestionsList.isEmpty
                    ? NoDataWidget(
                        messages: MyStrings.thisContestIsNotAvailableRightNow.tr,
                      )
                    : WillPopScope(
                        onWillPop: () async {
                          CustomAlertDialog(
                              borderRadius: 100,
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(Dimensions.space10),
                                    child: Text(
                                      MyStrings.areYouSureYouWantToLeaveThisQuiz.tr,
                                      textAlign: TextAlign.center,
                                      style: regularLarge.copyWith(color: MyColor.textSecondColor),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: 1,
                                    color: MyColor.textSecondColor.withOpacity(0.3),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(Dimensions.space10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop(false); // Return false when "Cancel" is pressed
                                          },
                                          child: Text(
                                            MyStrings.cancel.tr,
                                            style: regularLarge,
                                          ),
                                        ),
                                        TextButton(
                                          style: TextButton.styleFrom(backgroundColor: MyColor.primaryColor, foregroundColor: MyColor.colorWhite),
                                          onPressed: () async {
                                            Get.offAllNamed(RouteHelper.bottomNavBarScreen);
                                          },
                                          child: Text(
                                            MyStrings.yes.tr,
                                            style: regularLarge.copyWith(color: MyColor.colorWhite),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              )).customAlertDialog(context);
                          return false; // Disable back button if `start` is true
                        },
                        child: PageView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          controller: controller.pageController,
                          onPageChanged: (int page) {
                            controller.changePage(page);
                          },
                          itemCount: controller.examQuestionsList.length,
                          itemBuilder: (context, questionsIndex) {
                            controller.setCurrentOption(questionsIndex);

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
                                        const SizedBox(height: Dimensions.space25),
                                        if (controller.examQuestionsList[questionsIndex].image != null) ...[
                                          Container(
                                            width: double.infinity,
                                            padding: const EdgeInsetsDirectional.only(top: Dimensions.space40, start: Dimensions.space8, end: Dimensions.space8),
                                            child: MyImageWidget(
                                              boxFit: BoxFit.contain,
                                              height: Get.width / 2,
                                              imageUrl: "${UrlContainer.quizContestQuestionsImage}/${controller.examQuestionsList[questionsIndex].image}",
                                            ),
                                          ),
                                        ],
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

                                                            if (controller.quizContestRepo.apiClient.getSoundStatus()) {
                                                              controller.examQuestionsList[questionsIndex].selectedOptionId!.isEmpty
                                                                  ? null
                                                                  : controller.selectedOptionIndex == optionIndex
                                                                      ? controller.isValidAnswer(questionsIndex, optionIndex)
                                                                          ? AudioPlayer().play(AssetSource('audios/correct_ans.mp3'))
                                                                          : AudioPlayer().play(AssetSource('audios/wrong_ans.mp3'))
                                                                      : null;
                                                            }

                                                            await Future.delayed(const Duration(seconds: 2));

                                                            if (controller.pageController.page! < controller.examQuestionsList.length - 1) {
                                                              controller.pageController.nextPage(
                                                                duration: const Duration(milliseconds: 500),
                                                                curve: Curves.easeInOut,
                                                              );
                                                              controller.showaudienceVote = false;
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
                                                                Expanded(
                                                                  child: Text(
                                                                    " ${controller.examQuestionsList[questionsIndex].options![optionIndex].option.toString()}",
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
                                                                    child: controller.examQuestionsList[questionsIndex].selectedOptionId!.isEmpty
                                                                        ? const SizedBox()
                                                                        : controller.selectedOptionIndex == optionIndex
                                                                            ? SvgPicture.asset(controller.isValidAnswer(questionsIndex, optionIndex) ? MyImages.whiteTikSVG : MyImages.wrongAnswerSVG, fit: BoxFit.cover)
                                                                            : const SizedBox()),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      controller.showaudienceVote == true && controller.audienceVoteIndex == questionsIndex
                                                          ? Text(
                                                              controller.examQuestionsList[questionsIndex].options![optionIndex].audience.toString() + MyStrings.percent.tr,
                                                              style: regularMediumLarge.copyWith(color: MyColor.textColor),
                                                            )
                                                          : const SizedBox(),
                                                    ],
                                                  ),
                                                ],
                                              );
                                            }),
                                        const SizedBox(height: Dimensions.space25),
                                        // QuizContestLifeLinesWidget(questionIndex: questionsIndex),
                                        const SizedBox(height: Dimensions.space25),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.only(start: MediaQuery.of(context).size.width * .4),
                                    child: CircularCountDownTimer(
                                      duration: controller.timerDuration,
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
                      ),
          ),
        ),
        //Ads Code
        const Positioned.fill(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsetsDirectional.only(bottom: Dimensions.space10),
              child: QuizBannerAdsWidget(),
            ),
          ),
        ),
      ],
    );
  }
}
