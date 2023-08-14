import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/view/components/app-bar/custom_category_appBar.dart';
import 'package:flutter_prime/view/screens/quiz-questions/quiz-screen-widgets/quiz_questions_body_section.dart';
import 'package:get/get.dart';

class QuizQuestionsScreen extends StatefulWidget {
  const QuizQuestionsScreen({super.key});

  @override
  State<QuizQuestionsScreen> createState() => _QuizQuestionsScreenState();
}

class _QuizQuestionsScreenState extends State<QuizQuestionsScreen> {
  final title = Get.arguments as String;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomCategoryAppBar(title: title.toString()),
        body: const SingleChildScrollView(
          padding: EdgeInsets.symmetric(
              horizontal: Dimensions.space15, vertical: Dimensions.space50),
          child: QuizBodySection(),
        ));
  }
}
