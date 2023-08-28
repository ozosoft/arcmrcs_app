import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_images.dart';
import 'package:flutter_prime/data/controller/quiz_contest/quiz_contest_questions_controller.dart';
import 'package:flutter_prime/view/components/buttons/level_card_button.dart';
import 'package:get/get.dart';

class QuizContestLifeLinesWidget extends StatefulWidget {
  final int questionIndex;
  const QuizContestLifeLinesWidget({super.key, required this.questionIndex});

  @override
  State<QuizContestLifeLinesWidget> createState() => _QuizContestLifeLinesWidgetState();
}

class _QuizContestLifeLinesWidgetState extends State<QuizContestLifeLinesWidget> {


  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuizContestQuestionsController>(
      builder: (controller) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              controller.makeFiftyFifty(widget.questionIndex);
            },
            child: Visibility(
               visible: !controller.fiftyFifty,
              child: const LevelCardButton(
                // lifelineUsed: controller.showQuestions,
                hasIcon: false,
                height: Dimensions.space75,
                width: Dimensions.space78,
                hasImage: true,
                image: MyImages.fiftyFiftySVG,
              ),
            ),
          ),
          Visibility(
            visible: !controller.audienceVote,
            child: InkWell(
              onTap: () {
                controller.audienceVotes(widget.questionIndex);
              },
              child: LevelCardButton(lifelineUsed: controller.audienceVote, hasIcon: false, height: Dimensions.space75, width: Dimensions.space78, hasImage: true, image: MyImages.groupSVG),
            ),
          ),
          InkWell(
            onTap: () {
              controller.countDownController.restart();
              controller.restartCountDownTimer(widget.questionIndex);
            },
            child: Visibility(
              visible: !controller.restartTimer,
              child: const LevelCardButton(
                  // lifelineUsed: controller.showQuestions,
                  hasIcon: false,
                  height: Dimensions.space75,
                  width: Dimensions.space78,
                  hasImage: true,
                  image: MyImages.timeSVG),
            ),
          ),
          Visibility(
            visible: !controller.flipQuistions,
            child: InkWell(
              onTap: () async {
                controller.flipQuiston(widget.questionIndex);
                print(controller.flipQuistion);
                controller.flipQuistion = "1";
              },
              child: const LevelCardButton(
                  // lifelineUsed: controller.showQuestions,
                  hasIcon: false,
                  height: Dimensions.space75,
                  width: Dimensions.space78,
                  hasImage: true,
                  image: MyImages.nextSVG),
            ),
          ),
        ],
      ),
    );
  }
}
