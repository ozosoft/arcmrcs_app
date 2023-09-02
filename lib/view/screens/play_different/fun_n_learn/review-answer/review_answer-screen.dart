import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/view/components/app-bar/custom_category_appBar.dart';
import 'review-answer-screen-widgets/review_answer_section.dart';

class FunNPlayReviewAnswerScreen extends StatefulWidget {
 
  const FunNPlayReviewAnswerScreen({super.key});

  @override
  State<FunNPlayReviewAnswerScreen> createState() => _FunNPlayReviewAnswerScreenState();
}

class _FunNPlayReviewAnswerScreenState extends State<FunNPlayReviewAnswerScreen> {
  
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        appBar: CustomCategoryAppBar(title: MyStrings.reviewAnswer),
        body: FunNLearnReviewAnswerSection()
      );
  }
}
