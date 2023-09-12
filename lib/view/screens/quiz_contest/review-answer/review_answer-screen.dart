import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/view/components/app-bar/custom_category_appBar.dart';
import 'package:flutter_prime/view/screens/quiz_contest/review-answer/widget/review_answer_section.dart';
import 'package:get/get.dart';

import '../../../../core/utils/dimensions.dart';
import '../../../components/mobile_ads/quiz_banner_ads_widget.dart';

class QuizContestReviewAnswerScreen extends StatefulWidget {
  const QuizContestReviewAnswerScreen({super.key});

  @override
  State<QuizContestReviewAnswerScreen> createState() => _QuizContestReviewAnswerScreenState();
}

class _QuizContestReviewAnswerScreenState extends State<QuizContestReviewAnswerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomCategoryAppBar(title: MyStrings.reviewAnswer.tr),
        body: const Stack(
          fit: StackFit.expand,
          children: [
            QuizContestReviewAnswerSection(),
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
        ));
  }
}
