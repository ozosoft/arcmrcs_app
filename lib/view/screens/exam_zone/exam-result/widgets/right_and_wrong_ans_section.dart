import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_images.dart';
import 'package:flutter_prime/core/utils/style.dart';
import 'package:flutter_svg/svg.dart';

class RightOrWrongAnsSection extends StatelessWidget {
  final String totalQuestions, correctAnswer, wrongAnswer;
  const RightOrWrongAnsSection({super.key, required this.totalQuestions, required this.correctAnswer, required this.wrongAnswer});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.space6), color: MyColor.categoryCardBodyColor),
          padding: const EdgeInsets.symmetric(vertical: Dimensions.space10, horizontal: Dimensions.space14),
          child: Row(
            children: [
              SvgPicture.asset(MyImages.greenTikSvg),
              const SizedBox(width: Dimensions.space6),
              Text(
                 "$correctAnswer / $totalQuestions",
                style: regularDefault.copyWith(
                  color: MyColor.rightAnswerbgColor,
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: Dimensions.space8, horizontal: Dimensions.space1),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.space6), color: MyColor.categoryCardBodyWrongColor),
          padding: const EdgeInsets.symmetric(vertical: Dimensions.space10, horizontal: Dimensions.space14),
          child: Row(
            children: [
              SvgPicture.asset(MyImages.wrongSvg),
              const SizedBox(
                width: Dimensions.space6,
              ),
              Text(
                "$wrongAnswer / $totalQuestions",
                style: regularDefault.copyWith(color: MyColor.wrongAnsColor),
              ),
            ],
          ),
        )
      ],
    );
  }
}
