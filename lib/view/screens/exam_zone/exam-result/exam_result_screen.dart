import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/view/components/app-bar/custom_category_appBar.dart';
import 'package:get/get.dart';
import 'widgets/exam_result_body_section.dart';

class ExamResultScreen extends StatefulWidget {
 
  const ExamResultScreen({super.key});

  @override
  State<ExamResultScreen> createState() => _ExamResultScreenState();
}

class _ExamResultScreenState extends State<ExamResultScreen> {
  final title = Get.arguments as String;
  @override
  Widget build(BuildContext context) {
    return  RepaintBoundary(
      child: Scaffold(
        backgroundColor: MyColor.primaryColor,
         appBar: CustomCategoryAppBar(title: MyStrings.examResult.tr),
          body: const SingleChildScrollView(
            child:  Padding(
              padding: EdgeInsets.symmetric(horizontal:Dimensions.space15,vertical: Dimensions.space50),
              child: ExamResultBodySection(),
            ),
          )
        ),
    );
  }
}
