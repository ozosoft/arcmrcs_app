import 'package:flutter/material.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';
import 'package:quiz_lab/core/utils/my_color.dart';
import 'package:quiz_lab/core/utils/my_images.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/core/utils/style.dart';
import 'package:quiz_lab/data/controller/play_different_quizes/fun_n_learn/fun_n_learn_quiz_controller.dart';
import 'package:quiz_lab/data/repo/play_different_quizes/fun_n_learn/fun_n_learn_repo.dart';
import 'package:quiz_lab/data/services/api_service.dart';
import 'package:quiz_lab/view/components/buttons/level_card_button.dart';
import 'package:quiz_lab/view/components/custom_loader/custom_loader.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../../core/utils/url_container.dart';
import '../../../../../components/image_widget/my_image_widget.dart';

class FunNLearnReviewAnswerSection extends StatefulWidget {
  const FunNLearnReviewAnswerSection({super.key});

  @override
  State<FunNLearnReviewAnswerSection> createState() => _FunNLearnReviewAnswerSectionState();
}

class _FunNLearnReviewAnswerSectionState extends State<FunNLearnReviewAnswerSection> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(FunNLearnRepo(apiClient: Get.find()));
    Get.put(FunNlearnQuizController(
      funNLearnRepo: Get.find(),
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FunNlearnQuizController>(
        builder: (controller) => controller.examQuestionsList.isEmpty
            ? const CustomLoader()
            : PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: controller.reviewPageController,
                itemCount: controller.examQuestionsList.length,
                itemBuilder: (context, questionsIndex) {
                  var reviewItem = controller.examQuestionsList[questionsIndex];
                  controller.setCurrentOption(questionsIndex);

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
                                  if (questionsIndex < controller.examQuestionsList.length - 1) // Check if not on the last page
                                    ...[
                                    InkWell(
                                        onTap: () {
                                          if (controller.reviewPageController.page!.toInt() < controller.examQuestionsList.length) {
                                            controller.reviewPageController.nextPage(
                                              duration: const Duration(milliseconds: 500),
                                              curve: Curves.easeInOut,
                                            );
                                          }
                                        },
                                        child: LevelCardButton(
                                          text: MyStrings.next.tr,
                                          hasIcon: false,
                                          hasImage: false,
                                          bgColor: MyColor.primaryColor,
                                          hasbgColor: true,
                                          height: Dimensions.space40,
                                          hastextColor: true,
                                        )),
                                  ] else ...[
                                    // InkWell(
                                    //     onTap: () {},
                                    //     child: LevelCardButton(
                                    //       text: "${MyStrings.next.tr}",
                                    //       hasIcon: false,
                                    //       hasImage: false,
                                    //       bgColor: MyColor.battleTextColor,
                                    //       hasbgColor: true,
                                    //       height: Dimensions.space40,
                                    //       hastextColor: true,
                                    //     )),
                                  ],
                                ],
                              ),
                              const SizedBox(
                                height: Dimensions.space10,
                              ),
                              if (controller.examQuestionsList[questionsIndex].image != null) ...[
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsetsDirectional.only(top: Dimensions.space40, start: Dimensions.space8, end: Dimensions.space8),
                                  child: MyImageWidget(
                                    boxFit: BoxFit.contain,
                                    height: Get.width / 2,
                                    imageUrl: "${UrlContainer.questionImagePath}/${controller.examQuestionsList[questionsIndex].image}",
                                  ),
                                ),
                              ],
                              Container(padding: const EdgeInsetsDirectional.only(top: Dimensions.space20), child: Text(controller.examQuestionsList[questionsIndex].question!, style: semiBoldExtraLarge.copyWith(fontWeight: FontWeight.w500), textAlign: TextAlign.center)),
                              const SizedBox(height: Dimensions.space25),
                              ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: controller.examQuestionsList[questionsIndex].options!.length,
                                  itemBuilder: (BuildContext context, int optionIndex) {
                                    var reviewOptionItem = controller.optionsList[optionIndex];
                                    return Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                margin: const EdgeInsets.all(Dimensions.space8),
                                                padding: const EdgeInsets.symmetric(vertical: Dimensions.space15, horizontal: Dimensions.space15),
                                                decoration: BoxDecoration(
                                                    color: reviewItem.selectedOptionId!.isEmpty
                                                        ? MyColor.lightGray
                                                        : (reviewOptionItem.isAnswer == '1' && controller.isValidAnswer(questionsIndex, optionIndex) == true)
                                                            ? MyColor.rightAnswerbgColor
                                                            : (reviewItem.selectedOptionId.toString() == reviewOptionItem.id.toString())
                                                                ? MyColor.wrongAnsColor
                                                                : reviewOptionItem.isAnswer.toString() == "1"
                                                                    ? MyColor.rightAnswerbgColor
                                                                    : MyColor.lightGray),
                                                child: Row(
                                                  children: [
                                                    const SizedBox(width: Dimensions.space8),
                                                    Expanded(
                                                      child: Text(
                                                        "${controller.examQuestionsList[questionsIndex].options![optionIndex].option.toString()} ",
                                                        style: regularMediumLarge.copyWith(
                                                            color: reviewItem.selectedOptionId!.isEmpty
                                                                ? MyColor.colorBlack
                                                                : (reviewOptionItem.isAnswer == '1' && controller.isValidAnswer(questionsIndex, optionIndex) == true)
                                                                    ? MyColor.colorWhite
                                                                    : (reviewItem.selectedOptionId.toString() == reviewOptionItem.id.toString())
                                                                        ? MyColor.colorWhite
                                                                        : reviewOptionItem.isAnswer.toString() == "1"
                                                                            ? MyColor.colorWhite
                                                                            : MyColor.colorBlack),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: Dimensions.space10,
                                                      child: reviewItem.selectedOptionId!.isEmpty
                                                          ? reviewOptionItem.isAnswer == '1'
                                                              ? SvgPicture.asset(
                                                                  MyImages.whiteTikSVG,
                                                                  // color: MyColor.rightAnswerbgColor,
                                                                  colorFilter: const ColorFilter.mode(MyColor.rightAnswerbgColor, BlendMode.srcIn),
                                                                )
                                                              : const SizedBox()
                                                          : (reviewOptionItem.isAnswer == '1' && controller.isValidAnswer(questionsIndex, optionIndex) == true)
                                                              ? SvgPicture.asset(MyImages.whiteTikSVG)
                                                              : (reviewItem.selectedOptionId.toString() == reviewOptionItem.id.toString())
                                                                  ? SvgPicture.asset(MyImages.wrongAnswerSVG)
                                                                  : reviewOptionItem.isAnswer.toString() == "1"
                                                                      ? SvgPicture.asset(MyImages.whiteTikSVG)
                                                                      : const SizedBox(),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
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
