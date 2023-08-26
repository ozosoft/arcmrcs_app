import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_images.dart';
import 'package:flutter_prime/core/utils/style.dart';

import '../../../../core/utils/dimensions.dart';

class PlayerProfileDetails extends StatelessWidget {
  const PlayerProfileDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
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
        ),
        SizedBox(height: Dimensions.space10,),

        Text("User Name",style: regularLarge.copyWith(fontSize: Dimensions.fontMediumLarge,))
      ],
    );
  }
}

