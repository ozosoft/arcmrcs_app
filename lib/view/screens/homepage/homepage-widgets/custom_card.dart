import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_images.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/core/utils/style.dart';
import 'package:flutter_prime/view/components/divider/custom_divider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../components/divider/custom_vertical_divider.dart';

class CustomCardWidget extends StatefulWidget {
  const CustomCardWidget({super.key});

  @override
  State<CustomCardWidget> createState() => _CustomCardWidgetState();
}

class _CustomCardWidgetState extends State<CustomCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.space10)),
      elevation: .5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            height: Dimensions.space50,
            width: Dimensions.space100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: Dimensions.space3),
                  child: SvgPicture.asset(MyImages.rank),
                ),
                const SizedBox(width: Dimensions.space8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      MyStrings.rank,
                      style: regularMediumLarge.copyWith(
                          color: MyColor.primaryColor),
                    ),
                    const CustomDivider(space: Dimensions.space3),
                    const Text(MyStrings.zero)
                  ],
                )
              ],
            ),
          ),
          const CustomVerticalDivider(height: Dimensions.space25),
          SizedBox(
            height: Dimensions.space50,
            width: Dimensions.space100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: Dimensions.space3),
                  child: SvgPicture.asset( MyImages.coin),
                ),
                const SizedBox(width: Dimensions.space8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      MyStrings.coins,
                      style: regularMediumLarge.copyWith(color: MyColor.primaryColor),
                    ),
                    const Text(MyStrings.zero)
                  ],
                )
              ],
            ),
          ),
          const CustomVerticalDivider(height: Dimensions.space25),
          SizedBox(
            height: Dimensions.space50,
            width: Dimensions.space100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: Dimensions.space3),
                  child: SvgPicture.asset(MyImages.score),
                ),
                const SizedBox(width: Dimensions.space8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      MyStrings.score,
                      style: regularMediumLarge.copyWith(color: MyColor.primaryColor)),
                    const CustomDivider( space: Dimensions.space3),
                    const Text(MyStrings.zero)
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
