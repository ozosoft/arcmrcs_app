import 'package:flutter/material.dart';
import 'package:flutter_prime/core/route/route.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/view/components/buttons/rounded_button.dart';
import 'package:flutter_prime/view/components/snack_bar/show_custom_snackbar.dart';
import 'package:get/get.dart';
import '../../../../core/utils/my_strings.dart';

class BottomSectionButtons extends StatelessWidget {
  final String title;
  final int id;
  const BottomSectionButtons({super.key, required this.title, required this.id});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: Dimensions.space15, left: Dimensions.space15, right: Dimensions.space15),
          child: RoundedButton(
              text: MyStrings.nextLevel,
              press: () {
                id != 0
                    ? Get.offAndToNamed(RouteHelper.quizQuestionsScreen, arguments: [title, id])
                    : CustomSnackBar.error(errorList: [MyStrings.completeTheLevelFirst]);
              },
              textSize: Dimensions.space21),
        ),
        Padding(
          padding: const EdgeInsets.all(Dimensions.space15),
          child: RoundedButton(
            text: MyStrings.reviewAnswer,
            press: () {
              Get.toNamed(RouteHelper.reviewAnswerScreen);
              print(id);
            },
            color: MyColor.colorBlack,
            textSize: Dimensions.space21,
          ),
        )
      ],
    );
  }
}
