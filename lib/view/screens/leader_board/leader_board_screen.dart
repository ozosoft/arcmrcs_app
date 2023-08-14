import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/view/components/app-bar/custom_category_appBar.dart';

import 'widgets/background_screen_with_card.dart';


class LeaderBoardScreen extends StatelessWidget {
  const LeaderBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: MyColor.primaryColor,
      appBar: CustomCategoryAppBar(title: MyStrings.leaderBoard),
      body: SingleChildScrollView(child: BackGroundWithRankCard(),),
    );
  }
}