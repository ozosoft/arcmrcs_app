import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';
import 'package:quiz_lab/data/controller/audio-questions/audio_questions_controller.dart';
import 'package:quiz_lab/data/repo/all_audio_questions/all_audio_questions_repo.dart';
import 'package:quiz_lab/data/repo/quiz_questions_repo/quiz_questions_repo.dart';
import 'package:quiz_lab/data/services/api_client.dart';
import 'package:quiz_lab/environment.dart';
import 'package:quiz_lab/view/components/app-bar/custom_category_appBar.dart';
import 'package:quiz_lab/view/components/mobile_ads/quiz_banner_ads_widget.dart';
import 'package:quiz_lab/view/screens/audio-questions/audio_questions/audio-questions-screen-widgets/audio_questions_body_section.dart';

class AudioQuestionsScreen extends StatefulWidget {
  const AudioQuestionsScreen({super.key});

  @override
  State<AudioQuestionsScreen> createState() => _AudioQuestionsScreenState();
}

class _AudioQuestionsScreenState extends State<AudioQuestionsScreen> {
 var title = '';
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(AllAudioQuizquestionsRepo(apiClient: Get.find()));

    AudioQuestionsController controller = Get.put(AudioQuestionsController(allAudioQuizquestionsRepo: Get.find()));
    controller.quizInfoID = Get.arguments[1];

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        title = Get.arguments[0] as String;
      });
      controller.getData(controller.quizInfoID.toString());
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomCategoryAppBar(title: title.toString().tr),
      body: const Stack(
        fit: StackFit.expand,
        children: [
          AudioQuestionsQuizBodySection(),
          Visibility(
            visible: Environment.isShowAdsOnQuizScreen,
            child: Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsetsDirectional.only(bottom: Dimensions.space10),
                  child: QuizBannerAdsWidget(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}