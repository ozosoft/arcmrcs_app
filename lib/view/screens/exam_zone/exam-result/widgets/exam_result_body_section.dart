import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_images.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/core/utils/style.dart';
import 'package:flutter_prime/data/controller/exam_zone/exam_zone_quiz_controller.dart';
import 'package:flutter_prime/data/repo/exam_zone/exam_zone_repo.dart';
import 'package:flutter_prime/data/services/api_service.dart';
import 'package:flutter_prime/view/components/divider/custom_dashed_divider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'bottom_section_buttons.dart';
import 'player_profile_picture.dart';
import 'rewards_section.dart';
import 'right_and_wrong_ans_section.dart';

class ExamResultBodySection extends StatefulWidget {
  const ExamResultBodySection({super.key});

  @override
  State<ExamResultBodySection> createState() => _ExamResultBodySectionState();
}

class _ExamResultBodySectionState extends State<ExamResultBodySection> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(ExamZoneRepo(apiClient: Get.find()));

    ExamZoneQuizController controller = Get.put(ExamZoneQuizController(examZoneRepo: Get.find()));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ExamZoneQuizController>(
      builder: (controller) {
        return Container(
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
                    child: controller.appreciation == "Failed"
                        ? SvgPicture.asset(
                            MyImages.victory,
                            fit: BoxFit.cover,
                            color: Colors.grey,
                          )
                        : SvgPicture.asset(
                            MyImages.victory,
                            fit: BoxFit.cover,
                          ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                        padding: const EdgeInsets.only(top: Dimensions.space100),
                        child: Text(
                          controller.appreciation,
                          style: semiBoldOverLarge.copyWith(fontSize: Dimensions.space30),
                        )),
                  ),
                  Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(top: Dimensions.space180),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          controller.appreciation == "Failed" ? MyStrings.betterLuckNextTime : MyStrings.victory,
                          style: regularOverLarge.copyWith(color: MyColor.colorQuizBodyText),
                        ),
                      )),
                ],
              ),
              const SizedBox(
                height: Dimensions.space10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RightOrWrongAnsSection(correctAnswer: controller.correctAnswer, wrongAnswer: controller.wrongAnswer, totalQuestions: controller.totalQuestions),
                  PlayerProfilePicture(
                    imagePath: controller.examZoneRepo.apiClient.getUserImagePath(),
                  ),
                  ExamRewardsSection(
                    totalCoin: controller.totalCoin,
                    winningCoin: controller.winningCoin,
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: Dimensions.space40),
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
