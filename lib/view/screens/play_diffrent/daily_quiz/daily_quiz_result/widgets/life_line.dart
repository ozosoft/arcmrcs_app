import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_images.dart';
import 'package:flutter_prime/data/controller/play_diffrent_quizes/daily_quiz/daily_quiz_questions_controller.dart';
import 'package:flutter_prime/data/controller/play_diffrent_quizes/fun_n_learn/fun_n_learn_quiz_controller.dart';
import 'package:flutter_prime/data/repo/play_diffrent_quizes/daily_quiz/daily_quiz_repo.dart';
import 'package:flutter_prime/data/services/api_service.dart';
import 'package:flutter_prime/view/components/buttons/level_card_button.dart';
import 'package:get/get.dart';

class DailyQuizLifeLinesWidget extends StatefulWidget {
  final int questionIndex;
  const DailyQuizLifeLinesWidget({super.key, required this.questionIndex});

  @override
  State<DailyQuizLifeLinesWidget> createState() => _DailyQuizLifeLinesWidgetState();
}

class _DailyQuizLifeLinesWidgetState extends State<DailyQuizLifeLinesWidget> {
  @override
  void initState() {
  Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(DailyQuizRepo(apiClient: Get.find()));

    DailyQuizQuestionsController controller = Get.put(DailyQuizQuestionsController( dailyQuizRepo: Get.find(),));

    controller.quizInfoID = Get.arguments[1];

    // print("++++++++++===============this is id"+quizinfoID.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FunNlearnQuizController>(
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
