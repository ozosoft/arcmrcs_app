import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_images.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/core/utils/style.dart';
import 'package:flutter_prime/data/controller/battle/battle_room_controller.dart';
import 'package:flutter_prime/view/components/alert-dialog/custom_alert_dialog.dart';
import 'package:flutter_prime/view/components/bottom-sheet/bottom_sheet_bar.dart';
import 'package:flutter_prime/view/components/bottom-sheet/bottom_sheet_header_row.dart';
import 'package:flutter_prime/view/components/buttons/rounded_button.dart';
import 'package:flutter_prime/view/components/snack_bar/show_custom_snackbar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../../../core/route/route.dart';

class LobbyBottomSheet extends StatefulWidget {
  const LobbyBottomSheet({super.key});

  @override
  State<LobbyBottomSheet> createState() => _LobbyBottomSheetState();
}

class _LobbyBottomSheetState extends State<LobbyBottomSheet> {
  bool start = false;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BattleRoomController>(builder: (controller) {
      return WillPopScope(
        onWillPop: () async {
          CustomAlertDialog(
              barrierDismissible: false,
              willPop: true,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(Dimensions.space10),
                    child: Text(
                      MyStrings.areYouSureYouWantToLeaveThisRoom,
                      style: regularLarge.copyWith(color: MyColor.textSecondColor),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    height: 1,
                    color: MyColor.textSecondColor.withOpacity(0.3),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(Dimensions.space10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(false); // Return false when "Cancel" is pressed
                          },
                          child: const Text(
                            MyStrings.cancel,
                            style: regularLarge,
                          ),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(backgroundColor: MyColor.primaryColor, foregroundColor: MyColor.colorWhite),
                          onPressed: () async {
                            await controller.deleteBattleRoom(controller.battleRoomData.value!.roomId, false).whenComplete(() {
                              Get.offAllNamed(RouteHelper.bottomNavBarScreen);
                            });
                          },
                          child: Text(
                            MyStrings.yes,
                            style: regularLarge.copyWith(color: MyColor.colorWhite),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )).customAlertDialog(context);
          return false; // Disable back button if `start` is true
        },
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.space8),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: Dimensions.space8, bottom: Dimensions.space30),
                child: BottomSheetBar(),
              ),
              Container(
                width: double.infinity,
                color: MyColor.lobbycardColor,
                child: Column(
                  children: [
                    const SizedBox(height: Dimensions.space30),
                    GestureDetector(
                      onTap: () {
                        Clipboard.setData(ClipboardData(text: controller.battleRoomData.value!.roomCode!)).then((value) {
                          print("copied");
                          CustomSnackBar.success(successList: [(MyStrings.copied)]);
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: Dimensions.space12, vertical: Dimensions.space12),
                        decoration: BoxDecoration(
                          color: MyColor.lobbycontColor,
                          border: Border.all(color: MyColor.lobbycontBorderColor, width: .1),
                          borderRadius: BorderRadius.circular(Dimensions.space8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "${controller.battleRoomData.value!.roomCode}",
                              style: semiBoldExtraLarge.copyWith(color: MyColor.primaryColor),
                            ),
                            const SizedBox(width: Dimensions.space5),
                            SvgPicture.asset(
                              MyImages.copySVG,
                              fit: BoxFit.cover,
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(Dimensions.space2),
                      padding: const EdgeInsets.all(Dimensions.space10),
                      width: Dimensions.space260,
                      child: Center(
                        child: Text(
                          MyStrings.sharecodeText,
                          textAlign: TextAlign.center,
                          style: regularLarge.copyWith(color: MyColor.textColor),
                        ),
                      ),
                    )
                  ],
                ),
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
                          borderRadius: BorderRadius.circular(Dimensions.space6)),
                      padding: const EdgeInsets.symmetric(horizontal: Dimensions.space10, vertical: Dimensions.space30),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: Dimensions.space10),
                            child: FittedBox(
                              fit: BoxFit.cover,
                              child: Container(
                                margin: const EdgeInsets.only(top: Dimensions.space20),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(Dimensions.space40),
                                    image: const DecorationImage(image: AssetImage(MyImages.profileimageWomenPng), fit: BoxFit.cover)),
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
                                controller.battleRoomData.value!.user1!.name,
                                textAlign: TextAlign.center,
                                style: semiBoldMediumLarge.copyWith(color: MyColor.colorBlack),
                              ),
                            ),
                          ),
                          Text(
                            MyStrings.creator,
                            textAlign: TextAlign.center,
                            style: regularLarge.copyWith(color: MyColor.textColor),
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
                          borderRadius: BorderRadius.circular(Dimensions.space6)),
                      padding: const EdgeInsets.symmetric(horizontal: Dimensions.space10, vertical: Dimensions.space30),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: Dimensions.space10),
                            child: FittedBox(
                              fit: BoxFit.cover,
                              child: Container(
                                margin: const EdgeInsets.only(top: Dimensions.space20),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(Dimensions.space40),
                                    image: const DecorationImage(image: AssetImage(MyImages.profileimageWomen2Png), fit: BoxFit.cover)),
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
                                controller.battleRoomData.value!.user2!.name.isEmpty ? "Player 2" : controller.battleRoomData.value!.user2!.name,
                                textAlign: TextAlign.center,
                                style: semiBoldMediumLarge.copyWith(color: MyColor.colorBlack),
                              ),
                            ),
                          ),
                          Text(
                            MyStrings.player,
                            textAlign: TextAlign.center,
                            style: regularLarge.copyWith(color: MyColor.textColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: Dimensions.space100),
              controller.userFoundState.value == UserFoundState.found
                  ? RoundedButton(
                      text: MyStrings.start,
                      press: () {
                        setState(() {
                          start = true;
                        });
                        print("go");

                        controller.startBattleQuiz(controller.battleRoomData.value!.roomId, "battle", readyToPlay: true).whenComplete(() {
                          // Get.back();
                          // Get.toNamed(
                          //   RouteHelper.battleQuizQuestionsScreen,
                          //   arguments: [
                          //     "Quiz DEmo",
                          //     controller.questionsData.data.questions
                          //   ],
                          // );
                        });
                      },
                      cornerRadius: Dimensions.space10,
                      textSize: Dimensions.space20,
                    )
                  : RoundedButton(
                      text: MyStrings.start,
                      press: () {
                        setState(() {
                          start = true;
                        });
                      },
                      color: MyColor.lobbycardColor,
                      textColor: MyColor.textColor,
                      textSize: Dimensions.space20,
                    )
            ],
          ),
        ),
      );
    });
  }
}
