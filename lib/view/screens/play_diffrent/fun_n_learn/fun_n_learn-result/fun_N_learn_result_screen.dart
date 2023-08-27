import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/view/components/app-bar/custom_category_appBar.dart';
import 'package:get/get.dart';
import 'widgets/fun_n_learn_result_body_section.dart';

class FunNlearnResultScreen extends StatefulWidget {
 
  const FunNlearnResultScreen({super.key});

  @override
  State<FunNlearnResultScreen> createState() => _FunNlearnResultScreenState();
}

class _FunNlearnResultScreenState extends State<FunNlearnResultScreen> {
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
              child: FunNLearnResultBodySection(),
            ),
          )
        ),
    );
  }
}
