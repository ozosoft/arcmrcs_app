import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_images.dart';

import '../../../../core/utils/dimensions.dart';

class PlayerProfilePicture extends StatelessWidget {
  const PlayerProfilePicture({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Dimensions.space6),
      height: Dimensions.space100,
      width: Dimensions.space100,
      decoration: BoxDecoration(
        color: MyColor.prifileBG,
        borderRadius: BorderRadius.circular(Dimensions.space90),
      ),
      child: FittedBox(
        fit: BoxFit.cover,
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.space40), image: const DecorationImage(image: AssetImage(MyImages.profileimageWomenPng), fit: BoxFit.cover)),
          height: Dimensions.space50,
          width: Dimensions.space50,
        ),
      ),
    );
  }
}
