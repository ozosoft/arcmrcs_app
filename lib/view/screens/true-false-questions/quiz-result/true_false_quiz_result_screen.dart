import 'package:flutter/material.dart';
import 'package:quiz_lab/core/helper/unity-ads/unity_ads_helper.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';
import 'package:quiz_lab/core/utils/my_color.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/view/components/app-bar/custom_category_appbar.dart';
import 'package:quiz_lab/view/screens/general_quiz/quiz-result/widgets/quiz_result_body_section.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:quiz_lab/view/screens/true-false-questions/quiz-result/widgets/quiz_result_body_section.dart';

import '../../../../core/helper/ads/admob_helper.dart';
import '../../../../core/utils/my_images.dart';

class TrueFalseQuizResultScreen extends StatefulWidget {
  const TrueFalseQuizResultScreen({super.key});

  @override
  State<TrueFalseQuizResultScreen> createState() => _TrueFalseQuizResultScreenState();
}

class _TrueFalseQuizResultScreenState extends State<TrueFalseQuizResultScreen> {
  @override
  void initState() {
    super.initState();

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   // AdmobHelper().loadInterstitialAdAlways();
    //   // AdmobHelper().loadRewardAdAlways();


    // });

      WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await AdManager.loadUnityIntAd();
      await AdManager.loadUnityRewardedAd();
      await AdManager.showRewardedAd();
    });

    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.getScreenBgColor(),
      appBar: CustomCategoryAppBar(title: MyStrings.quizResult.tr),
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
              child: TruefalseQuizResultBodySection(), // Your existing content
            ),
          ),
        ],
      ),
    );
  }
}
