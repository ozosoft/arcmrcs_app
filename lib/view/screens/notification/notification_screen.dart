import 'package:flutter/material.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/view/components/app-bar/custom_category_appBar.dart';
import 'package:quiz_lab/view/screens/notification/widget/notification_card_screen.dart';
import 'package:get/get.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomCategoryAppBar(title: MyStrings.notification.tr),
      body: const NotificationCardScreen(),
    );
  }
}
