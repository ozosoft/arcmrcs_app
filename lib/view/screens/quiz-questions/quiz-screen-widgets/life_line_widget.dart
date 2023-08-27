import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_images.dart';
import 'package:flutter_prime/data/controller/quiz_questions/quiz_questions_controller.dart';
import 'package:flutter_prime/data/repo/quiz_questions_repo/quiz_questions_repo.dart';
import 'package:flutter_prime/data/services/api_service.dart';
import 'package:flutter_prime/view/components/buttons/level_card_button.dart';
import 'package:get/get.dart';

class LifeLinesWidget extends StatefulWidget {
  final int questionIndex;
  const LifeLinesWidget({super.key, required this.questionIndex});

  @override
  State<LifeLinesWidget> createState() => _LifeLinesWidgetState();
}

class _LifeLinesWidgetState extends State<LifeLinesWidget> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(QuizquestionsRepo(apiClient: Get.find()));
    Get.put(QuizQuestionsController(
      quizquestionsRepo: Get.find(),
    ));
    QuizQuestionsController controller = Get.put(QuizQuestionsController(quizquestionsRepo: Get.find()));

    controller.quizInfoID = Get.arguments[1];

    // print("++++++++++===============this is id"+quizinfoID.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuizQuestionsController>(
      builder: (controller) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              controller.showQuestion();
              print("object");
            },
            child: const LevelCardButton(
              // lifelineUsed: controller.showQuestions,
              hasIcon: false,
              height: Dimensions.space75,
              width: Dimensions.space78,
              hasImage: true,
              image: MyImages.fiftyFiftySVG,
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
          const LevelCardButton(
              // lifelineUsed: controller.showQuestions,
              hasIcon: false,
              height: Dimensions.space75,
              width: Dimensions.space78,
              hasImage: true,
              image: MyImages.timeSVG),
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
