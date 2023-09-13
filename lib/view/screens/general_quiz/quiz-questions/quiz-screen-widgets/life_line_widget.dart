import 'package:flutter/material.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';
import 'package:quiz_lab/core/utils/my_images.dart';
import 'package:quiz_lab/data/controller/quiz_questions/quiz_questions_controller.dart';
import 'package:quiz_lab/view/components/buttons/level_card_button.dart';
import 'package:get/get.dart';

class LifeLinesWidget extends StatefulWidget {
  final int questionIndex;
  const LifeLinesWidget({super.key, required this.questionIndex});

  @override
  State<LifeLinesWidget> createState() => _LifeLinesWidgetState();
}

class _LifeLinesWidgetState extends State<LifeLinesWidget> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuizQuestionsController>(
      builder: (controller) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              if (controller.fiftyFifty == true) {
                // CustomSnackBar.error(errorList: [MyStrings.lifeLineAlreadyUsed.tr]);
              } else {
                controller.makeFiftyFifty(widget.questionIndex);
              }
            },
            child: LevelCardButton(
              // lifelineUsed: controller.showQuestions,
              hasIcon: false,
              height: Dimensions.space75,
              width: Dimensions.space78,
              hasImage: true,
              lifelineUsed: controller.fiftyFifty,
              image: MyImages.fiftyFiftySVG,
            ),
          ),
          InkWell(
            onTap: () {
              if (controller.audienceVote == true) {
                // CustomSnackBar.error(errorList: [MyStrings.lifeLineAlreadyUsed.tr]);
              } else {
                controller.audienceVotes(widget.questionIndex);
              }
            },
            child: LevelCardButton(lifelineUsed: controller.audienceVote, hasIcon: false, height: Dimensions.space75, width: Dimensions.space78, hasImage: true, image: MyImages.groupSVG),
          ),
          InkWell(
            onTap: () {
              if (controller.restartTimer) {
                // CustomSnackBar.error(errorList: [MyStrings.lifeLineAlreadyUsed.tr]);
              } else {
                controller.countDownController.restart();
                controller.restartCountDownTimer(widget.questionIndex);
              }
            },
            child: LevelCardButton(lifelineUsed: controller.restartTimer, hasIcon: false, height: Dimensions.space75, width: Dimensions.space78, hasImage: true, image: MyImages.timeSVG),
          ),
          InkWell(
            onTap: () async {
              if (controller.flipQuistions) {
                // CustomSnackBar.error(errorList: [MyStrings.lifeLineAlreadyUsed.tr]);
              } else {
                controller.flipQuiston(widget.questionIndex);
                debugPrint(controller.flipQuistion);
                controller.flipQuistion = "1";
              }
            },
            child: LevelCardButton(lifelineUsed: controller.flipQuistions, hasIcon: false, height: Dimensions.space75, width: Dimensions.space78, hasImage: true, image: MyImages.nextSVG),
          ),
        ],
      ),
    );
  }
}
