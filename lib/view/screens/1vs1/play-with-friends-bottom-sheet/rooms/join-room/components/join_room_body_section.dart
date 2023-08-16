import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/view/components/buttons/rounded_button.dart';
import 'package:flutter_prime/view/components/otp_field_widget/otp_field_widget.dart';
import 'package:flutter_prime/view/screens/1vs1/play-with-friends-bottom-sheet/rooms/join-room/components/joined_lobby_room_bottom_sheet.dart';
import 'package:get/get.dart';

import '../../../../../../../core/utils/style.dart';
import '../../../../../../../data/controller/auth/signin/signin_controller.dart';
import '../../../../../../../data/controller/battle/battle_room_controller.dart';
import '../../../../../../components/bottom-sheet/custom_bottom_sheet.dart';

class JoinRoomBodySection extends StatefulWidget {
  const JoinRoomBodySection({super.key});

  @override
  State<JoinRoomBodySection> createState() => _JoinRoomBodySectionState();
}

class _JoinRoomBodySectionState extends State<JoinRoomBodySection> {
  late TextEditingController joinRoomCodeController = TextEditingController();

  SignInController signInController = Get.find();
  BattleRoomController battleRoomController = Get.put(BattleRoomController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BattleRoomController>(builder: (controller) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top: Dimensions.space20,
                left: Dimensions.space10,
                right: Dimensions.space10),
            child: Container(
                padding: const EdgeInsets.only(top: Dimensions.space8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.space10),
                  color: MyColor.colorWhite,
                ),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: Dimensions.space12, left: Dimensions.space15),
                      child: Text(
                        MyStrings.entryRoomCode,
                        style: regularMediumLarge.copyWith(
                            color: MyColor.textColor,
                            fontSize: Dimensions.space18),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: Dimensions.space11),
                      child: OTPFieldWidget(
                        tController: joinRoomCodeController,
                        onChanged: (value) {},
                      ),
                    ),
                    Obx(() {
                      if (battleRoomController.isBattleRoomJoined.value ==
                          true) {
                        // Navigator.pop(context);
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          CustomBottomSheet(
                            child: const JoinedLobbyBottomSheet(),
                          ).customBottomSheet(context);

                          battleRoomController.toogleBattleJoinedeData(false);
                        });
                      }
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: Dimensions.space15,
                            top: Dimensions.space10,
                            bottom: Dimensions.space25,
                            right: Dimensions.space15),
                        child: RoundedButton(
                          text: MyStrings.start,
                          press: () {
                            // Get.back();
                            print(joinRoomCodeController.text);

                            var userData = signInController.user;
                            print(userData.value!.email);

                            battleRoomController.joinRoom(
                                name: userData.value!.email ==
                                        "arman.khan.dev@gmail.com"
                                    ? "Arman Khan"
                                    : "Imran Khan",
                                profileUrl: "",
                                uid: userData.value!.uid,
                                currentCoin: "5000");
                            print(
                                "${battleRoomController.isBattleRoomJoined.value} dnfhdhfd");
                            //   CustomBottomSheet(
                            //   child: const JoinedLobbyBottomSheet(),
                            // ).customBottomSheet(context);
                          },
                          color: MyColor.cardColor,
                          textColor: MyColor.textColor,
                          textSize: Dimensions.space18,
                          cornerRadius: Dimensions.space10,
                        ),
                      );
                    })
                  ],
                )),
          ),
        ],
      );
    });
  }
}
