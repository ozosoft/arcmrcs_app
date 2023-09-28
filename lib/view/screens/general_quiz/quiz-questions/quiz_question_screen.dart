import 'package:flutter/material.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';
import 'package:quiz_lab/view/components/app-bar/custom_category_appbar.dart';
import 'package:quiz_lab/view/screens/general_quiz/quiz-questions/quiz-screen-widgets/quiz_questions_body_section.dart';
import 'package:get/get.dart';

import '../../../components/mobile_ads/quiz_banner_ads_widget.dart';

class QuizQuestionsScreen extends StatefulWidget {
  const QuizQuestionsScreen({super.key});

  @override
  State<QuizQuestionsScreen> createState() => _QuizQuestionsScreenState();
}

class _QuizQuestionsScreenState extends State<QuizQuestionsScreen> {
  final title = Get.arguments[0] as String;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomCategoryAppBar(title: title.toString().tr),
      body: const Stack(
        fit: StackFit.expand,
        children: [
          QuizBodySection(),
          //Ads
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsetsDirectional.only(bottom: Dimensions.space10),
                child: QuizBannerAdsWidget(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
