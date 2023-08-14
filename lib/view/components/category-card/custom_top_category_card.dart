import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/core/utils/style.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomTopCategoryCard extends StatelessWidget {
  final String title, questionsQuantaty, image;

  const CustomTopCategoryCard({
    super.key,
    required this.title,
    required this.questionsQuantaty,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimensions.space5),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: Dimensions.space17),
        width: Dimensions.space103,
        decoration: BoxDecoration(
            color: MyColor.cardColor,
            border: Border.all(color: MyColor.cardBorderColor),
            borderRadius: BorderRadius.circular(Dimensions.space8)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(image),
            Padding(
              padding: const EdgeInsets.symmetric( vertical: Dimensions.space10, horizontal: Dimensions.space5),
              child: Text(
                title.toString(),
                textAlign: TextAlign.center,
                style: semiBoldDefault,
              ),
            ),
            Text(MyStrings.questions,
                textAlign: TextAlign.center,
                style: regularDefault.copyWith(
                    color: MyColor.colorlighterGrey,
                    fontSize: Dimensions.space12))
          ],
        ),
      ),
    );
  }
}
