import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/view/components/app-bar/custom_category_appBar.dart';
import 'review-answer-screen-widgets/review_answer_section.dart';

class ExamReviewAnswerScreen extends StatefulWidget {
 
  const ExamReviewAnswerScreen({super.key});

  @override
  State<ExamReviewAnswerScreen> createState() => _ExamReviewAnswerScreenState();
}

class _ExamReviewAnswerScreenState extends State<ExamReviewAnswerScreen> {
  
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        appBar: CustomCategoryAppBar(title: MyStrings.reviewAnswer),
        body: ExamReviewAnswerSection()
      );
  }
}
