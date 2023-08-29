import 'package:cached_network_image/cached_network_image.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/core/utils/style.dart';
import 'package:flutter_prime/data/controller/gesstheword/gess_the_word_Controller.dart';
import 'package:flutter_prime/data/repo/gess_the_word/gessThewordRepo.dart';
import 'package:flutter_prime/data/services/api_service.dart';
import 'package:flutter_prime/view/components/buttons/level_card_button.dart';
import 'package:flutter_prime/view/components/buttons/rounded_button.dart';
import 'package:flutter_prime/view/components/custom_loader/custom_loader.dart';
import 'package:flutter_prime/view/screens/guess_the_word/widget/question_button.dart';

import 'package:get/get.dart';

import '../../../components/app-bar/custom_category_appBar.dart';
import '../widget/answer_field.dart';

class GuessThewordScreen extends StatefulWidget {
  const GuessThewordScreen({super.key});

  @override
  State<GuessThewordScreen> createState() => _GuessThewordScreenState();
}

class _GuessThewordScreenState extends State<GuessThewordScreen> {
  int id = 0;
  int currentQuestionIndex = 0;

  @override
  void initState() {
    id = Get.arguments as int;
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(GuessTheWordRepo(apiClient: Get.find()));
    final controller = Get.put(GuessThewordController(gessTheWordRepo: Get.find()));
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.clearAllData();
      controller.getQuestion(id.toString());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GuessThewordController>(builder: (controller) {
      return Scaffold(
          backgroundColor: MyColor.scaffoldBackgroundColor,
          appBar: const CustomCategoryAppBar(
            title: MyStrings.guessTheWord,
          ),
          body: controller.isLoading
              ? const CustomLoader()
              : Stack(
                  children: [
                    PageView.builder(
                      controller: controller.pageController,
                      itemCount: controller.gessThewordQuesstionList.length,
                      physics: const NeverScrollableScrollPhysics(),
                      onPageChanged: (index) {
                        setState(() {
                          currentQuestionIndex = index; // Update the current index
                        });
                      },
                      itemBuilder: (context, questionsIndex) {
                        return SingleChildScrollView(   physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.all(Dimensions.space20),
                          child: Stack(
                            children: [
                              Container(
                                key: ValueKey<int>(questionsIndex),
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.space20), color: MyColor.colorWhite),
                                padding: const EdgeInsets.all(Dimensions.space15),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        LevelCardButton(
                                            text: ' ${controller.gessTheWordRepo.apiClient.getUserCurrentCoin()} ${MyStrings.coins}',
                                            hasIcon: false,
                                            hasImage: false),
                                        LevelCardButton(
                                            text: " ${questionsIndex + 1}/${controller.gessThewordQuesstionList.length}",
                                            hasIcon: false,
                                            hasImage: false),
                                      ],
                                    ),
                                    const SizedBox(height: Dimensions.space20),
                                    // note: use  preloader or something like this
                                    controller.gessThewordQuesstionList[questionsIndex].image != null
                                        ? Container(
                                            width: double.infinity,
                                            padding:
                                                const EdgeInsets.only(top: Dimensions.space40, left: Dimensions.space8, right: Dimensions.space8),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(16),
                                            ),
                                            child: CachedNetworkImage(
                                              imageUrl: '${controller.questionImgPath}/${controller.gessThewordQuesstionList[questionsIndex].image}',
                                              fit: BoxFit.cover,
                                              height: 220,
                                              placeholder: (context, url) => const CustomLoader(isPagination: true),
                                              imageBuilder: (context, imageProvider) {
                                                return Container(
                                                    decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(14),
                                                  image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ));
                                              },
                                            ),
                                          )
                                        : const SizedBox(height: Dimensions.space20),
                                    Container(
                                        padding: const EdgeInsets.only(top: Dimensions.space20),
                                        child: Text(controller.gessThewordQuesstionList[questionsIndex].question.toString(),
                                            style: semiBoldExtraLarge.copyWith(fontWeight: FontWeight.w500), textAlign: TextAlign.center)),
                                    const SizedBox(height: Dimensions.space40),
                                    AnswerField(length: controller.gessThewordQuesstionList[questionsIndex].options![0].option!.length),

                                    const SizedBox(height: Dimensions.space30),
                                    GuessWordKeyBoard(
                                      ans: controller.gessThewordQuesstionList[questionsIndex].options![0].option.toString(),
                                    ),
                                    const SizedBox(height: Dimensions.space10),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: MyColor.primaryColor,
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: IconButton(
                                            onPressed: () {
                                              controller.removeVAlue();
                                            },
                                            icon: const Icon(
                                              Icons.delete_forever_outlined,
                                              color: MyColor.colorWhite,
                                            )),
                                      ),
                                    ),
                                    const SizedBox(height: Dimensions.space40),
                                    // RoundedButton(
                                    //   text: MyStrings.submit,
                                    //   press: () {
                                    //     controller.addAns(questionsIndex, controller.tempAns.join().toLowerCase().toString());
                                    //     questionsIndex == controller.gessThewordQuesstionList.length - 1
                                    //         ? controller.submitGuessTheWordAnswers()
                                    //         : controller.nextPage();
                                    //   },
                                    // ),
                                    const SizedBox(height: Dimensions.space40),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * .4),
                                child: CircularCountDownTimer(
                                  initialDuration: 0,
                                  duration: controller.ansDuration,
                                  width: Dimensions.space60,
                                  height: Dimensions.space80,
                                  ringColor: MyColor.primaryColor,
                                  ringGradient: null,
                                  fillColor: MyColor.timerbgColor,
                                  fillGradient: null,
                                  backgroundColor: MyColor.timerbgColor,
                                  strokeWidth: Dimensions.space5,
                                  strokeCap: StrokeCap.round,
                                  textStyle: semiBoldExtraLarge.copyWith(color: MyColor.primaryColor),
                                  textFormat: CountdownTextFormat.S,
                                  isReverse: true,
                                  isReverseAnimation: false,
                                  isTimerTextShown: true,
                                  autoStart: true,
                                  onComplete: () {
                                    controller.addAns(questionsIndex, controller.tempAns.join().toLowerCase().toString());
                                    questionsIndex == controller.gessThewordQuesstionList.length - 1
                                        ? controller.submitGuessTheWordAnswers()
                                        : controller.nextPage();
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    Positioned(
                      bottom: 20, // Adjust this value to control the distance from the bottom
                      left: 0,
                      right: 0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: Dimensions.space20),
                        child: Center(
                          child: RoundedButton(
                            text: MyStrings.submit,
                            press: () {
                              controller.addAns(currentQuestionIndex, controller.tempAns.join().toLowerCase().toString());
                              if (currentQuestionIndex == controller.gessThewordQuesstionList.length - 1) {
                                controller.submitGuessTheWordAnswers();
                              } else {
                                controller.nextPage();
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ));
    });
  }
}
