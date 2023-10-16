import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:quiz_lab/core/helper/date_converter.dart';
import 'package:quiz_lab/core/route/route.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';
import 'package:quiz_lab/core/utils/my_color.dart';
import 'package:quiz_lab/core/utils/my_images.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/core/utils/style.dart';
import 'package:quiz_lab/data/controller/exam_zone/exam_zone_quiz_controller.dart';
import 'package:quiz_lab/data/repo/exam_zone/exam_zone_repo.dart';
import 'package:quiz_lab/data/services/api_client.dart';
import 'package:quiz_lab/view/components/app-bar/custom_category_appbar.dart';
import 'package:quiz_lab/view/components/buttons/level_card_button.dart';
import 'package:quiz_lab/view/components/custom_loader/custom_loader.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:slide_countdown/slide_countdown.dart';

import '../../../../core/utils/url_container.dart';
import '../../../components/alert-dialog/custom_alert_dialog.dart';
import '../../../components/buttons/rounded_button.dart';
import '../../../components/image_widget/my_image_widget.dart';
import '../../../components/no_data.dart';

class ExamZoneQuizScreen extends StatefulWidget {
  const ExamZoneQuizScreen({super.key});

  @override
  State<ExamZoneQuizScreen> createState() => _ExamZoneQuizScreenState();
}

class _ExamZoneQuizScreenState extends State<ExamZoneQuizScreen> {
  late final StreamDuration _streamDuration;

