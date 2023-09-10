
import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/view/components/app-bar/custom_category_appBar.dart';
import 'package:flutter_prime/view/screens/quiz_contest/review-answer/widget/review_answer_section.dart';
import 'package:get/get.dart';

class QuizContestReviewAnswerScreen extends StatefulWidget {
 
  const QuizContestReviewAnswerScreen({super.key});

  @override
  State<QuizContestReviewAnswerScreen> createState() => _QuizContestReviewAnswerScreenState();
}

class _QuizContestReviewAnswerScreenState extends State<QuizContestReviewAnswerScreen> {
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: CustomCategoryAppBar(title: MyStrings.reviewAnswer.tr),
        body: const QuizContestReviewAnswerSection()
      );
  }
}
