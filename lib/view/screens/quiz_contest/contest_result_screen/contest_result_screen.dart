import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/view/components/app-bar/custom_category_appBar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/utils/my_images.dart';
import 'widgets/quiz_contest_result_body_section.dart';

class QuizContestResultScreen extends StatefulWidget {
  const QuizContestResultScreen({super.key});

  @override
  State<QuizContestResultScreen> createState() => _QuizContestResultScreenState();
}

class _QuizContestResultScreenState extends State<QuizContestResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.primaryColor,
      appBar: const CustomCategoryAppBar(title: MyStrings.quizResult),
      body: Stack(
        children: [
          Positioned.fill(
            child: SvgPicture.asset(
              MyImages.reviewBgImage,
              fit: BoxFit.cover, // Make the image cover the full width
            ),
          ),

          /// Background image
          const SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.space15,
                vertical: Dimensions.space50,
              ),
              child: QuizContestResultSection(), // Your existing content
            ),
          ),
        ],
      ),
    );
  }
}
