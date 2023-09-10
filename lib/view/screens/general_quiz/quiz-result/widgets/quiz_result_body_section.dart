import 'package:flutter/material.dart';
import 'package:flutter_prime/core/route/route.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_images.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../../core/utils/my_color.dart';
import '../../../../../core/utils/my_strings.dart';
import '../../../../../core/utils/style.dart';
import '../../../../../data/controller/quiz_questions/quiz_questions_controller.dart';
import '../../../../../data/repo/quiz_questions_repo/quiz_questions_repo.dart';
import '../../../../../data/services/api_service.dart';
import '../../../../components/divider/custom_dashed_divider.dart';
import 'bottom_section_buttons.dart';
import 'player_profile_picture.dart';
import 'rewards_section.dart';
import 'right_and_wrong_ans_section.dart';

class QuizResultBodySection extends StatefulWidget {
  const QuizResultBodySection({super.key});

  @override
  State<QuizResultBodySection> createState() => _QuizResultBodySectionState();
}

class _QuizResultBodySectionState extends State<QuizResultBodySection> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(QuizquestionsRepo(apiClient: Get.find()));

    Get.put(QuizQuestionsController(quizquestionsRepo: Get.find()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuizQuestionsController>(builder: (controller) {
      return WillPopScope(
        onWillPop: () async {
          if (int.parse(controller.nextlevelQuizInfoId.toString()) == 0) {
            Get.offAllNamed(RouteHelper.bottomNavBarScreen);
          }
          return false;
        },
        child: Container(
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
                          controller.appreciation == "Failed" ? MyStrings.betterLuckNextTime.tr : MyStrings.victory.tr,
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
                    imagePath: controller.quizquestionsRepo.apiClient.getUserImagePath(),
                  ),
                  RewardsSection(
                    totalCoin: controller.totalCoin,
                    winningCoin: controller.winningCoin,
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
              BottomSectionButtons(
                title: controller.nextlevelQuizInfoTitle,
                id: int.parse(controller.nextlevelQuizInfoId.toString()),
              )
            ],
          ),
        ),
      );
    });
  }
}
