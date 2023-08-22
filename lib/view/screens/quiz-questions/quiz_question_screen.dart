import 'package:flutter/material.dart';
import 'package:flutter_prime/view/components/app-bar/custom_category_appBar.dart';
import 'package:flutter_prime/view/screens/quiz-questions/quiz-screen-widgets/quiz_questions_body_section.dart';
import 'package:get/get.dart';

class QuizQuestionsScreen extends StatefulWidget {
  const QuizQuestionsScreen({super.key});

  @override
  State<QuizQuestionsScreen> createState() => _QuizQuestionsScreenState();
}

class _QuizQuestionsScreenState extends State<QuizQuestionsScreen> {
  final title = Get.arguments [0]as String;
  final id = Get.arguments [1] ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomCategoryAppBar(title: title.toString()),
        body:  QuizBodySection(id: id));
  }
}
