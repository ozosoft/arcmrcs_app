import 'package:flutter/material.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';
import 'package:quiz_lab/core/utils/my_color.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/core/utils/style.dart';
import 'package:quiz_lab/view/components/divider/custom_divider.dart';
import 'package:get/get.dart';
import '../../../../data/controller/battle/one_vs_multi_controller.dart';
import '../../../components/divider/custom_vertical_divider.dart';

class OneVSOneCustomCardWidget extends StatefulWidget {
  const OneVSOneCustomCardWidget({super.key});

  @override
  State<OneVSOneCustomCardWidget> createState() => _OneVSOneCustomCardWidgetState();
}

class _OneVSOneCustomCardWidgetState extends State<OneVSOneCustomCardWidget> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<OneVsMutiController>(builder: (controller) {
      return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.space10)),
        elevation: .5,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: Dimensions.space50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        MyStrings.entryFees.tr,
                        style: regularMediumLarge.copyWith(color: MyColor.battleTextColor),
                      ),
                      const CustomDivider(
                        space: Dimensions.space3,
                      ),
                      Text("${controller.entryFeeRandomGame.value.tr} ${MyStrings.coins.tr}", style: semiBoldExtraLarge)
                    ],
                  )
                ],
              ),
            ),
            const CustomVerticalDivider(
              height: Dimensions.space25,
            ),
            SizedBox(
              height: Dimensions.space50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: Dimensions.space8,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        MyStrings.currentCoin,
                        style: regularMediumLarge.copyWith(color: MyColor.battleTextColor),
                      ),
                      const CustomDivider(
                        space: Dimensions.space3,
                      ),
                      Text("${controller.battleRepo.apiClient.getUserCurrentCoin()} ${MyStrings.coins}", style: semiBoldExtraLarge)
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
