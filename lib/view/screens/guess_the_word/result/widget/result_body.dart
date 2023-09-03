import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_prime/core/route/route.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_images.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/core/utils/style.dart';
import 'package:flutter_prime/data/controller/gesstheword/gess_the_word_Controller.dart';
import 'package:flutter_prime/view/components/buttons/rounded_button.dart';
import 'package:flutter_prime/view/components/divider/custom_horizontal_divider.dart';
import 'package:flutter_prime/view/components/divider/custom_vertical_divider.dart';
import 'package:flutter_prime/view/components/image/custom_svg_picture.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../data/model/guess_the_word/guess_question_model.dart';

class GuessResultBody extends StatefulWidget {
  const GuessResultBody({super.key});

  @override
  State<GuessResultBody> createState() => _GuessResultBodyState();
}

class _GuessResultBodyState extends State<GuessResultBody> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<GuessThewordController>(builder: (controller) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.space20, vertical: Dimensions.space30),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.space20), color: MyColor.colorWhite),
        child: Column(
          children: [
            Column(
              children: [
                Text(
                  controller.totalScore,
                  style: mediumOverLarge,
                ),
                const SizedBox(
                  height: Dimensions.space2,
                ),
                const Text(
                  'Total Score',
                  style: lightDefault,
                ),
              ],
            ),
            const SizedBox(
              height: Dimensions.space40,
            ),
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: Dimensions.space40, left: Dimensions.space8, right: Dimensions.space8),
                  child: SvgPicture.asset(
                    MyImages.victory,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: CustomSvgPicture(image: MyImages.cup, color: Colors.orange.shade400, height: 200),
                ),
              ],
            ),
            const SizedBox(
              height: Dimensions.space10,
            ),
            Text("Victory!", style: semiBoldExtraLarge.copyWith(fontSize: Dimensions.fontExtraLarge)),

            const SizedBox(
              height: Dimensions.space20,
            ),
            // const CustomDashedDivider(height: 1, width: double.infinity),
            const CustomHorizontalDivider(),
            const SizedBox(
              height: Dimensions.space20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      controller.totalQuestion,
                      style: mediumLarge,
                    ),
                    const SizedBox(
                      height: Dimensions.space5,
                    ),
                    const Text(
                      'Total Question',
                      style: lightDefault,
                    ),
                  ],
                ),
                const CustomVerticalDivider(
                  height: Dimensions.space20,
                ),
                Column(
                  children: [
                    Text(
                      controller.correctAnswer,
                      style: mediumLarge,
                    ),
                    const SizedBox(
                      height: Dimensions.space5,
                    ),
                    Text(
                      'Correct Answer',
                      style: lightDefault.copyWith(color: MyColor.greenSuccessColor),
                    ),
                  ],
                ),
                const CustomVerticalDivider(
                  height: Dimensions.space20,
                ),
                Column(
                  children: [
                    Text(
                      controller.wrongAnswer.toString(),
                      style: mediumLarge,
                    ),
                    const SizedBox(
                      height: Dimensions.space5,
                    ),
                    Text(
                      'Wrong Answer',
                      style: lightDefault.copyWith(color: MyColor.redCancelTextColor),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: Dimensions.space40,
            ),
            RoundedButton(
                text: MyStrings.playAgain,
                press: () {
                  Get.offAndToNamed(RouteHelper.guessTheword, arguments: int.parse(controller.quizInfoId.toString()));
                },
                textSize: Dimensions.space21),
            const SizedBox(
              height: Dimensions.space20,
            ),
            RoundedButton(
              text: MyStrings.reviewAnswer,
              press: () {
                Get.offAndToNamed(RouteHelper.gessThewordResultReview,
                    arguments: [controller.gessThewordQuesstionList.isNotEmpty ? controller.gessThewordQuesstionList : <GuessQuestion>[]]);
              },
              color: MyColor.greenSuccessColor,
              textSize: Dimensions.space21,
            ),
            const SizedBox(
              height: Dimensions.space20,
            ),
            RoundedButton(
              text: MyStrings.home,
              press: () {
                Get.offAllNamed(RouteHelper.bottomNavBarScreen);
              },
              color: MyColor.colorBlack,
              textSize: Dimensions.space21,
            ),
          ],
        ),
      );
    });
  }
}
