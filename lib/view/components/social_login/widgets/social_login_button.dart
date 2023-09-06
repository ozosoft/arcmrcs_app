import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/style.dart';
import 'package:flutter_svg/svg.dart';

class SocialLoginButton extends StatelessWidget {
  final String title;
  final String image;
  const SocialLoginButton({super.key, required this.title, required this.image});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(Dimensions.space5),
        decoration: BoxDecoration(
          border: Border.all(color: MyColor.getTextFieldDisableBorder()),
          borderRadius: BorderRadius.circular(6),
        ),
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.space7, vertical: Dimensions.space12),
        child: Row(children: [
          Padding(
            padding: const EdgeInsets.only(right: Dimensions.space10),
            child: SvgPicture.asset(
              image,
              height: Dimensions.space20,
              width: Dimensions.space50,
            ),
          ),
          Expanded(
            child: Text(
              title,
              overflow: TextOverflow.ellipsis,
              style: regularLarge.copyWith(fontSize: Dimensions.fontSmall),
            ),
          )
        ]),
      ),
    );
  }
}
