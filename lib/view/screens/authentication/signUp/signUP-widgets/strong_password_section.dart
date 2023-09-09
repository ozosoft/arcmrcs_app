import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_prime/core/utils/my_images.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/data/model/model/error_model.dart';
import 'package:get/get.dart';

class StrongPassWordCheakSection extends StatelessWidget {
  final List<ErrorModel> passwordValidationRules;

  const StrongPassWordCheakSection({
    Key? key,
    required this.passwordValidationRules,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        // Min 6 char Check
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              passwordValidationRules[4].hasError ? MyImages.loading : MyImages.greenTik,
            ),
            Text(
              " 6 ${MyStrings.character.tr} ",
              style: TextStyle(
                color: passwordValidationRules[4].hasError ? MyColor.colorBlack : MyColor.greenTik,
              ),
            ),
          ],
        ),

        // UpperCase Check
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              passwordValidationRules[0].hasError ? MyImages.loading : MyImages.greenTik,
            ),
            Text(
              " ${MyStrings.upperCase.tr} ",
              style: TextStyle(
                color: passwordValidationRules[0].hasError ? MyColor.colorBlack : MyColor.greenTik,
              ),
            ),
          ],
        ),

        // Lower case Check
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              passwordValidationRules[1].hasError ? MyImages.loading : MyImages.greenTik,
            ),
            Text(
              " ${MyStrings.lowerCase.tr} ",
              style: TextStyle(
                color: passwordValidationRules[1].hasError ? MyColor.colorBlack : MyColor.greenTik,
              ),
            ),
          ],
        ),

        // Symbol Check
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              passwordValidationRules[3].hasError ? MyImages.loading : MyImages.greenTik,
            ),
            Text(
              " ${MyStrings.symbol.tr} ",
              style: TextStyle(
                color: passwordValidationRules[3].hasError ? MyColor.colorBlack : MyColor.greenTik,
              ),
            ),
          ],
        ),

        // Number Check
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              passwordValidationRules[2].hasError ? MyImages.loading : MyImages.greenTik,
            ),
            Text(
              " ${MyStrings.hasDigit.tr} ",
              style: TextStyle(
                color: passwordValidationRules[2].hasError ? MyColor.colorBlack : MyColor.greenTik,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
