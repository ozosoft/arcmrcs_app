import 'package:flutter/material.dart';
import 'package:flutter_prime/view/components/app-bar/custom_category_appBar.dart';
import 'package:get/get.dart';

import '../../../../core/utils/my_strings.dart';
import 'review-answer-screen-widgets/review_answer_section.dart';

class ReviewAnswerScreen extends StatefulWidget {
 
  const ReviewAnswerScreen({super.key});

  @override
  State<ReviewAnswerScreen> createState() => _ReviewAnswerScreenState();
}

class _ReviewAnswerScreenState extends State<ReviewAnswerScreen> {
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: CustomCategoryAppBar(title: MyStrings.reviewAnswer.tr),
        body: const ReviewAnswerSection()
      );
  }
}
