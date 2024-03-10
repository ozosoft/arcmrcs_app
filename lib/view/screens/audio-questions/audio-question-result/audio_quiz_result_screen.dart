import 'package:flutter/material.dart';
import 'package:quiz_lab/core/helper/unity-ads/unity_ads_helper.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';
import 'package:quiz_lab/core/utils/my_color.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/data/services/api_client.dart';
import 'package:quiz_lab/view/components/app-bar/custom_category_appbar.dart';
import 'package:quiz_lab/view/screens/audio-questions/audio-question-result/widgets/audio_quiz_result_body_section.dart';
import 'package:quiz_lab/view/screens/general_quiz/quiz-result/widgets/quiz_result_body_section.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../core/helper/ads/admob_helper.dart';
import '../../../../core/utils/my_images.dart';

class AudioQuizResultScreen extends StatefulWidget {
  const AudioQuizResultScreen({super.key});

  @override
  State<AudioQuizResultScreen> createState() => _AudioQuizResultScreenState();
}

class _AudioQuizResultScreenState extends State<AudioQuizResultScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
         AdManager.loadUnityRewardedAd();

      Get.find<ApiClient>().isAdmobAddEnable() ? AdmobHelper().loadRewardAdAlways() : AdManager.showRewardedAd();
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
              fit: BoxFit.cover, 
            ),
          ),
          const SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.space15,
                vertical: Dimensions.space50,
              ),
              child: AudioQuizResultBodySection(),
            ),
          ),
        ],
      ),
    );
  }
}