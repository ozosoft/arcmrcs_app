import 'package:flutter/material.dart';
import 'package:flutter_prime/core/route/route.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/core/utils/style.dart';
import 'package:flutter_prime/view/components/buttons/rounded_button.dart';
import 'package:flutter_prime/view/components/divider/or_divider.dart';
import 'package:get/get.dart';
import '../../components/bottom-sheet/custom_bottom_sheet.dart';
import '../../components/text-form-field/custom_drop_down_field.dart';
import 'appbar-components/customSliverDelegate.dart';
import 'play-with-friends-bottom-sheet/play_with_friends_bottom_sheet.dart';

class OneVSOneBattleScreen extends StatelessWidget {
  const OneVSOneBattleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverPersistentHeader(
              pinned: true,
              floating: true,
              delegate: CustomSliverDelegates(
                expandedHeight: Dimensions.space180,
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: Dimensions.space30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      MyStrings.selectCountry,
                      style: semiBoldExtraLarge,
                    ),
                    const CustomDropDownTextField3(
                        selectedValue: null,
                        onChanged: null,
                        items: null,
                        hintText: MyStrings.scienceAndTech),
                    const SizedBox(
                      height: Dimensions.space40,
                    ),
                    RoundedButton(
                        text: MyStrings.letsPlay,
                        press: () {
                          Get.toNamed(RouteHelper.findOpponentScreen);
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
                          CustomBottomSheet(
                                  child:
                                      const PlayWithFriendsBottomSheetWidget())
                              .customBottomSheet(context);
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
  }
}
