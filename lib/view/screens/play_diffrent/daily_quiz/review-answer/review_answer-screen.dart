import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/view/components/app-bar/custom_category_appBar.dart';
import 'review-answer-screen-widgets/review_answer_section.dart';

class DailyQuizReviewAnswerScreen extends StatefulWidget {
 
  const DailyQuizReviewAnswerScreen({super.key});

  @override
  State<DailyQuizReviewAnswerScreen> createState() => _DailyQuizReviewAnswerScreenState();
}

class _DailyQuizReviewAnswerScreenState extends State<DailyQuizReviewAnswerScreen> {
  
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        appBar: CustomCategoryAppBar(title: MyStrings.reviewAnswer),
        body: ReviewAnswerSection()
      );
  }
}
