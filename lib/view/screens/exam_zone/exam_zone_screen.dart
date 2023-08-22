import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';

import '../../components/app-bar/custom_category_appBar.dart';
import 'widgets/exam_zone_tabbar_body_section.dart';

class ExamZoneScreen extends StatelessWidget {
  const ExamZoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomCategoryAppBar(title: "Exam"),
      body: ExamZoneTabBarBodySection(),
    );
  }
}
