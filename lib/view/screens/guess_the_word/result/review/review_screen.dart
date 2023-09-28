import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';
import 'package:quiz_lab/core/utils/my_color.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/core/utils/style.dart';
import 'package:quiz_lab/data/controller/gesstheword/gess_the_word_review_result.dart';
import 'package:quiz_lab/view/components/custom_loader/custom_loader.dart';
import 'package:get/get.dart';

import '../../../../../core/utils/url_container.dart';
import '../../../../components/app-bar/custom_category_appbar.dart';
import '../../../../components/buttons/level_card_button.dart';
import '../../../../components/mobile_ads/quiz_banner_ads_widget.dart';

class GuessWordReviewResult extends StatefulWidget {
  const GuessWordReviewResult({super.key});

  @override
  State<GuessWordReviewResult> createState() => _GuessWordReviewResultState();
}

class _GuessWordReviewResultState extends State<GuessWordReviewResult> {
  @override
  void initState() {
    super.initState();

    var controller = Get.put(GuessThewordReviewResultController(gessTheWordRepo: Get.find()));

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.setGuessThewordQuestionList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomCategoryAppBar(
          title: MyStrings.reviewAnswer.tr,
        ),
        body: GetBuilder<GuessThewordReviewResultController>(builder: (controller) {
          return Stack(
            fit: StackFit.expand,
            children: [
              Padding(
                padding: Dimensions.screenPaddingHV,
                child: PageView.builder(
                  controller: controller.reviewPageController,
                  physics: const BouncingScrollPhysics(),
                  itemCount: controller.guessThewordQuestionList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      key: ValueKey<int>(index),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.space20), color: MyColor.colorWhite),
                      padding: const EdgeInsets.all(Dimensions.space20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // buttons
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(Dimensions.space12),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: MyColor.borderColor,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text('${index + 1}/${controller.guessThewordQuestionList.length}'),
                              ),
                              if (index < controller.guessThewordQuestionList.length - 1) // Check if not on the last page
                                ...[
                                InkWell(
                                    onTap: () {
                                      if (controller.reviewPageController.page!.toInt() < controller.guessThewordQuestionList.length) {
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
                              ]
                              
                            ],
                          ),
                          const SizedBox(
                            height: Dimensions.space50,
                          ),
                          Text(
                            controller.guessThewordQuestionList[index].question.toString(),
                            style: mediumExtraLarge.copyWith(fontWeight: FontWeight.w500),
                          ),
                          // note: use  preloader or something like this
                          controller.guessThewordQuestionList[index].image != null
                              ? Container(
                                  width: double.infinity,
                                  padding: const EdgeInsetsDirectional.only(top: Dimensions.space40, start: Dimensions.space8, end: Dimensions.space8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl: '${UrlContainer.questionImagePath}/${controller.guessThewordQuestionList[index].image}',
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
                              : const SizedBox.shrink(),
                          const SizedBox(height: Dimensions.space20),
                          Row(
                            children: [
                              Text('${MyStrings.yourAnswer.tr}:'),
                              const SizedBox(width: Dimensions.space5),
                              Text(controller.guessThewordQuestionList[index].selectedAnswer.toString(), style: mediumLarge, textAlign: TextAlign.center),
                            ],
                          ),
                          const SizedBox(height: Dimensions.space5),
                          Row(
                            children: [
                              Text('${MyStrings.currectAnswer.tr}:'),
                              const SizedBox(width: Dimensions.space5),
                              Text(controller.guessThewordQuestionList[index].options![0].currectAns.toString(), style: mediumLarge, textAlign: TextAlign.center),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsetsDirectional.only(bottom: Dimensions.space10),
                    child: QuizBannerAdsWidget(),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
