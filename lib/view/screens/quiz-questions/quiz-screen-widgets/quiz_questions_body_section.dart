import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_prime/core/route/route.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_images.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/core/utils/style.dart';
import 'package:flutter_prime/view/components/buttons/level_card_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../components/custom_path/custom_notch_clipper.dart';

class QuizBodySection extends StatefulWidget {
  const QuizBodySection({super.key});

  @override
  State<QuizBodySection> createState() => _QuizBodySectionState();
}

class _QuizBodySectionState extends State<QuizBodySection> {
  bool showQuestions = false;
  bool audienceVote = false;
  bool tapAnswer = false;

  int rightAnswerIndex = 0;
  int selectedAnswerIndex = -1;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        CustomPaint(
          painter: RPSCustomPainter(),
          child: Container(
            padding: const EdgeInsets.all(Dimensions.space20),
            decoration: BoxDecoration(
              // color: MyColor.colorWhite,
              borderRadius: BorderRadius.circular(Dimensions.space20),
            ),
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
                      MyStrings.quizQuestions,
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
                    itemCount: MyStrings().quizquestions.length,
                    itemBuilder: (BuildContext context, int index) {
                      print('current index: $index');

                      print('selected index: $selectedAnswerIndex');
                      print('answer index: $rightAnswerIndex');

                      return Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  selectedAnswerIndex = index;
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.all(Dimensions.space8),
                                padding: const EdgeInsets.symmetric(
                                    vertical: Dimensions.space15,
                                    horizontal: Dimensions.space15),
                                // height: Dimensions.space55,
                                // width: audienceVote == true
                                //     ? MediaQuery.of(context).size.width * .65
                                //     : MediaQuery.of(context).size.width * .78,
                                decoration: BoxDecoration(
                                    color: selectedAnswerIndex == index &&
                                            rightAnswerIndex == index
                                        ? MyColor.rightAnswerbgColor
                                        : selectedAnswerIndex == index
                                            ? MyColor.wrongAnsColor
                                            : MyColor.transparentColor,
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.space8),
                                    border: Border.all(
                                        color: MyColor.colorLightGrey)),
                                child: Row(
                                  children: [
                                    Text(
                                      MyStrings().quizquestions[index].rank,
                                      style: regularMediumLarge.copyWith(
                                          color: selectedAnswerIndex == index &&
                                                  rightAnswerIndex == index
                                              ? MyColor.colorWhite
                                              : selectedAnswerIndex == index
                                                  ? MyColor.colorWhite
                                                  : MyColor.textColor),
                                    ),
                                    const SizedBox(width: Dimensions.space8),
                                    Expanded(
                                      child: Text(
                                        MyStrings()
                                                .quizquestions[index]
                                                .questions,
                                        style: regularMediumLarge.copyWith(
                                            overflow: TextOverflow.visible,
                                            color: selectedAnswerIndex ==
                                                        index &&
                                                    rightAnswerIndex == index
                                                ? MyColor.colorWhite
                                                : selectedAnswerIndex == index
                                                    ? MyColor.colorWhite
                                                    : MyColor.textColor),
                                      ),
                                    ),
                                    SizedBox(
                                        height: Dimensions.space10,
                                        child: SvgPicture.asset(
                                          MyImages().rightORWrong[index],
                                          fit: BoxFit.cover,
                                        ))
                                  ],
                                ),
                              ),
                            ),
                          ),
                          // const Spacer(),
                          audienceVote == true
                              ? Text(
                                  MyStrings.fifteenPercent,
                                  style: semiBoldExtraLarge.copyWith(
                                      color: MyColor.colorQuizBodyAudText),
                                )
                              : const SizedBox()
                        ],
                      );
                    }),
                const SizedBox(
                  height: Dimensions.space25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          showQuestions = !showQuestions;
                        });
                      },
                      child: const LevelCardButton(
                        hasIcon: false,
                        height: Dimensions.space75,
                        width: Dimensions.space78,
                        hasImage: true,
                        image: MyImages.fiftyFiftySVG,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          audienceVote = !audienceVote;
                        });
                      },
                      child: const LevelCardButton(
                          hasIcon: false,
                          height: Dimensions.space75,
                          width: Dimensions.space78,
                          hasImage: true,
                          image: MyImages.groupSVG),
                    ),
                    const LevelCardButton(
                        hasIcon: false,
                        height: Dimensions.space75,
                        width: Dimensions.space78,
                        hasImage: true,
                        image: MyImages.timeSVG),
                    InkWell(
                      onTap: () {
                        Get.toNamed(RouteHelper.quizResultScreen,
                            arguments: MyStrings.quizResult);
                      },
                      child: const LevelCardButton(
                          hasIcon: false,
                          height: Dimensions.space75,
                          width: Dimensions.space78,
                          hasImage: true,
                          image: MyImages.nextSVG),
                    )
                  ],
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
              duration: Dimensions.space60.toInt(),
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
        ),
      ],
    );
  }
}
