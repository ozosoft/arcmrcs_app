import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_images.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/core/utils/style.dart';
import 'package:flutter_prime/data/controller/battle/battle_room_controller.dart';
import 'package:flutter_prime/view/components/bottom-sheet/bottom_sheet_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../../components/alert-dialog/custom_alert_dialog.dart';

class JoinedLobbyBottomSheet extends StatefulWidget {
  const JoinedLobbyBottomSheet({super.key});

  @override
  State<JoinedLobbyBottomSheet> createState() => _JoinedLobbyBottomSheetState();
}

class _JoinedLobbyBottomSheetState extends State<JoinedLobbyBottomSheet> {
  bool start = false;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BattleRoomController>(builder: (controller) {
      return WillPopScope(
        onWillPop: () async {
          CustomAlertDialog(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text("Are You sure You Want to leave this room!"),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () async {
                        await controller
                            .deleteBattleRoom(
                                controller.battleRoomData.value!.roomId, false)
                            .whenComplete(() {
                          Navigator.of(context)
                              .pop(true); // Return true when "Yes" is pressed
                          Get.back();
                        });
                      },
                      child: const Text(
                        "Yes",
                        style: regularLarge,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(
                            false); // Return false when "Cancel" is pressed
                      },
                      child: const Text(
                        "Cancel",
                        style: regularLarge,
                      ),
                    ),
                  ],
                )
              ],
            ),
          )).customAlertDialog(context);
          return false; // Disable back button if `start` is true
        },
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.space8),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(
                    top: Dimensions.space8, bottom: Dimensions.space30),
                child: BottomSheetBar(),
              ),
              Container(
                width: double.infinity,
                color: MyColor.lobbycardColor,
                child: Column(
                  children: [
                    const SizedBox(height: Dimensions.space30),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.space12,
                          vertical: Dimensions.space12),
                      decoration: BoxDecoration(
                        color: MyColor.lobbycontColor,
                        border: Border.all(
                            color: MyColor.lobbycontBorderColor, width: .1),
                        borderRadius: BorderRadius.circular(Dimensions.space8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "${controller.battleRoomData.value!.roomCode}",
                            style: semiBoldExtraLarge.copyWith(
                                color: MyColor.primaryColor),
                          ),
                          const SizedBox(width: Dimensions.space5),
                          SvgPicture.asset(
                            MyImages.copySVG,
                            fit: BoxFit.cover,
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(Dimensions.space2),
                      padding: const EdgeInsets.all(Dimensions.space10),
                      width: Dimensions.space260,
                      child: Center(
                        child: Text(
                          MyStrings.pleaseWaitRoomText,
                          textAlign: TextAlign.center,
                          style:
                              regularLarge.copyWith(color: MyColor.textColor),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Text(
                "${controller.battleRoomData.value!.readyToPlay}",
                style: semiBoldExtraLarge.copyWith(color: MyColor.primaryColor),
              ),
              const SizedBox(
                height: Dimensions.space21,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: MyColor.lobbycardColor,
                          border: Border.all(
                            color: MyColor.cardBorderColors,
                          ),
                          borderRadius:
                              BorderRadius.circular(Dimensions.space6)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.space10,
                          vertical: Dimensions.space30),
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(top: Dimensions.space10),
                            child: FittedBox(
                              fit: BoxFit.cover,
                              child: Container(
                                margin: const EdgeInsets.only(
                                    top: Dimensions.space20),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.space40),
                                    image: const DecorationImage(
                                        image: AssetImage(
                                            MyImages.profileimageWomenPng),
                                        fit: BoxFit.cover)),
                                height: Dimensions.space70,
                                width: Dimensions.space70,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: Dimensions.space10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(Dimensions.space2),
                            child: Center(
                              child: Text(
                                "${controller.battleRoomData.value!.user1!.name}",
                                textAlign: TextAlign.center,
                                style: semiBoldMediumLarge.copyWith(
                                    color: MyColor.colorBlack),
                              ),
                            ),
                          ),
                          Text(
                            MyStrings.creator,
                            textAlign: TextAlign.center,
                            style:
                                regularLarge.copyWith(color: MyColor.textColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: Dimensions.space21,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: MyColor.lobbycardColor,
                          border: Border.all(
                            color: MyColor.cardBorderColors,
                          ),
                          borderRadius:
                              BorderRadius.circular(Dimensions.space6)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.space10,
                          vertical: Dimensions.space30),
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(top: Dimensions.space10),
                            child: FittedBox(
                              fit: BoxFit.cover,
                              child: Container(
                                margin: const EdgeInsets.only(
                                    top: Dimensions.space20),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.space40),
                                    image: const DecorationImage(
                                        image: AssetImage(
                                            MyImages.profileimageWomen2Png),
                                        fit: BoxFit.cover)),
                                height: Dimensions.space70,
                                width: Dimensions.space70,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: Dimensions.space10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(Dimensions.space2),
                            child: Center(
                              child: Text(
                                controller.battleRoomData.value!.user2!.name
                                        .isEmpty
                                    ? "Player 2"
                                    : controller
                                        .battleRoomData.value!.user2!.name,
                                textAlign: TextAlign.center,
                                style: semiBoldMediumLarge.copyWith(
                                    color: MyColor.colorBlack),
                              ),
                            ),
                          ),
                          Text(
                            MyStrings.player,
                            textAlign: TextAlign.center,
                            style:
                                regularLarge.copyWith(color: MyColor.textColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: Dimensions.space100),
            ],
          ),
        ),
      );
    });
  }
}