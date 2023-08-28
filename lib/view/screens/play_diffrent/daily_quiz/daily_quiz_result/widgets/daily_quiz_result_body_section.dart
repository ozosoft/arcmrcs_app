import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_images.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/core/utils/style.dart';
import 'package:flutter_prime/data/controller/play_diffrent_quizes/daily_quiz/daily_quiz_questions_controller.dart';
import 'package:flutter_prime/data/controller/play_diffrent_quizes/fun_n_learn/fun_n_learn_quiz_controller.dart';
import 'package:flutter_prime/data/repo/play_diffrent_quizes/daily_quiz/daily_quiz_repo.dart';
import 'package:flutter_prime/data/repo/play_diffrent_quizes/fun_n_learn/fun_n_learn_repo.dart';
import 'package:flutter_prime/data/services/api_service.dart';
import 'package:flutter_prime/view/components/divider/custom_dashed_divider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'bottom_section_buttons.dart';
import 'player_profile_picture.dart';
import 'rewards_section.dart';
import 'right_and_wrong_ans_section.dart';

class DailyQuizResultBodySection extends StatefulWidget {
  const DailyQuizResultBodySection({super.key});

  @override
  State<DailyQuizResultBodySection> createState() => _DailyQuizResultBodySectionState();
}

class _DailyQuizResultBodySectionState extends State<DailyQuizResultBodySection> {
  bool showQuestions = false;
  bool audienceVote = false;
  bool tapAnswer = false;

  // @override
  // void initState() {
  //   // Get.put(ApiClient(sharedPreferences: Get.find()));
  //   // Get.put(DailyQuizRepo(apiClient: Get.find()));

  //   // DailyQuizQuestionsController controller = Get.put(DailyQuizQuestionsController( dailyQuizRepo: Get.find(),));

  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<DailyQuizQuestionsController>(
      builder: (controller) => Stack(
        children: [
          SvgPicture.asset(MyImages.reviewBgImage),
          Container(
            margin: const EdgeInsets.only(top: Dimensions.space20),
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.space20),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.space20), color: MyColor.colorWhite),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(top: Dimensions.space40, left: Dimensions.space8, right: Dimensions.space8),
                      child: SvgPicture.asset(
                        MyImages.victory,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                        width: double.infinity,
                        padding: EdgeInsets.only(left: size.width * .3, top: Dimensions.space100),
                        child: Text(
                          MyStrings.victory,
                          style: semiBoldOverLarge.copyWith(fontSize: Dimensions.space30),
                        )),
                    Container(
                        width: double.infinity,
                        padding: EdgeInsets.only(top: Dimensions.space180),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            controller.appreciation,
                            style: regularOverLarge.copyWith(color: MyColor.colorQuizBodyText),
                          ),
                        )),
                   
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RightOrWrongAnsSection(correctAnswer: controller.correctAnswer, wrongAnswer: controller.wrongAnswer, totalQuestions: controller.totalQuestions),
                    const PlayerProfilePicture(),
                    ExamRewardsSection(
                      totalCoin: controller.totalCoin,
                      winningCoin: controller.winningCoin,
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: Dimensions.space50),
                  child: CustomDashedDivider(
                    height: Dimensions.space1,
                    width: double.infinity,
                  ),
                ),
                const BottomSectionButtons()
              ],
            ),
          ),
        ],
      ),
    );
  }
}