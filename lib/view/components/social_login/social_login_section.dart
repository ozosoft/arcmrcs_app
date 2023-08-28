import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_images.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/core/utils/style.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SocialLoginSection extends StatelessWidget {
  const SocialLoginSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(Dimensions.space20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                  onTap: () {},
                  child: SvgPicture.asset(
                    MyImages.facebook,
                    height: Dimensions.space45,
                    width: Dimensions.space50,
                  )),
              InkWell(
                  onTap: () {},
                  child: SvgPicture.asset(
                    MyImages.google,
                    height: Dimensions.space45,
                    width: Dimensions.space50,
                  )),
              InkWell(
                  onTap: () {},
                  child: SvgPicture.asset(
                    MyImages.telephone,
                    height: Dimensions.space45,
                    width: Dimensions.space50,
                  ))
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Expanded(
                child: Divider(
              color: MyColor.colorLightGrey,
            )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.space15),
              child: Text(
                MyStrings.orsigninwith.tr,
                style: regularDefault.copyWith(color: MyColor.colorlighterGrey),
              ),
            ),
            const Expanded(
                child: Divider(
              color: MyColor.colorLightGrey,
            )),
          ],
        ),
      ],
    );
  }
}
