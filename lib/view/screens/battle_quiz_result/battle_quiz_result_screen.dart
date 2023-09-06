import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../core/utils/dimensions.dart';
import '../../../core/utils/my_color.dart';
import '../../../core/utils/my_images.dart';
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
    return Scaffold(
      backgroundColor: MyColor.primaryColor,
      appBar: const CustomCategoryAppBar(title: MyStrings.battleResult),

      
      body: Stack(
        children: [
          Positioned.fill(
            child: SvgPicture.asset(
              MyImages.reviewBgImage,
              fit: BoxFit.cover, // Fit the SVG to cover the whole container
            ),
          ),
          const BattleQuizResultBodySection(),
        ],
      ),
    );
  }
}
