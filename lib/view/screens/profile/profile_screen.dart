import 'package:flutter/material.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/view/components/app-bar/custom_category_appbar.dart';
import 'package:get/get.dart';

import 'widgets/profile_details_section.dart';
import 'widgets/profile_overall_achivements_section.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: CustomCategoryAppBar(
        title: MyStrings.profile.tr,
      ),
      body: const SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            ProfileTopSection(),
            ProfileDetailsSection(),

            
          ],
        ),
      ),
    );
  }
}
