import 'package:flutter/material.dart';
import 'package:flutter_prime/core/route/route.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/view/components/bottom-sheet/bottom_sheet_bar.dart';
import 'package:flutter_prime/view/components/buttons/rounded_button.dart';
import 'package:get/get.dart';

import '../../../../data/controller/battle/one_vs_multi_controller.dart';
import '../../../../data/model/battle/battle_category_list.dart';

class PlayWithFriendsBottomSheetWidget extends StatelessWidget {
  const PlayWithFriendsBottomSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OneVsMutiController>(builder: (controller) {
      return Padding(
        padding: const EdgeInsets.only(top: Dimensions.space10, left: Dimensions.space15, right: Dimensions.space15),
        child: Column(
          children: [
            const BottomSheetBar(),
            const SizedBox(height: Dimensions.space20),
            RoundedButton(
              text: MyStrings.createRoom,
              press: () {
                Get.back();
                Get.toNamed(RouteHelper.createRoomScreen,
                    arguments: [null, null, controller.categoryList.isNotEmpty ? controller.categoryList : <BattleCategory>[]]);
              },
              textSize: Dimensions.space20,
              cornerRadius: Dimensions.space10,
            ),
            const SizedBox(
              height: Dimensions.space20,
            ),
            RoundedButton(
              text: MyStrings.joinRoom,
              press: () {
                Get.back();
                Get.toNamed(RouteHelper.joinRoomScreen, arguments: [null, null, controller.categoryList]);
              },
              color: MyColor.colorBlack,
              textSize: Dimensions.space20,
              cornerRadius: Dimensions.space10,
            ),
            const SizedBox(
              height: Dimensions.space50,
            ),
          ],
        ),
      );
    });
  }
}
