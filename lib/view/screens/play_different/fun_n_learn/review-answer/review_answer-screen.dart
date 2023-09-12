import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/view/components/app-bar/custom_category_appBar.dart';
import 'package:get/get.dart';
import '../../../../../core/utils/dimensions.dart';
import '../../../../components/mobile_ads/quiz_banner_ads_widget.dart';
import 'review-answer-screen-widgets/review_answer_section.dart';

class FunNPlayReviewAnswerScreen extends StatefulWidget {
  const FunNPlayReviewAnswerScreen({super.key});

  @override
  State<FunNPlayReviewAnswerScreen> createState() => _FunNPlayReviewAnswerScreenState();
}

class _FunNPlayReviewAnswerScreenState extends State<FunNPlayReviewAnswerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomCategoryAppBar(title: MyStrings.reviewAnswer.tr),
      body: const Stack(
        fit: StackFit.expand,
        children: [
          FunNLearnReviewAnswerSection(),
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
