import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/view/components/app-bar/custom_category_appBar.dart';
import 'package:flutter_prime/view/screens/quiz-result/widgets/quiz_result_body_section.dart';
import 'package:get/get.dart';

class QuizResultScreen extends StatefulWidget {
 
  const QuizResultScreen({super.key});

  @override
  State<QuizResultScreen> createState() => _QuizResultScreenState();
}

class _QuizResultScreenState extends State<QuizResultScreen> {
  final title = Get.arguments as String;
  @override
  Widget build(BuildContext context) {
    return const RepaintBoundary(
      child: Scaffold(
        backgroundColor: MyColor.primaryColor,
         appBar: CustomCategoryAppBar(title: MyStrings.quizResult),
          body: SingleChildScrollView(
            child:  Padding(
              padding: EdgeInsets.symmetric(horizontal:Dimensions.space15,vertical: Dimensions.space50),
              child: QuizResultBodySection(),
            ),
          )
        ),
    );
  }
}
