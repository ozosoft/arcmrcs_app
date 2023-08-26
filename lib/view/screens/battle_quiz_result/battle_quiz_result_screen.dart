import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/dimensions.dart';
import '../../../core/utils/my_color.dart';
import '../../../core/utils/my_strings.dart';
import '../../components/app-bar/custom_category_appBar.dart';
import 'widgets/battle_quiz_result_body_section.dart';

class BattleQuizResultScreen extends StatefulWidget {
  const BattleQuizResultScreen({super.key});

  @override
  State<BattleQuizResultScreen> createState() => _BattleQuizResultScreenState();
}

class _BattleQuizResultScreenState extends State<BattleQuizResultScreen> {
  @override
  Widget build(BuildContext context) {
    return const RepaintBoundary(
      child: Scaffold(
          backgroundColor: MyColor.primaryColor,
          appBar: CustomCategoryAppBar(title: MyStrings.battleResult),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.space15, vertical: Dimensions.space50),
              child: BattleQuizResultBodySection(),
            ),
          )),
    );
  }
}
