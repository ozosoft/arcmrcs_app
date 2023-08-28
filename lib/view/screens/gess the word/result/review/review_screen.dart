import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/core/utils/style.dart';
import 'package:flutter_prime/core/utils/util.dart';
import 'package:flutter_prime/data/controller/gesstheword/gess_the_word_Controller.dart';
import 'package:flutter_prime/data/repo/gess_the_word/gessThewordRepo.dart';
import 'package:flutter_prime/data/services/api_service.dart';
import 'package:flutter_prime/view/components/app-bar/custom_appbar.dart';
import 'package:flutter_prime/view/components/custom_loader/custom_loader.dart';
import 'package:get/get.dart';

class GessWordReviewResult extends StatefulWidget {
  const GessWordReviewResult({super.key});

  @override
  State<GessWordReviewResult> createState() => _GessWordReviewResultState();
}

class _GessWordReviewResultState extends State<GessWordReviewResult> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppBar(title: MyStrings.reviewAnswer, isTitleCenter: true),
        body: GetBuilder<GessThewordController>(builder: (controller) {
          return Padding(
            padding: Dimensions.screenPaddingHV,
            child: PageView.builder(
              itemCount: controller.gessThewordQuesstionList.length,
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: Dimensions.space40,
                          ),
                          Text(
                            controller.gessThewordQuesstionList[index].question.toString(),
                            style: mediumExtraLarge.copyWith(fontWeight: FontWeight.w500),
                          ),
                          // note: use  preloader or something like this
                          controller.gessThewordQuesstionList[index].image != null
                              ? Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.only(top: Dimensions.space40, left: Dimensions.space8, right: Dimensions.space8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl: '${controller.questionImgPath}/${controller.gessThewordQuesstionList[index].image}',
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
                              const Text('${MyStrings.yourAnswer}:'),
                              const SizedBox(width: Dimensions.space5),
                              Text(controller.gessThewordQuesstionList[index].selectedAnswer.toString(), style: mediumLarge, textAlign: TextAlign.center),
                            ],
                          ),
                          const SizedBox(height: Dimensions.space5),
                          Row(
                            children: [
                              const Text('${MyStrings.currectAnswer}:'),
                              const SizedBox(width: Dimensions.space5),
                              Text(controller.gessThewordQuesstionList[index].options![0].currectAns.toString(), style: mediumLarge, textAlign: TextAlign.center),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          margin: const EdgeInsets.only(bottom: Dimensions.space20),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: MyColor.borderColor,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text('${index + 1}/${controller.totalQuestion}'),
                        ),
                      ],
                    )
                  ],
                );
              },
            ),
          );
        }),
      ),
    );
  }
}
