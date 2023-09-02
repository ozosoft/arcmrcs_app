import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/view/components/app-bar/custom_category_appBar.dart';
import 'package:get/get.dart';
import 'widgets/daily_quiz_result_body_section.dart';

class DailyQuizResultScreen extends StatefulWidget {
 
  const DailyQuizResultScreen({super.key});

  @override
  State<DailyQuizResultScreen> createState() => _DailyQuizResultScreenState();
}

class _DailyQuizResultScreenState extends State<DailyQuizResultScreen> {

  @override
  Widget build(BuildContext context) {
    return const RepaintBoundary(
      child: Scaffold(
        backgroundColor: MyColor.primaryColor,
         appBar: CustomCategoryAppBar(title: MyStrings.quizResult),
          body: SingleChildScrollView(
            child:  Padding(
              padding: EdgeInsets.symmetric(horizontal:Dimensions.space15,vertical: Dimensions.space50),
              child: DailyQuizResultBodySection(),
            ),
          )
        ),
    );
  }
}
