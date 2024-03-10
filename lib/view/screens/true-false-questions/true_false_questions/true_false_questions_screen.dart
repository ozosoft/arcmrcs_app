import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';
import 'package:quiz_lab/data/controller/true-false-quiz/true_false_quiz_controller.dart';
import 'package:quiz_lab/data/repo/quiz_questions_repo/quiz_questions_repo.dart';
import 'package:quiz_lab/data/repo/true-false-questions/true_false_question_repo.dart';
import 'package:quiz_lab/data/services/api_client.dart';
import 'package:quiz_lab/environment.dart';
import 'package:quiz_lab/view/components/app-bar/custom_category_appBar.dart';
import 'package:quiz_lab/view/components/mobile_ads/quiz_banner_ads_widget.dart';
import 'package:quiz_lab/view/screens/general_quiz/quiz-questions/quiz-questions-screen-widgets/quiz_questions_body_section.dart';
import 'package:quiz_lab/view/screens/true-false-questions/true_false_questions/true_false_quiz-questions-screen-widgets/true_false_quiz_questions_body_section.dart';

class TrueFalseQuestionsScreen extends StatefulWidget {
  const TrueFalseQuestionsScreen({super.key});

  @override
  State<TrueFalseQuestionsScreen> createState() => _TrueFalseQuestionsScreenState();
}

class _TrueFalseQuestionsScreenState extends State<TrueFalseQuestionsScreen> {
 var title = '';
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(TrueFalseQuestionsRepo(apiClient: Get.find()));

    TrueFalseQuestionsController controller = Get.put(TrueFalseQuestionsController(trueFalseQuestionsRepo: Get.find()));
   controller.quizInfoID = Get.arguments[1];

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        title = Get.arguments[0] as String;
      });
      controller.getData(controller.quizInfoID.toString());
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomCategoryAppBar(title: title.toString().tr),
      body: const Stack(
        fit: StackFit.expand,
        children: [
          TrueFalseQuizBodySection(),
          Visibility(
            visible: Environment.isShowAdsOnQuizScreen,
            child: Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsetsDirectional.only(bottom: Dimensions.space10),
                  child: QuizBannerAdsWidget(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}