  @override
  void initState() {
    super.initState();

    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(ExamZoneRepo(apiClient: Get.find()));

    ExamZoneQuizController controller = Get.put(ExamZoneQuizController(
      examZoneRepo: Get.find(),
    ));

    controller.quizInfoID = Get.arguments[0];
    controller.enterExamKey = Get.arguments[1];

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      debugPrint("from addframe callback");
      await controller.getExamZoneQuestions(controller.quizInfoID.toString(), controller.enterExamKey).whenComplete(() {
        if (controller.examFullInfoData.examEndTime != null) {
          int durationInMinutes = DateConverter().calculateDurationToEndTime("${controller.examFullInfoData.examEndTime}");

          _streamDuration = StreamDuration(Duration(minutes: durationInMinutes));
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    try{
      _streamDuration.dispose();
    } catch(e){
      debugPrint(e.toString());
    }

  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ExamZoneQuizController>(
        builder: (controller) => Scaffold(
              appBar: CustomCategoryAppBar(title: MyStrings.examZone.tr),
              body: controller.loading == true
                  ? const CustomLoader()
                  : controller.examQuestionsList.isEmpty
                      ? NoDataWidget(
                          messages: controller.examNotStartYet
                              ? MyStrings.examNotStartYet.tr
                              : controller.examAlreadyGiven
                                  ? MyStrings.examAlreadyGiven.tr
                                  : controller.examFinished
                                      ? MyStrings.examFinished.tr
                                      : MyStrings.noDataToShow.tr,
                        )
                      : Stack(
                          fit: StackFit.expand,
                          children: [
                            WillPopScope(
                              onWillPop: () async {
                                if (controller.examAlreadyGiven == false && controller.examFinished == false && controller.examNotStartYet == false && controller.examStarted == false) {
                                  return true;
                                }
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
                                            MyStrings.areYouSureYouWantToLeaveExamRoom.tr,
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
                              child: Stack(
                                children: [
                                  PageView.builder(
                                    physics: const BouncingScrollPhysics(),
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
                                                  const SizedBox(
                                                    height: Dimensions.space30,
                                                  ),
                                                  if (controller.examQuestionsList[questionsIndex].image != null) ...[
                                                    Container(
                                                      width: double.infinity,
                                                      padding: const EdgeInsetsDirectional.only(top: Dimensions.space40, start: Dimensions.space8, end: Dimensions.space8),
                                                      child: MyImageWidget(
                                                        boxFit: BoxFit.contain,
                                                        height: Get.width / 2,
                                                        imageUrl: "${UrlContainer.questionImagePath}/${controller.examQuestionsList[questionsIndex].image}",
                                                      ),
                                                    ),
                                                  ],

                                                  Container(padding: const EdgeInsetsDirectional.only(top: Dimensions.space20), child: Text(controller.examQuestionsList[questionsIndex].question.toString(), style: semiBoldExtraLarge.copyWith(fontWeight: FontWeight.w500), textAlign: TextAlign.center)),

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

                                                                      if (controller.examZoneRepo.apiClient.getSoundStatus()) {
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
                                                                      }
                                                                      if (controller.selectedOptionIndex.toString() == "0" && controller.selectedOptionIndex.toString() == "1") {
                                                                        controller.selectedQuestionsId.add(controller.examQuestionsList[questionsIndex].id);
                                                                      }
                                                                      controller.selectedAnswerId.add(controller.examQuestionsList[questionsIndex].selectedOptionId);
                                                                      controller.update();
                                                                      // if (questionsIndex == controller.examQuestionsList.length - 1) {
                                                                      //   controller.submitAnswer();
                                                                      //   Get.toNamed(RouteHelper.examZoneResultScreen, arguments: MyStrings.quizResult);
                                                                      // }
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
                                                                              "${controller.examQuestionsList[questionsIndex].options![optionIndex].option.toString()} ",
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
                                                                                      : const SizedBox())
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
                                                  // LifeLinesWidget(questionIndex: questionsIndex)
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                  Positioned(
                                    top: Dimensions.space40,
                                    left: 0,
                                    right: Dimensions.space40,
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: SlideCountdownSeparated(
                                        streamDuration: _streamDuration,
                                        width: 40,
                                        height: 40,
                                        separatorType: SeparatorType.symbol,
                                        slideDirection: SlideDirection.down,
                                        separatorStyle: const TextStyle(color: MyColor.primaryColor, fontSize: 20),
                                        textStyle: const TextStyle(backgroundColor: Colors.transparent, color: MyColor.primaryColor, fontSize: 25, fontWeight: FontWeight.bold),
                                        decoration: const BoxDecoration(
                                          color: MyColor.timerbgColor,
                                          borderRadius: BorderRadius.all(Radius.circular(Dimensions.space5)),
                                        ),
                                        padding: const EdgeInsets.all(0),
                                        separatorPadding: const EdgeInsets.all(5),
                                        onChanged: (v) {
                                          // debugPrint(v);
                                          // debugPrint(v);
                                          if (v.toString() == "0:00:01.000000") {
                                            debugPrint("Exam Finished onchange");

                                            controller.submitAnswer();
                                            _streamDuration.pause();
                                          }
                                        },
                                        onDone: () {
                                          debugPrint("Exam Finished ccc");

                                          controller.submitAnswer();
                                          _streamDuration.pause();
                                        },
                                        showZeroValue: false,
                                      ),
                                    ),
                                  ),


                                  //Load bar
                                  if (controller.submitLoading == true) ...[
                                    Positioned.fill(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Container(
                                          color: MyColor.colorWhite.withOpacity(0.9),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                const SpinKitPouringHourGlass(
                                                  color: MyColor.spinLoadColor,
                                                ),
                                                const SizedBox(
                                                  height: Dimensions.space20,
                                                ),
                                                Text(
                                                  MyStrings.pleaseWaitForYourResultText.tr,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                           
                          ],
                        ),
          bottomNavigationBar:  Container(
            height: 80,
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.space10, vertical: Dimensions.space5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  flex: 2,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.only(start: Dimensions.space5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${controller.selectedAnswerId.length} ${MyStrings.attempted.tr}",
                              style: regularMediumLarge.copyWith(color: MyColor.colorDarkGrey),
                            ),
                            const SizedBox(
                              height: Dimensions.space6,
                            ),
                            Text(
                              "${controller.examQuestionsList.length - controller.selectedAnswerId.length} ${MyStrings.unAttempted.tr}",
                              style: regularMediumLarge.copyWith(color: MyColor.colorDarkGrey),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: RoundedButton(
                      horizontalPadding: Dimensions.space5,
                      text: MyStrings.submit.tr,
                      color: MyColor.primaryColor,
                      press: () {
                        debugPrint("Exam Finished button");
                        _streamDuration.pause();

                        CustomAlertDialog(
                            borderRadius: 10,
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(Dimensions.space10),
                                  child: Column(
                                    children: [
                                      Text(
                                        MyStrings.areYouSureYouWantToLeaveExamRoom.tr,
                                        textAlign: TextAlign.center,
                                        style: regularDefault.copyWith(),
                                      ),
                                    ],
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
                                          Get.back();
                                          controller.submitAnswer();
                                        },
                                        child: Text(
                                          MyStrings.yes.tr,
                                          style: regularLarge.copyWith(color: MyColor.colorWhite),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )).customAlertDialog(context);
                      }),
                ),
              ],
            ),
          ),
            ));
  }
}
