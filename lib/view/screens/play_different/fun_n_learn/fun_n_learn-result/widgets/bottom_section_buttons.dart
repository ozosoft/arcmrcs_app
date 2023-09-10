import 'package:flutter/material.dart';
import 'package:flutter_prime/core/route/route.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/data/model/play_different_quizes/fun_n_learn/fun_n_learn_questions_model.dart';
import 'package:flutter_prime/view/components/buttons/rounded_button.dart';
import 'package:get/get.dart';

class BottomSectionButtons extends StatelessWidget {
  const BottomSectionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: Dimensions.space15, left: Dimensions.space15, right: Dimensions.space15),
          child: RoundedButton(
              text: MyStrings.reviewAnswer.tr,
              press: () {
                Get.toNamed(RouteHelper.funNlearnResultReviewScreen, arguments: [Get.arguments[0] as List<Question>, Get.arguments[1]]);
              },
              textSize: Dimensions.space21),
        ),
        Padding(
          padding: const EdgeInsets.all(Dimensions.space15),
          child: RoundedButton(
            text: MyStrings.home.tr,
            press: () {
              Get.offAllNamed(RouteHelper.bottomNavBarScreen);
            },
            color: MyColor.colorBlack,
            textSize: Dimensions.space21,
          ),
        )
      ],
    );
  }
}
