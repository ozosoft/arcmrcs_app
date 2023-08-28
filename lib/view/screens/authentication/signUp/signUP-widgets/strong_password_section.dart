import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/my_images.dart';
import 'package:flutter_prime/core/utils/style.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../core/utils/my_color.dart';
import '../../../../../core/utils/my_strings.dart';

class StrongPassWordCheakSection extends StatefulWidget {
  const StrongPassWordCheakSection({super.key});

  @override
  State<StrongPassWordCheakSection> createState() => _StrongPassWordCheakSectionState();
}

class _StrongPassWordCheakSectionState extends State<StrongPassWordCheakSection> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(MyImages.greenTik),
        Text(
          MyStrings.character.tr,
          style: regularDefault.copyWith(color: MyColor.greenTik),
        ),
        SvgPicture.asset(MyImages.greenTik),
        Text(
          MyStrings.upperCase.tr,
          style: regularDefault.copyWith(color: MyColor.greenTik),
        ),
        SvgPicture.asset(MyImages.greenTik),
        Text(
          MyStrings.lowerCase.tr,
          style: regularDefault.copyWith(color: MyColor.greenTik),
        ),
        SvgPicture.asset(MyImages.loading),
        Text(
          MyStrings.symbol.tr,
          style: regularDefault,
        )
      ],
    );
  }
}
