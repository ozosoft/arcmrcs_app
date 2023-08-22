import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_prime/core/route/route.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_images.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/core/utils/style.dart';
import 'package:flutter_prime/data/controller/battle/battle_room_controller.dart';
import 'package:flutter_prime/data/controller/battle/battle_room_quiz_controller.dart';
import 'package:flutter_prime/data/model/quiz/quiz_list_model.dart';
import 'package:flutter_prime/view/components/buttons/level_card_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../../../data/controller/auth/signin/signin_controller.dart';
import '../../../components/alert-dialog/custom_alert_dialog.dart';
import '../../../components/custom_path/custom_notch_clipper.dart';
import 'battle_quiz_option_button.dart';

class BattleQuizBodySection extends StatefulWidget {
  final List<Question> qustionsList;
  const BattleQuizBodySection({super.key, required this.qustionsList});

  @override
  State<BattleQuizBodySection> createState() => _BattleQuizBodySectionState();
}

class _BattleQuizBodySectionState extends State<BattleQuizBodySection> {
  bool showQuestions = false;
  bool audienceVote = false;
  bool tapAnswer = false;

  int rightAnswerIndex = 0;
  int selectedAnswerIndex = -1;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GetBuilder<BattleRoomQuizController>(
        init: BattleRoomQuizController(Get.put(BattleRoomController()), Get.find()),
        initState: (quizState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (quizState.controller!.questionsList.isEmpty) {
              quizState.controller!.questionsList.value = widget.qustionsList;
            }
          });
        },
        builder: (quizController) {
          if (quizController.opponentLeftTheGame.value == true) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (quizController.showLeftPopupValue.isFalse) {
                print("Show PopUp");
                CustomAlertDialog(
                        willPop: false,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              const Text("Oponent Left The game!"),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                "You Won.",
                                style: boldLarge,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
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
                                                currentUserId: quizController.signInController.user.value!.uid)
                                            .whenComplete(() {
                                          Navigator.of(context).pop(true); // Return true when "Yes" is pressed
                                          Get.back();
                                        });
                                      }
                                    },
                                    child: const Text(
                                      "Ok",
                                      style: regularLarge,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        barrierDismissible: false)
                    .customAlertDialog(context);
              }
              quizController.showLeftPopupUpdate(true);
            });
          }
          return WillPopScope(
            onWillPop: () async {
              CustomAlertDialog(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const Text("Are You sure You Want to leave this room!"),
                    const SizedBox(
                      height: 20,
                    ),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
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
                                      currentUserId: quizController.signInController.user.value!.uid)
                                  .whenComplete(() {
                                Navigator.of(context).pop(true); // Return true when "Yes" is pressed
                                Get.back();
                              });
                            }
                          },
                          child: const Text(
                            "Yes",
                            style: regularLarge,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(false); // Return false when "Cancel" is pressed
                          },
                          child: const Text(
                            "Cancel",
                            style: regularLarge,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )).customAlertDialog(context);
              return false; // Disable back button if `start` is true
            },

            // Main Body Code Started
            child: Obx(() {
              Question currentQuestion = quizController.getCurrentQuestion();
              int currentQuestionId = currentQuestion.id;

              // quizController.showLeftPopup(isUpdate: false);

              quizController.updateAnimatedListKeyIfNeeded(currentQuestionId);

              return Stack(
                children: [
                  CustomPaint(
                    painter: RPSCustomPainter3(),
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
                              const LevelCardButton(
                                text: MyStrings.oneFiftycoins,
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
                                    duration: const Duration(milliseconds: 375),
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
                                          child: Image.network(
                                            currentQuestion.image,
                                            fit: BoxFit.cover,
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
                                          Option option = entry.value;
                                          String optionLetter = String.fromCharCode('A'.codeUnitAt(0) + index);

                                          return OptionButton(
                                            letter: optionLetter,
                                            option: option,
                                            onTap: () async {
                                              if (!quizController.isOptionSelectedForQuestion(currentQuestion.id, option) &&
                                                  !quizController.hasSubmittedAnswerForQuestion(currentQuestion.id)) {
                                                print("From Ans Save ");
                                                await quizController.battleRoomController.saveAnswer(
                                                  quizController.signInController.user.value!.uid,
                                                  {
                                                    "qid": option.questionId,
                                                    "ans": option.isAnswer,
                                                  },
                                                  option.isAnswer == "1",
                                                  10,
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

                                      // Display "Previous" button if not on the first question
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          if (quizController.currentQuestionIndex > 0) ...[
                                            ElevatedButton(
                                              onPressed: () {
                                                quizController.goToPreviousQuestion();
                                              },
                                              child: const Text('Previous'),
                                            ),
                                          ],
                                          if (quizController.hasMoreQuestions())
                                            ElevatedButton(
                                              onPressed: () {
                                                quizController.goToNextQuestion();
                                              },
                                              child: const Text('Next Question'),
                                            ),
                                        ],
                                      ),

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {
                                              print(quizController.selectedOptions);
                                            },
                                            child: const Text('Submit'),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              quizController.selectedOptions.clear();
                                              quizController.countDownController.restart();
                                              quizController.update();
                                            },
                                            child: const Text('Clear Ans'),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              setState(() {});
                                            },
                                            child: const Text('Clear Ans'),
                                          ),
                                        ],
                                      ),
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
                        onComplete: () {
                          print("From Counter Next Querstion");
                          if (quizController.hasMoreQuestions()) {
                            quizController.goToNextQuestion();
                          } else {
                            quizController.showLeftPopup(isUpdate: true);
                            print("Show Result page");
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
                ],
              );
            }),
          );
        });
  }
}
