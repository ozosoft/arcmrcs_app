import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/view/components/app-bar/custom_category_appBar.dart';
import 'package:flutter_prime/view/screens/quiz-result/widgets/quiz_result_body_section.dart';
import 'package:get/get.dart';

class BattleQuizResultScreen extends StatefulWidget {
 
  const BattleQuizResultScreen({super.key});

  @override
  State<BattleQuizResultScreen> createState() => _BattleQuizResultScreenState();
}

class _BattleQuizResultScreenState extends State<BattleQuizResultScreen> {
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
