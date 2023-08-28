import 'package:flutter/material.dart';
import 'package:flutter_prime/core/route/route.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/core/utils/style.dart';
import 'package:flutter_prime/data/repo/battle/battle_repo.dart';
import 'package:flutter_prime/data/services/api_service.dart';
import 'package:flutter_prime/view/components/buttons/rounded_button.dart';
import 'package:flutter_prime/view/components/divider/or_divider.dart';
import 'package:flutter_prime/view/components/snack_bar/show_custom_snackbar.dart';
import 'package:get/get.dart';
import '../../../data/controller/battle/one_vs_multi_controller.dart';
import '../../../data/model/battle/battle_category_list.dart';
import '../../components/bottom-sheet/custom_bottom_sheet.dart';
import '../../components/text-form-field/custom_drop_down_field.dart';
import '../../components/text-form-field/custom_drop_down_text_field.dart';
import 'appbar-components/customSliverDelegate.dart';
import 'play-with-friends-bottom-sheet/play_with_friends_bottom_sheet.dart';

class OneVSOneBattleScreen extends StatefulWidget {
  final bool isGroupBattle;
  const OneVSOneBattleScreen({super.key, this.isGroupBattle = false});

  @override
  State<OneVSOneBattleScreen> createState() => _OneVSOneBattleScreenState();
}

class _OneVSOneBattleScreenState extends State<OneVSOneBattleScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<OneVsMutiController>(
        init: OneVsMutiController(Get.put(BattleRepo(apiClient: Get.put(ApiClient(sharedPreferences: Get.find()))))),
        initState: (_) async {},
        builder: (controller) {
          return Scaffold(
            body: SafeArea(
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverPersistentHeader(
                    pinned: true,
                    floating: true,
                    delegate: CustomSliverDelegates(
                      isGroupBattle: widget.isGroupBattle,
                      expandedHeight: Dimensions.space180,
                    ),
                  ),
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: Dimensions.space30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            MyStrings.selectCategory,
                            style: semiBoldExtraLarge,
                          ),
                          const SizedBox(
                            height: Dimensions.space20,
                          ),
                          CustomDropDownTextField3(
                            fillColor: MyColor.colorWhite,
                            focusColor: MyColor.colorWhite,
                            dropDownColor: MyColor.colorWhite,
                            needLabel: false,
                            selectedValue: null,
                            onChanged: (value) {
                              var valueData = value as BattleCategory;

                              controller.slectACategory(valueData.id);
                            },
                            items: controller.categoryList.map<DropdownMenuItem<BattleCategory>>((BattleCategory value) {
                              return DropdownMenuItem<BattleCategory>(
                                value: value,
                                child: Text(
                                  value.name,
                                  style: const TextStyle(
                                    fontSize: Dimensions.fontDefault,
                                  ),
                                ),
                              );
                            }).toList(),
                            hintText: MyStrings.selectACategoryText,
                          ),
                          const SizedBox(
                            height: Dimensions.space40,
                          ),
                          RoundedButton(
                              text: widget.isGroupBattle ? MyStrings.groupBattle : MyStrings.letsPlay,
                              press: () async {
                                if (controller.slectedCategoryID.value == 0) {
                                  CustomSnackBar.error(errorList: [MyStrings.selectACategoryMsg]);
                                } else if (int.parse(controller.battleRepo.apiClient.getUserCurrentCoin()) <
                                    int.parse(controller.entryFeeRandomGame.value)) {
                                  CustomSnackBar.error(errorList: [MyStrings.youHaveNoCoins]);
                                } else {
                                  Get.toNamed(RouteHelper.findOpponentScreen, arguments: [
                                    controller.slectedCategoryID.value,
                                    controller.entryFeeRandomGame.value,
                                    <BattleCategory>[]
                                  ]); //Send Question List and ID to next page
                                }
                              },
                              textSize: Dimensions.space20,
                              cornerRadius: Dimensions.space10),
                          const SizedBox(
                            height: Dimensions.space20,
                          ),
                          const OrDivider(),
                          const SizedBox(
                            height: Dimensions.space25,
                          ),
                          RoundedButton(
                              text: MyStrings.playWithFriend,
                              press: () {
                                CustomBottomSheet(child: const PlayWithFriendsBottomSheetWidget()).customBottomSheet(context);
                              },
                              textSize: Dimensions.space20,
                              color: MyColor.colorBlack,
                              cornerRadius: Dimensions.space10),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
