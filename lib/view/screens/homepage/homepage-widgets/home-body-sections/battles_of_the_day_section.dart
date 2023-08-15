import 'package:flutter/material.dart';
import 'package:flutter_prime/core/route/route.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_images.dart';
import 'package:flutter_prime/view/screens/1vs1/one_vs_one_battle_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../../core/utils/dimensions.dart';
import '../../../../../core/utils/my_strings.dart';
import '../../../../../core/utils/style.dart';

class BattleOfTheDaySection extends StatefulWidget {
  const BattleOfTheDaySection({
    super.key,
  });

  @override
  State<BattleOfTheDaySection> createState() => _BattleOfTheDaySectionState();
}

class _BattleOfTheDaySectionState extends State<BattleOfTheDaySection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(
              bottom: Dimensions.space3,
              left: Dimensions.space4,
              right: Dimensions.space4,
              top: Dimensions.space17),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                MyStrings.battleOfTheDay,
                style: semiBoldMediumLarge,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: Dimensions.space8,
        ),
        InkWell(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: Dimensions.space2),
            decoration: BoxDecoration(
              color: MyColor.colorWhite,
              borderRadius: BorderRadius.circular(Dimensions.space10),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(61, 158, 158, 158),
                  blurRadius: 7,
                  spreadRadius: .5,
                  offset: Offset(
                    .4,
                    .4,
                  ),
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(Dimensions.space12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: Dimensions.space10,
                      ),
                      InkWell(
                        onTap: () {
                          Get.toNamed(RouteHelper.oneVSoneBattleScreen);
                        },
                        child: Container(
                          height: Dimensions.space50,
                          width: Dimensions.space220,
                          padding:
                              const EdgeInsets.only(top: Dimensions.space7),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                MyStrings.oneVSone,
                                style: semiBoldMediumLarge,
                              ),
                              const SizedBox(height: Dimensions.space8),
                              Text(
                                MyStrings.battleQuiz,
                                style: regularDefault.copyWith(
                                    color: MyColor.colorlighterGrey),
                              )
                            ],
                          ),
                        ),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          Get.to(() => OneVSOneBattleScreen(
                                fromgroup: true,
                              ));
                        },
                        child: Container(
                          padding:
                              const EdgeInsets.only(top: Dimensions.space7),
                          height: Dimensions.space50,
                          width: Dimensions.space50,
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: SvgPicture.asset(
                              MyImages.playNowSVG,
                              height: Dimensions.space27,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.space15,
                      vertical: Dimensions.space5),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(Dimensions.space8),
                        child: Container(
                          decoration: BoxDecoration(
                              color: MyColor.cardColor,
                              border: Border.all(
                                  color: MyColor.colorlighterGrey, width: 0.3)),
                          padding: const EdgeInsets.all(Dimensions.space7),
                          child: Center(
                              child: Text(
                            MyStrings.fee50Coins,
                            style: regularDefault.copyWith(
                                color: MyColor.colorGrey),
                          )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(Dimensions.space8),
                        child: Container(
                          decoration: BoxDecoration(
                              color: MyColor.cardColor,
                              border: Border.all(
                                  color: MyColor.colorDarkGrey, width: 0.3)),
                          padding: const EdgeInsets.all(Dimensions.space7),
                          child: Center(
                              child: Text(MyStrings.currentCoin,
                                  style: regularDefault.copyWith(
                                      color: MyColor.colorGrey))),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: Dimensions.space15,
        ),
        InkWell(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: Dimensions.space2),
            decoration: BoxDecoration(
              color: MyColor.colorWhite,
              borderRadius: BorderRadius.circular(Dimensions.space10),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(61, 158, 158, 158),
                  blurRadius: 7,
                  spreadRadius: .5,
                  offset: Offset(
                    .4,
                    .4,
                  ),
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(Dimensions.space12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: Dimensions.space10,
                      ),
                      InkWell(
                        onTap: () {
                          Get.toNamed(RouteHelper.oneVSoneBattleScreen);
                        },
                        child: Container(
                          height: Dimensions.space50,
                          width: Dimensions.space220,
                          padding:
                              const EdgeInsets.only(top: Dimensions.space7),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                MyStrings.groupBattle,
                                style: semiBoldMediumLarge,
                              ),
                              const SizedBox(height: Dimensions.space8),
                              Text(
                                MyStrings.groupbattleQuiz,
                                style: regularDefault.copyWith(
                                    color: MyColor.colorlighterGrey),
                              )
                            ],
                          ),
                        ),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          Get.toNamed(RouteHelper.oneVSoneBattleScreen);
                        },
                        child: Container(
                          padding:
                              const EdgeInsets.only(top: Dimensions.space7),
                          height: Dimensions.space50,
                          width: Dimensions.space50,
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: SvgPicture.asset(
                              MyImages.playNowSVG,
                              height: Dimensions.space27,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.space15,
                      vertical: Dimensions.space5),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(Dimensions.space8),
                        child: Container(
                          decoration: BoxDecoration(
                              color: MyColor.cardColor,
                              border: Border.all(
                                  color: MyColor.colorlighterGrey, width: 0.3)),
                          padding: const EdgeInsets.all(Dimensions.space7),
                          child: Center(
                              child: Text(
                            MyStrings.fee50Coins,
                            style: regularDefault.copyWith(
                                color: MyColor.colorGrey),
                          )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(Dimensions.space8),
                        child: Container(
                          decoration: BoxDecoration(
                              color: MyColor.cardColor,
                              border: Border.all(
                                  color: MyColor.colorDarkGrey, width: 0.3)),
                          padding: const EdgeInsets.all(Dimensions.space7),
                          child: Center(
                              child: Text(MyStrings.currentCoin,
                                  style: regularDefault.copyWith(
                                      color: MyColor.colorGrey))),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
