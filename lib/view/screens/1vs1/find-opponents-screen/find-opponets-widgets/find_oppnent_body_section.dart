import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/data/repo/battle/battle_repo.dart';
import 'package:flutter_prime/view/components/buttons/rounded_button.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../../../core/utils/my_color.dart';
import '../../../../../core/utils/my_images.dart';
import '../../../../../core/utils/style.dart';
import '../../../../../core/utils/url_container.dart';
import '../../../../../data/controller/battle/battle_room_controller.dart';
import '../../../../../data/services/api_service.dart';
import '../../../../components/alert-dialog/custom_alert_dialog.dart';
import '../../../../components/text/default_text.dart';
import '../../../../../data/controller/battle/find_opponents_controller.dart';

class FindOpponentsBodySection extends StatefulWidget {
  const FindOpponentsBodySection({super.key});

  @override
  State<FindOpponentsBodySection> createState() => _FindOpponentsBodySectionState();
}

class _FindOpponentsBodySectionState extends State<FindOpponentsBodySection> {
  @override
  void initState() {
    super.initState();
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(BattleRepo(apiClient: Get.find()));
    Get.put(BattleRoomController(Get.find()));
    Get.put(FindOpponentsController(Get.find(), Get.find()));
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FindOpponentsController>(builder: (controller) {
      return WillPopScope(
        onWillPop: () async {
          CustomAlertDialog(
              borderRadius: 10,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(Dimensions.space10),
                    child: Column(
                      children: [
                        Text(MyStrings.areYouSureYouWantToCloseSearching),
                      ],
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
                            if (controller.battleRoomController.battleRoomData.value != null) {
                              await controller.battleRoomController.deleteBattleRoom(controller.battleRoomController.battleRoomData.value!.roomId, false).whenComplete(() {
                                Navigator.of(context).pop(true);
                                // Return true when "Yes" is pressed
                                Get.back();
                              });
                            } else {
                              Navigator.of(context).pop(true);
                              // Return true when "Yes" is pressed
                              Get.back();
                            }
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
        child: Column(
          children: [
            const SizedBox(height: Dimensions.space70),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(Dimensions.space2),
                      height: Dimensions.space100,
                      width: Dimensions.space100,
                      decoration: BoxDecoration(color: MyColor.colorLightGrey, borderRadius: BorderRadius.circular(Dimensions.space100)),
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(Dimensions.space100),
                            child: controller.battleRepo.apiClient.getUserImagePath() == "null"
                                ? Image.asset(
                                    MyImages.defaultAvatar,
                                    fit: BoxFit.cover,
                                    height: Dimensions.space50,
                                    width: Dimensions.space50,
                                  )
                                : Image.network(
                                    "${UrlContainer.userImagePath}/${controller.battleRepo.apiClient.getUserImagePath()}",
                                    fit: BoxFit.cover,
                                    height: Dimensions.space50,
                                    width: Dimensions.space50,
                                  )),
                      ),
                    ),
                    const SizedBox(
                      height: Dimensions.space10,
                    ),
                    Text(
                      "${controller.battleRepo.apiClient.getUserFullName()}  ",
                      style: semiBoldLarge,
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(Dimensions.space20),
                  child: Text(
                    MyStrings.vs,
                    style: semiBoldOverLarge.copyWith(color: MyColor.colorBlack),
                  ),
                ),
                Obx(() {
                  var opUserData = controller.battleRoomController.getOpponentUserDetailsOrMy(controller.battleRepo.apiClient.getUserID());

                  if (controller.battleRoomController.userFoundState.value == UserFoundState.found) {
                    controller.imageScrollController.stop();
                  }
                  return controller.battleRoomController.userFoundState.value == UserFoundState.found
                      ? Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(Dimensions.space2),
                              height: Dimensions.space100,
                              width: Dimensions.space100,
                              decoration: BoxDecoration(color: MyColor.colorLightGrey, borderRadius: BorderRadius.circular(Dimensions.space100)),
                              child: FittedBox(
                                fit: BoxFit.cover,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(Dimensions.space100),
                                    child: opUserData.profileUrl == "null"
                                        ? Image.asset(
                                            MyImages.defaultAvatar,
                                            fit: BoxFit.cover,
                                            height: Dimensions.space50,
                                            width: Dimensions.space50,
                                          )
                                        : Image.network(
                                            "${UrlContainer.userImagePath}/${opUserData.profileUrl}",
                                            fit: BoxFit.cover,
                                            height: Dimensions.space50,
                                            width: Dimensions.space50,
                                          )),
                              ),
                            ),
                            const SizedBox(
                              height: Dimensions.space10,
                            ),
                            Text(
                              "${opUserData.name} ",
                              style: semiBoldLarge,
                            )
                          ],
                        )
                      : SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(Dimensions.space2),
                                height: Dimensions.space100,
                                width: Dimensions.space100,
                                decoration: BoxDecoration(color: MyColor.colorLightGrey, borderRadius: BorderRadius.circular(Dimensions.space100)),
                                child: FittedBox(
                                  fit: BoxFit.cover,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(Dimensions.space100),
                                      child: Image.asset(
                                        MyImages.defaultAvatar,
                                        fit: BoxFit.cover,
                                        height: Dimensions.space50,
                                        width: Dimensions.space50,
                                      )),
                                ),
                              ),
                              const SizedBox(
                                height: Dimensions.space10,
                              ),
                              const Text(
                                "${MyStrings.searching}...",
                                style: semiBoldLarge,
                              )
                            ],
                          ),
                        );
                }),
              ],
            ),
            const SizedBox(
              height: Dimensions.space10,
            ),
            Stack(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: Dimensions.space40, left: Dimensions.space15, right: Dimensions.space15, bottom: Dimensions.space20),
                  width: double.infinity,
                  child: Lottie.asset(
                    MyImages.userSearchLottie,
                    height: Get.width / 1.5,
                    controller: controller.imageScrollController,
                    onLoaded: (composition) {
                      // Configure the AnimationController with the duration of the
                      // Lottie file and start the animation.
                      controller.imageScrollController
                        ..duration = composition.duration
                        ..repeat();
                    },
                  ),
                ),
                Obx(() => controller.battleRoomController.userFoundState.value == UserFoundState.found
                    ? Positioned(
                        top: 0,
                        bottom: 0,
                        right: 0,
                        left: 0,
                        child: Container(
                          color: MyColor.scaffoldBackgroundColor.withOpacity(0.9),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: const EdgeInsets.all(Dimensions.space14),
                                child: DefaultText(
                                  text: MyStrings.yourGameWillStartSoon,
                                  fontSize: Dimensions.fontExtraLarge,
                                  textStyle: boldLarge.copyWith(fontStyle: FontStyle.italic),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.all(Dimensions.space14),
                                child: DefaultText(
                                  text: "${controller.countdownSeconds == 0 ? MyStrings.started : controller.countdownSeconds}",
                                  fontSize: Dimensions.fontExtraLarge * 3,
                                  textStyle: boldLarge.copyWith(color: MyColor.primaryColor, fontStyle: FontStyle.italic),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : const SizedBox.shrink())
              ],
            ),
            Obx(() => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.space25),
                  child: controller.battleRoomController.userFoundState.value == UserFoundState.found && controller.battleRoomController.battleQuestionsList.isNotEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RoundedButton(
                              text: MyStrings.start,
                              press: () {
                                print("go");

                                controller.battleRoomController.startBattleQuiz(controller.battleRoomController.battleRoomData.value!.roomId, "battle", readyToPlay: true).whenComplete(() {
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
                            ),
                          ],
                        )
                      : RoundedButton(
                          text: MyStrings.start,
                          press: () {},
                          color: MyColor.colorWhite,
                          textColor: MyColor.textColor,
                          textSize: Dimensions.space20,
                        ),
                ))
          ],
        ),
      );
    });
  }
}
