import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_images.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/core/utils/style.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/my_color.dart';

class RewardsSection extends StatelessWidget {
  final String winningCoin, totalCoin;
  const RewardsSection({super.key, required this.winningCoin, required this.totalCoin});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(vertical: Dimensions.space5, horizontal: Dimensions.space4),
                child: Container(
                  constraints: const BoxConstraints(minWidth: Dimensions.space81),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.space6), color: MyColor.lineColor),
                  padding: const EdgeInsets.symmetric(vertical: Dimensions.space10, horizontal: Dimensions.space20),
                  child: Row(
                    children: [
                      SvgPicture.asset(MyImages.point),
                      const SizedBox(width: Dimensions.space6),
                      Text(
                        winningCoin,
                        style: regularDefault.copyWith(color: MyColor.textColor),
                      ),
                    ],
                  ),
                )),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: Dimensions.space5, horizontal: Dimensions.space4),
                child: Container(
                  constraints: const BoxConstraints(minWidth: Dimensions.space81),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.space6), color: MyColor.quizresultBodyColor),
                  padding: const EdgeInsets.symmetric(vertical: Dimensions.space10, horizontal: Dimensions.space20),
                  child: Row(
                    children: [
                      SvgPicture.asset(MyImages.totalReward),
                      const SizedBox(width: Dimensions.space6),
                      Text(
                        totalCoin,
                        style: regularDefault.copyWith(color: MyColor.textColor),
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ],
    );
  }
}
