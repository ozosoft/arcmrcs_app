import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/data/controller/auth/signin/signin_controller.dart';
import 'package:flutter_prime/view/components/bottom-sheet/custom_bottom_sheet.dart';
import 'package:flutter_prime/view/components/buttons/rounded_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../../../core/utils/my_images.dart';
import '../../../../../../../core/utils/my_strings.dart';
import '../../../../../../../core/utils/style.dart';
import '../../../../../../../data/controller/battle/battle_room_controller.dart';
import '../../../../../../components/buttons/rounded_loading_button.dart';
import '../../../../../../components/category-card/custom_room_card.dart';
import '../../../../../../components/text-form-field/custom_drop_down_field.dart';
import 'lobby_room_bottom_sheet.dart';

class CreateRoomBodySection extends StatefulWidget {
  const CreateRoomBodySection({super.key});

// Move the bottom sheet logic outside the build method
  void openBottomSheetLobbyRoom(BuildContext context) {
    CustomBottomSheet(
      child: const LobbyBottomSheet(),
    ).customBottomSheet(context);
  }

  @override
  State<CreateRoomBodySection> createState() => _CreateRoomBodySectionState();
}

class _CreateRoomBodySectionState extends State<CreateRoomBodySection> {
  List coins = ["6", "12", "18", "24"];

  final TextEditingController _textEditingController = TextEditingController();
  String _inputText = '';

  SignInController signInController = Get.find();
  BattleRoomController battleRoomController = Get.put(BattleRoomController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(Dimensions.space20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              MyStrings.selectCategory,
              style: semiBoldMediumLarge,
            ),
            const CustomDropDownTextField3(
                selectedValue: null,
                onChanged: null,
                items: null,
                hintText: MyStrings.scienceAndTech),
            const SizedBox(height: Dimensions.space25),
            Container(
                padding: const EdgeInsets.all(Dimensions.space15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.space10),
                  color: MyColor.colorWhite,
                ),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(
                          top: Dimensions.space15, left: Dimensions.space15),
                      child: Text(
                        MyStrings.entryCoinsForBattele,
                        style: semiBoldMediumLarge,
                      ),
                    ),
                    GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: .84, crossAxisCount: 4),
                        itemCount: 4,
                        itemBuilder: (BuildContext context, index) {
                          return CustomCreateRoomCoinCard(
                            title: coins[index] ?? "",
                            image: MyImages.coin,
                          );
                        }),
                    SizedBox(
                      height: Dimensions.space47,
                      child: TextField(
                        controller: _textEditingController,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            _inputText = value;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: MyStrings.enterCoins,
                          filled: true,
                          fillColor: MyColor.cardColor,
                          labelStyle: regularExtraLarge.copyWith(
                              color: MyColor.textColor),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: Dimensions.space20,
                    ),
                  ],
                )),
            Container(
              padding: const EdgeInsets.only(
                  top: Dimensions.space30, left: Dimensions.space15),
              child: Row(
                children: [
                  SvgPicture.asset(
                    MyImages.coin,
                    fit: BoxFit.cover,
                    height: Dimensions.space47,
                  ),
                  const SizedBox(
                    width: Dimensions.space10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        MyStrings.yourCoins,
                        style: regularMediumLarge.copyWith(
                            color: MyColor.textColor),
                      ),
                      const SizedBox(
                        height: Dimensions.space5,
                      ),
                      const Text(
                        MyStrings.fivehundred,
                        style: semiBoldOverLarge,
                      )
                    ],
                  ),
                  const Spacer(),
                  Container(
                    height: Dimensions.space43,
                    width: Dimensions.space110,
                    decoration: BoxDecoration(
                        color: MyColor.createRoomButtonBGcolor,
                        borderRadius:
                            BorderRadius.circular(Dimensions.space10)),
                    child: Center(
                        child: Text(
                      MyStrings.buyCoins,
                      style: semiBoldMediumLarge.copyWith(
                          color: MyColor.textColor),
                    )),
                  )
                ],
              ),
            ),
            Obx(() {
              if (battleRoomController.roomCreateState.value ==
                  RoomCreateState.roomCreated) {
                // Navigator.pop(context);
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  // Navigator.pop(context);

                  CustomBottomSheet(
                    child: const LobbyBottomSheet(),
                  ).customBottomSheet(context);

                  battleRoomController
                      .toogleBattleCreatedState(RoomCreateState.none);
                });
              }

              return Padding(
                padding: const EdgeInsets.only(top: Dimensions.space40),
                child: battleRoomController.roomCreateState.value ==
                        RoomCreateState.creatingRoom
                    ? RoundedLoadingBtn()
                    : RoundedButton(
                        text: MyStrings.createRoom,
                        press: () {
                          var userData = signInController.user;
                          print(userData.value!.email);

                          battleRoomController.createNewRoom(
                            categoryId: "1",
                            entryFee: 10,
                            name: userData.value!.email ==
                                    "arman.khan.dev@gmail.com"
                                ? "Arman Khan"
                                : userData.value!.email ==
                                        "arman.khan.dev2@gmail.com"
                                    ? "Imran Khan"
                                    : "Salman Khan",
                            profileUrl: "",
                            uid: userData.value!.uid,
                            shouldGenerateRoomCode: true,
                          );
                          print(
                              "${battleRoomController.roomCreateState.value}");
                        },
                        textSize: Dimensions.space20),
              );
            })
          ],
        ),
      ),
    );
  }

  void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Text("Sheet");
      },
    );
  }
}
