import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/view/components/app-bar/custom_category_appBar.dart';

import 'review-answer-screen-widgets/review_answer_section.dart';




class QuizContestReviewAnswerScreen extends StatefulWidget {
 
  const QuizContestReviewAnswerScreen({super.key});

  @override
  State<QuizContestReviewAnswerScreen> createState() => _QuizContestReviewAnswerScreenState();
}

class _QuizContestReviewAnswerScreenState extends State<QuizContestReviewAnswerScreen> {
  
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        appBar: CustomCategoryAppBar(title: MyStrings.reviewAnswer),
        body: QuizContestReviewAnswerSection()
      );
  }
}
