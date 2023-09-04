import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_images.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/core/utils/style.dart';
import 'package:flutter_prime/data/controller/exam_zone/exam_zone_quiz_controller.dart';
import 'package:flutter_prime/data/repo/exam_zone/exam_zone_repo.dart';
import 'package:flutter_prime/data/services/api_service.dart';
import 'package:flutter_prime/view/components/buttons/level_card_button.dart';
import 'package:flutter_prime/view/components/custom_loader/custom_loader.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ExamReviewAnswerSection extends StatefulWidget {
  const ExamReviewAnswerSection({super.key});

  @override
  State<ExamReviewAnswerSection> createState() => _ExamReviewAnswerSectionState();
}

class _ExamReviewAnswerSectionState extends State<ExamReviewAnswerSection> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<ExamZoneQuizController>(
        builder: (controller) => controller.examQuestionsList.isEmpty
            ? const CustomLoader()
            : PageView.builder(
                physics: BouncingScrollPhysics(),
                controller: controller.reviewPageController,
                itemCount: controller.examQuestionsList.length,
                itemBuilder: (context, questionsIndex) {
                  controller.setCurrentOption(questionsIndex);

                  print('current question index: ${questionsIndex}');

                  return SingleChildScrollView(
                    padding: const EdgeInsets.all(Dimensions.space20),
                    child: Stack(
                      children: [
                        Container(
                          key: ValueKey<int>(controller.currentQuestionIndex),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.space20), color: MyColor.colorWhite),
                          padding: const EdgeInsets.all(Dimensions.space15),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                      onTap: () {
                                        if (controller.reviewPageController.page!.toInt() < controller.examQuestionsList.length) {
                                          controller.reviewPageController.nextPage(
                                            duration: const Duration(milliseconds: 500),
                                            curve: Curves.easeInOut,
                                          );
                                        }
                                      },
                                      child: const LevelCardButton(
                                        text: MyStrings.next,
                                        hasIcon: false,
                                        hasImage: false,
                                        bgColor: MyColor.primaryColor,
                                        hasbgColor: true,
                                        height: Dimensions.space40,
                                        hastextColor: true,
                                      )),
                                ],
                              ),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.only(top: Dimensions.space40, left: Dimensions.space8, right: Dimensions.space8),
                                child: Image.asset(
                                  MyImages.greatWallPNG,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(padding: const EdgeInsets.only(top: Dimensions.space20), child: Text(controller.examQuestionsList[questionsIndex].question!, style: semiBoldExtraLarge.copyWith(fontWeight: FontWeight.w500), textAlign: TextAlign.center)),
                              const SizedBox(height: Dimensions.space25),
                              ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: controller.examQuestionsList[questionsIndex].options!.length,
                                  itemBuilder: (BuildContext context, int optionIndex) {
                                    print("this is option id from review answer page" + controller.examQuestionsList[questionsIndex].selectedOptionId.toString());
                                    return Column(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.all(Dimensions.space8),
                                              padding: const EdgeInsets.symmetric(vertical: Dimensions.space15, horizontal: Dimensions.space15),
                                              height: Dimensions.space55,
                                              width: controller.audienceVote == true && controller.audienceVoteIndex == questionsIndex ? MediaQuery.of(context).size.width * .65 : MediaQuery.of(context).size.width * .75,
                                              decoration: BoxDecoration(
                                                  color: controller.examQuestionsList[questionsIndex].selectedOptionId!.isEmpty
                                                      ? MyColor.colorWhite
                                                      : controller.selectedOptionIndex == optionIndex
                                                          ? controller.isValidAnswer(questionsIndex, optionIndex)
                                                              ? MyColor.rightAnswerbgColor
                                                              : MyColor.wrongAnsColor
                                                          : controller.optionsList[optionIndex].isAnswer == '1'
                                                              ? MyColor.rightAnswerbgColor
                                                              : MyColor.colorWhite),
                                              child: Row(
                                                children: [
                                                  const SizedBox(width: Dimensions.space8),
                                                  Text(
                                                    controller.examQuestionsList[questionsIndex].options![optionIndex].option.toString(),
                                                    style: regularMediumLarge.copyWith(
                                                        color: controller.examQuestionsList[questionsIndex].selectedOptionId!.isEmpty
                                                            ? MyColor.textColor
                                                            : controller.selectedOptionIndex == optionIndex
                                                                ? controller.isValidAnswer(questionsIndex, optionIndex)
                                                                    ? MyColor.colorWhite
                                                                    : MyColor.colorWhite
                                                                : controller.optionsList[optionIndex].isAnswer == '1'
                                                                    ? MyColor.colorWhite
                                                                    : MyColor.textColor),
                                                  ),
                                                  const Spacer(),
                                                  SizedBox(
                                                      height: Dimensions.space10,
                                                      child: controller.examQuestionsList[questionsIndex].selectedOptionId!.isEmpty
                                                          ? const SizedBox()
                                                          : SvgPicture.asset(
                                                              "${controller.selectedOptionIndex == optionIndex ? controller.isValidAnswer(questionsIndex, optionIndex) ? MyImages.whiteTikSVG : MyImages.wrongAnswerSVG : controller.optionsList[optionIndex].isAnswer == '1' ? MyImages.whiteTikSVG : const SizedBox()}",
                                                              fit: BoxFit.cover))
                                                ],
                                              ),
                                            ),
                                            const Spacer(),
                                          ],
                                        ),
                                      ],
                                    );
                                  }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ));
  }
}
