import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/view/components/app-bar/custom_category_appBar.dart';

import 'widgets/profile_details_section.dart';
import 'widgets/profile_overall_achivements_section.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomCategoryAppBar(
        title: MyStrings.profile,
      ),
      body: SingleChildScrollView(
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
