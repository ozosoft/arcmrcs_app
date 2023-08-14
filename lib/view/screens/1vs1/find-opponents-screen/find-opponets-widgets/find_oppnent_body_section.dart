import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/view/components/buttons/rounded_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../core/utils/my_color.dart';
import '../../../../../core/utils/my_images.dart';
import '../../../../../core/utils/style.dart';

class FindOpponentsBodySection extends StatefulWidget {
  const FindOpponentsBodySection({super.key});

  @override
  State<FindOpponentsBodySection> createState() =>
      _FindOpponentsBodySectionState();
}

class _FindOpponentsBodySectionState extends State<FindOpponentsBodySection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: Dimensions.space70),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(Dimensions.space7),
                  height: Dimensions.space80,
                  width: Dimensions.space80,
                  decoration: BoxDecoration(
                      color: MyColor.prifileBG,
                      borderRadius:
                          BorderRadius.circular(Dimensions.space40)),
                  child:  FittedBox(
                      fit: BoxFit.cover,
                      child: Container(
                      decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.space40),
                            image: const DecorationImage(
                                image:AssetImage(MyImages.profileimageWomenPng),
                                fit: BoxFit.cover)),
                        height: Dimensions.space70,
                        width: Dimensions.space70,
                      ),
                    ),
                ),
                const SizedBox(
                  height: Dimensions.space10,
                ),
                const Text(
                  MyStrings.maria,
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
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(Dimensions.space7),
                  height: Dimensions.space80,
                  width: Dimensions.space80,
                  decoration: BoxDecoration(
                      color: MyColor.prifileBG,
                      borderRadius:
                          BorderRadius.circular(Dimensions.space40)),
                  child:  FittedBox(
                      fit: BoxFit.cover,
                      child: Container(
                      decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.space40),
                            image: const DecorationImage(
                                image:AssetImage(MyImages.profileimageWomen2Png),
                                fit: BoxFit.cover)),
                        height: Dimensions.space70,
                        width: Dimensions.space70,
                      ),
                    ),
                ),
                const SizedBox(
                  height: Dimensions.space10,
                ),
                const Text(
                  MyStrings.player2,
                  style: semiBoldLarge,
                )
              ],
            ),
           ],
        ),
        Container(
          padding: const EdgeInsets.only(
              top: Dimensions.space40,
              left: Dimensions.space15,
              right: Dimensions.space15,
              bottom: Dimensions.space110),
          width: double.infinity,
          child: SvgPicture.asset(
            MyImages.mapSVG,
            fit: BoxFit.fill,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.space25),
          child: RoundedButton(
            text: MyStrings.start,
            press: () {
              Get.back();
            },
            textSize: Dimensions.space20,
            cornerRadius: Dimensions.space10,
          ),
        )
      ],
    );
  }
}
