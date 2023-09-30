import 'package:flutter/material.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';
import 'package:quiz_lab/core/utils/my_color.dart';
import 'package:quiz_lab/core/utils/my_images.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/core/utils/style.dart';
import 'package:quiz_lab/data/controller/play_different_quizes/daily_quiz/daily_quiz_questions_controller.dart';
import 'package:quiz_lab/data/repo/play_different_quizes/daily_quiz/daily_quiz_repo.dart';
import 'package:quiz_lab/data/services/api_client.dart';
import 'package:quiz_lab/view/components/divider/custom_dashed_divider.dart';
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

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(DailyQuizRepo(apiClient: Get.find()));

    Get.put(DailyQuizQuestionsController(
      dailyQuizRepo: Get.find(),
    ));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DailyQuizQuestionsController>(
      builder: (controller) {
        return Container(
          margin: const EdgeInsetsDirectional.only(top: Dimensions.space20),
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
                    padding: const EdgeInsetsDirectional.only(top: Dimensions.space40, start: Dimensions.space8, end: Dimensions.space8),
                    child: controller.appreciation == "Failed"
                        ? SvgPicture.asset(
                            MyImages.victory,
                            fit: BoxFit.cover,
                            colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
                          )
                        : SvgPicture.asset(
                            MyImages.victory,
                            fit: BoxFit.cover,
                          ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                        padding: const EdgeInsetsDirectional.only(top: Dimensions.space100),
                        child: Column(
                          children: [
                            Text(
                              controller.appreciation,
                              textAlign: TextAlign.center,
                              style: semiBoldOverLarge.copyWith(fontSize: Dimensions.space30),
                            ),
                            const SizedBox(
                              height: Dimensions.space10,
                            ),
                            Text(
                              controller.appreciation == "Failed" ? MyStrings.betterLuckNextTime.tr : MyStrings.victory.tr,
                              textAlign: TextAlign.center,
                              style: regularOverLarge.copyWith(color: MyColor.colorQuizBodyText),
                            ),
                          ],
                        )),
                  ),
                ],
              ),
              const SizedBox(
                height: Dimensions.space15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: RightOrWrongAnsSection(correctAnswer: controller.correctAnswer, wrongAnswer: controller.wrongAnswer, totalQuestions: controller.totalQuestions)),
                  Container(
                    margin: const EdgeInsets.all(Dimensions.space10),
                    child: PlayerProfilePicture(
                      imagePath: controller.dailyQuizRepo.apiClient.getUserImagePath(),
                    ),
                  ),
                  Expanded(
                    child: ExamRewardsSection(
                      totalCoin: controller.totalCoin,
                      winningCoin: controller.winningCoin,
                    ),
                  )
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
        );
      },
    );
  }
}
