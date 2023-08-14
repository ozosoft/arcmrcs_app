import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/my_images.dart';
import 'package:flutter_prime/core/utils/style.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/utils/my_color.dart';
import '../../../../../core/utils/my_strings.dart';

class StrongPassWordCheakSection extends StatefulWidget {
  const StrongPassWordCheakSection({super.key});

  @override
  State<StrongPassWordCheakSection> createState() =>
      _StrongPassWordCheakSectionState();
}

class _StrongPassWordCheakSectionState
    extends State<StrongPassWordCheakSection> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(MyImages.greenTik),
        Text(
          MyStrings.character,
          style: regularDefault.copyWith(color: MyColor.greenTik),
        ),
        SvgPicture.asset(MyImages.greenTik),
        Text(
          MyStrings.upperCase,
          style: regularDefault.copyWith(color: MyColor.greenTik),
        ),
        SvgPicture.asset(MyImages.greenTik),
        Text(
          MyStrings.lowerCase,
          style: regularDefault.copyWith(color: MyColor.greenTik),
        ),
        SvgPicture.asset(MyImages.loading),
        const Text(
          MyStrings.symbol,
          style: regularDefault,
        )
      ],
    );
  }
}
