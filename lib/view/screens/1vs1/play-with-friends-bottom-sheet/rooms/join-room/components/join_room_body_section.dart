import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/view/components/buttons/rounded_button.dart';
import 'package:flutter_prime/view/components/otp_field_widget/otp_field_widget.dart';
import 'package:flutter_prime/view/screens/1vs1/play-with-friends-bottom-sheet/rooms/join-room/components/joined_lobby_room_bottom_sheet.dart';
import 'package:get/get.dart';

import '../../../../../../../core/utils/style.dart';
import '../../../../../../../data/controller/battle/battle_room_controller.dart';
import '../../../../../../../data/services/api_service.dart';
import '../../../../../../components/bottom-sheet/custom_bottom_sheet.dart';
import '../../../../../../components/buttons/rounded_loading_button.dart';

class JoinRoomBodySection extends StatefulWidget {
  const JoinRoomBodySection({super.key});

  @override
  State<JoinRoomBodySection> createState() => _JoinRoomBodySectionState();
}

class _JoinRoomBodySectionState extends State<JoinRoomBodySection> {
  late TextEditingController joinRoomCodeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(BattleRoomController(Get.find()));
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BattleRoomController>(builder: (battleRoomController) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: Dimensions.space20, left: Dimensions.space10, right: Dimensions.space10),
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
                      padding: const EdgeInsets.only(top: Dimensions.space12, left: Dimensions.space15),
                      child: Text(
                        MyStrings.entryRoomCode,
                        style: regularMediumLarge.copyWith(color: MyColor.textColor, fontSize: Dimensions.space18),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: Dimensions.space11),
                      child: OTPFieldWidget(
                        tController: joinRoomCodeController,
                        onChanged: (value) {},
                      ),
                    ),
                    Obx(() {
                      print(battleRoomController.joinRoomState.value);
                      if (battleRoomController.joinRoomState.value == JoinRoomState.joined) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          // Navigator.pop(context);
                          CustomBottomSheet(
                            enableDrag: false,
                            child: const JoinedLobbyBottomSheet(),
                          ).customBottomSheet(context);

                          battleRoomController.toogleBattleJoinedState(JoinRoomState.none);
                        });
                      }
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: Dimensions.space15, top: Dimensions.space10, bottom: Dimensions.space25, right: Dimensions.space15),
                        child: battleRoomController.joinRoomState.value == JoinRoomState.joining
                            ? RoundedLoadingBtn()
                            : RoundedButton(
                                text: MyStrings.start,
                                press: () async {
                                  await battleRoomController.joinRoom(
                                      name: battleRoomController.battleRepo.apiClient.getUserFullName(),
                                      roomCode: joinRoomCodeController.text,
                                      profileUrl: battleRoomController.battleRepo.apiClient.getUserImagePath(),
                                      uid: battleRoomController.battleRepo.apiClient.getUserID(),
                                      currentCoin: battleRoomController.battleRepo.apiClient.getUserCurrentCoin(),
                                      joinroom: true);
                                },
                                color: MyColor.primaryColor,
                                textColor: MyColor.colorWhite,
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
