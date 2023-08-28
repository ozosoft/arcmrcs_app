import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/core/utils/style.dart';
import 'package:flutter_prime/data/controller/battle/battle_room_controller.dart';
import 'package:flutter_prime/data/controller/battle/battle_room_quiz_controller.dart';
import 'package:flutter_prime/data/repo/battle/battle_repo.dart';
import 'package:flutter_prime/view/components/buttons/level_card_button.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../../../core/route/route.dart';
import '../../../../core/utils/url_container.dart';
import '../../../../data/model/battle/battle_question_list.dart';
import '../../../../data/services/api_service.dart';
import '../../../components/alert-dialog/custom_alert_dialog.dart';

import '../../../components/image_widget/my_image_widget.dart';
import 'battle_quiz_option_button.dart';

class BattleQuizQuestionsBodySection extends StatefulWidget {
  final List<BattleQuestion> qustionsList;
  const BattleQuizQuestionsBodySection({super.key, required this.qustionsList});

  @override
  State<BattleQuizQuestionsBodySection> createState() => _BattleQuizQuestionsBodySectionState();
}

class _BattleQuizQuestionsBodySectionState extends State<BattleQuizQuestionsBodySection> with WidgetsBindingObserver {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(BattleRepo(apiClient: Get.find()));
    Get.put(BattleRoomController(Get.find()));
    Get.put(BattleRoomQuizController(Get.find(), Get.find()));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GetBuilder<BattleRoomQuizController>(initState: (quizState) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (quizState.controller!.questionsList.isEmpty) {
          quizState.controller!.questionsList.value = widget.qustionsList;
        }
      });
    }, builder: (quizController) {
      if (quizController.meLeftTheGame.value == true) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (quizController.battleRoomController
                  .getOpponentUserDetailsOrMy(quizController.battleRepo.apiClient.getUserID(), isMyData: true)
                  .status ==
              false) {
            CustomAlertDialog(
                    willPop: false,
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
                                MyStrings.youLeftTheGame,
                                style: regularLarge.copyWith(color: MyColor.textSecondColor),
                              ),
                              const SizedBox(
                                height: Dimensions.space15,
                              ),
                              Text(
                                MyStrings.lose,
                                style: boldLarge.copyWith(color: MyColor.textSecondColor, fontSize: Dimensions.fontMediumLarge),
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
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                style: TextButton.styleFrom(backgroundColor: MyColor.primaryColor, foregroundColor: MyColor.colorWhite),
                                onPressed: () async {
                                  // if (quizController.opponentLeftTheGame.isTrue) {
                                  //   // left User

                                  //   await quizController.finishBattleAndSubmitAnswer().then((value) {
                                  //     print("Collected");
                                  //   });
                                  // }
                                  Get.offAllNamed(RouteHelper.bottomNavBarScreen);
                                },
                                child: Text(
                                  MyStrings.ok,
                                  style: regularLarge.copyWith(color: MyColor.colorWhite),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    barrierDismissible: false)
                .customAlertDialog(context);
          }
        });
      }

      if (quizController.opponentLeftTheGame.value == true) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (quizController.showLeftPopupValue.isFalse) {
            print("Show PopUp");
            CustomAlertDialog(
                    willPop: false,
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
                                MyStrings.oponentLeftTheGame,
                                style: regularLarge.copyWith(color: MyColor.textSecondColor),
                              ),
                              const SizedBox(
                                height: Dimensions.space15,
                              ),
                              Text(
                                MyStrings.youWon,
                                style: boldLarge.copyWith(color: MyColor.textSecondColor, fontSize: Dimensions.fontMediumLarge),
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
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                style: TextButton.styleFrom(backgroundColor: MyColor.primaryColor, foregroundColor: MyColor.colorWhite),
                                onPressed: () async {
                                  if (quizController.opponentLeftTheGame.isTrue) {
                                    // left User

                                    await quizController.finishBattleAndSubmitAnswer(fromYouWon: true).then((value) {
                                      print("Collected");
                                    });
                                  }
                                },
                                child: Text(
                                  MyStrings.collectCoins,
                                  style: regularLarge.copyWith(color: MyColor.colorWhite),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    barrierDismissible: false)
                .customAlertDialog(context);
          }
          quizController.showLeftPopupUpdate(true);
        });
      }

      // Main Work From Here
      return Stack(
        children: [
          Obx(() {
            //Get Current Question Data
            BattleQuestion currentQuestion = quizController.getCurrentQuestion();
      
            //Set Animation
            quizController.updateAnimatedListKeyIfNeeded(currentQuestion.id);
      
            return WillPopScope(
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
                            MyStrings.areYouSureYouWantToLeaveThisRoom,
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
                                child: const Text(
                                  MyStrings.cancel,
                                  style: regularLarge,
                                ),
                              ),
                              TextButton(
                                style: TextButton.styleFrom(backgroundColor: MyColor.primaryColor, foregroundColor: MyColor.colorWhite),
                                onPressed: () async {
                                  if (quizController.opponentLeftTheGame.isTrue) {
                                    // left User
                                    await quizController.battleRoomController
                                        .deleteBattleRoom(
                                      quizController.battleRoomController.battleRoomData.value!.roomId,
                                      false,
                                    )
                                        .whenComplete(() {
                                      Navigator.of(context).pop(true); // Return true when "Yes" is pressed
                                      Get.back();
                                    });
                                  } else {
                                    // left User
                                    await quizController.battleRoomController
                                        .leftBattleRoomFirebase(quizController.battleRoomController.battleRoomData.value!.roomId, false,
                                            currentUserId: quizController.battleRepo.apiClient.getUserID())
                                        .whenComplete(() {
                                      Navigator.of(context).pop(true); // Return true when "Yes" is pressed
                                      Get.back();
                                    });
                                  }
                                },
                                child: Text(
                                  MyStrings.yes,
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
      
              // Main Body Code Started
              child: Stack(
                children: [
                  CustomPaint(
                    child: Container(
                      padding: const EdgeInsets.all(Dimensions.space20),
                      decoration: BoxDecoration(
                        color: MyColor.colorWhite,
                        borderRadius: BorderRadius.circular(Dimensions.space20),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              LevelCardButton(
                                text: "${quizController.battleRoomController.battleRoomData.value!.entryFee} ${MyStrings.coins}",
                                hasIcon: false,
                                hasImage: false,
                              ),
                              LevelCardButton(
                                  text: "${quizController.currentQuestionIndex + 1}/${widget.qustionsList.length}", hasIcon: false, hasImage: false),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: AnimationLimiter(
                              key: quizController.animatedListKey,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: AnimationConfiguration.toStaggeredList(
                                    duration: const Duration(milliseconds: 500),
                                    childAnimationBuilder: (widget) => SlideAnimation(
                                      horizontalOffset: 50.0,
                                      child: FadeInAnimation(
                                        child: widget,
                                      ),
                                    ),
                                    children: [
                                      if (currentQuestion.image != null) ...[
                                        Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.only(top: Dimensions.space40, left: Dimensions.space8, right: Dimensions.space8),
                                          child: MyImageWidget(
                                            boxFit: BoxFit.contain,
                                            height: Get.width / 2,
                                            imageUrl: "${UrlContainer.battleQuestionImagePath}/${currentQuestion.image}",
                                          ),
                                        ),
                                      ],
                                      Container(
                                          padding: const EdgeInsets.only(top: Dimensions.space20),
                                          child: Text(
                                            currentQuestion.question,
                                            style: semiBoldExtraLarge.copyWith(fontWeight: FontWeight.w500),
                                            textAlign: TextAlign.center,
                                          )),
                                      const SizedBox(height: 20),
                                      Column(
                                        children: currentQuestion.options.asMap().entries.map<Widget>((entry) {
                                          int index = entry.key;
                                          BattleQuestionOption option = entry.value;
                                          String optionLetter = String.fromCharCode('A'.codeUnitAt(0) + index);
      
                                          return OptionButton(
                                            letter: optionLetter,
                                            option: option,
                                            onTap: () async {
                                              if (!quizController.isOptionSelectedForQuestion(currentQuestion.id, option) &&
                                                  !quizController.hasSubmittedAnswerForQuestion(currentQuestion.id)) {
                                                print("From Ans Save ");
                                                await quizController.battleRoomController.saveAnswer(
                                                  quizController.battleRepo.apiClient.getUserID(),
                                                  {
                                                    "qid": option.questionId,
                                                    "ans": option.id,
                                                    "isTrue": option.isAnswer,
                                                  },
                                                  option.isAnswer == "1",
                                                  questionsList: quizController.questionsList,
                                                );
                                                quizController.selectOptionForQuestion(currentQuestion.id, option);
                                              }
                                            },
                                            isSelected: quizController.isOptionSelectedForQuestion(currentQuestion.id, option),
                                          );
                                        }).toList(),
                                      ),
                                      const SizedBox(height: 50),
                                    ],
                                  )),
                            ),
                          ),
                          const SizedBox(
                            height: Dimensions.space25,
                          ),
                          const SizedBox(
                            height: Dimensions.space25,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 5,
                    left: 0,
                    right: 0,
                    child: SizedBox(
                      height: size.width / 7,
                      child: CircularCountDownTimer(
                        controller: quizController.countDownController,
                        duration: quizController.duration,
                        onComplete: () async {
                          print("From Counter Next Querstion");
                          if (quizController.hasMoreQuestions()) {
                            quizController.goToNextQuestion();
                          } else {
                            quizController.showLeftPopup(isUpdate: true);
                            print("Show Result page");
      
                            await quizController.finishBattleAndSubmitAnswer();
                          }
                        },
                        onChange: (v) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            quizController.showLeftPopup(isUpdate: true);
                          });
                        },
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
                      ),
                    ),
                  ),
                  //Load bar
                  if (quizController.isAnsSubmitting.isTrue) ...[
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          color: MyColor.colorWhite.withOpacity(0.9),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SpinKitPouringHourGlass(
                                  color: MyColor.spinLoadColor,
                                ),
                                SizedBox(
                                  height: Dimensions.space20,
                                ),
                                Text(
                                  MyStrings.pleaseWaitForYourBattleResultText,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]
                ],
              ),
            );
          }),
        ],
      );
    });
  }
}
