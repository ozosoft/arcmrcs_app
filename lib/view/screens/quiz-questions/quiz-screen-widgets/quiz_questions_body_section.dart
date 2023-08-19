import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_prime/core/route/route.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_images.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/core/utils/style.dart';
import 'package:flutter_prime/data/repo/quiz_questions_repo/quiz_questions_repo.dart';
import 'package:flutter_prime/data/services/api_service.dart';
import 'package:flutter_prime/view/components/buttons/level_card_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../data/controller/quiz_questions/quiz_questions_controller.dart';
import 'life_line_widget.dart';

class QuizBodySection extends StatefulWidget {
  final int id;
  const QuizBodySection({super.key, required this.id});

  @override
  State<QuizBodySection> createState() => _QuizBodySectionState();
}

class _QuizBodySectionState extends State<QuizBodySection> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(QuizquestionsRepo(apiClient: Get.find()));
    Get.put(QuizQuestionsController(
      quizquestionsRepo: Get.find(),
    ));
    QuizQuestionsController controller =
        Get.put(QuizQuestionsController(quizquestionsRepo: Get.find()));

    controller.quizInfoID = Get.arguments[1];

    // print("++++++++++===============this is id"+quizinfoID.toString());
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getdata(controller.quizInfoID.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuizQuestionsController>(
      builder: (controller) => Stack(
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            transitionBuilder: (Widget child, Animation<double> animation) {
              final offsetAnimation =
                  Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0))
                      .animate(animation);

              return SlideTransition(position: offsetAnimation, child: child);
            },
            child: Container(
              key: ValueKey<int>(controller.currentQuestionIndex),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.space20),
                  color: MyColor.colorWhite),
              padding: const EdgeInsets.all(Dimensions.space15),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      LevelCardButton(
                        text: MyStrings.oneFiftycoins,
                        hasIcon: false,
                        hasImage: false,
                      ),
                      LevelCardButton(
                          text: MyStrings.quiestionsLimit,
                          hasIcon: false,
                          hasImage: false),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(
                        top: Dimensions.space40,
                        left: Dimensions.space8,
                        right: Dimensions.space8),
                    child: Image.asset(
                      MyImages.greatWallPNG,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                      padding: const EdgeInsets.only(top: Dimensions.space20),
                      child: Text(
                     controller.questionsList[0].question!,
                        style: semiBoldExtraLarge.copyWith(
                            fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      )),
                  const SizedBox(
                    height: Dimensions.space25,
                  ),
                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount:  controller.optionsList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Row(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  controller.selectedAnswerIndex = index;

                                  if (controller.currentQuestionIndex <
                                     controller.questionsList[index].question!.length - 1) {
                                    controller.currentQuestionIndex++;
                                  } else {}
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.all(Dimensions.space8),
                                padding: const EdgeInsets.symmetric(
                                    vertical: Dimensions.space15,
                                    horizontal: Dimensions.space15),
                                height: Dimensions.space55,
                                width: controller.audienceVote == true
                                    ? MediaQuery.of(context).size.width * .65
                                    : MediaQuery.of(context).size.width * .78,
                                decoration: BoxDecoration(
                                    color: controller.selectedAnswerIndex ==index &&controller.rightAnswerIndex == index
                                        ? MyColor.rightAnswerbgColor
                                        : controller.selectedAnswerIndex ==index
                                            ? MyColor.wrongAnsColor
                                            : MyColor.transparentColor,
                                    borderRadius: BorderRadius.circular(Dimensions.space8),
                                    border: Border.all(color: MyColor.colorLightGrey)),
                                child: Row(
                                  children: [
                                    // Text(
                                    //   MyStrings().quizquestions[index].rank,
                                    //   style: regularMediumLarge.copyWith(
                                    //       color: controller
                                    //                       .selectedAnswerIndex ==
                                    //                   index &&
                                    //               controller.rightAnswerIndex ==
                                    //                   index
                                    //           ? MyColor.colorWhite
                                    //           : controller.selectedAnswerIndex ==
                                    //                   index
                                    //               ? MyColor.colorWhite
                                    //               : MyColor.textColor),
                                    // ),
                                    const SizedBox(width: Dimensions.space8),
                                    Text(
                                      controller.optionsList[index].option.toString(),
                                      style: regularMediumLarge.copyWith(
                                          color: controller.selectedAnswerIndex ==index &&controller.rightAnswerIndex ==index
                                              ? MyColor.colorWhite
                                              : controller.selectedAnswerIndex ==index
                                                  ? MyColor.colorWhite
                                                  : MyColor.textColor),
                                    ),
                                    const Spacer(),
                                    // SizedBox(
                                    //     height: Dimensions.space10,
                                    //     child: SvgPicture.asset(MyImages().rightORWrong[index],fit: BoxFit.cover))
                                  ],
                                ),
                              ),
                            ),
                            const Spacer(),
                            controller.audienceVote == true
                                ? Text(MyStrings.fifteenPercent,style: semiBoldExtraLarge.copyWith(color: MyColor.colorQuizBodyAudText))
                                : const SizedBox()
                          ],
                        );
                      }),
                  const SizedBox(
                    height: Dimensions.space25,
                  ),
                 const LifeLinesWidget(),
                  
                  const SizedBox(
                    height: Dimensions.space25,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding:
                EdgeInsets.only(left: MediaQuery.of(context).size.width * .4),
            child: CircularCountDownTimer(
              duration: Dimensions.space30.toInt(),
              initialDuration: 0,
              controller: CountDownController(),
              width: Dimensions.space60,
              height: Dimensions.space80,
              ringColor: MyColor.primaryColor,
              ringGradient: null,
              fillColor: MyColor.timerbgColor,
              fillGradient: null,
              backgroundColor: MyColor.timerbgColor,
              strokeWidth: Dimensions.space5,
              strokeCap: StrokeCap.round,
              textStyle:
                  semiBoldExtraLarge.copyWith(color: MyColor.primaryColor),
              textFormat: CountdownTextFormat.S,
              isReverse: true,
              isReverseAnimation: false,
              isTimerTextShown: true,
              autoStart: true,
              onComplete: () {},
              
            ),
          ),
        ],
      ),
    );
  }
}
