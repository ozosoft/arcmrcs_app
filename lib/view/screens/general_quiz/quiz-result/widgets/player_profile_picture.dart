import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_images.dart';

import '../../../../../core/utils/url_container.dart';

class PlayerProfilePicture extends StatelessWidget {
  final String imagePath;
  const PlayerProfilePicture({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Dimensions.space2),
      height: Dimensions.space100,
      width: Dimensions.space100,
      decoration: BoxDecoration(color: MyColor.colorLightGrey, borderRadius: BorderRadius.circular(Dimensions.space100)),
      child: FittedBox(
        fit: BoxFit.cover,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(Dimensions.space100),
            child: imagePath.toString() == "null"
                ? Image.asset(
                    MyImages.defaultAvatar,
                    fit: BoxFit.cover,
                    height: Dimensions.space50,
                    width: Dimensions.space50,
                  )
                : Image.network(
                    "${UrlContainer.userImagePath}/$imagePath",
                    fit: BoxFit.cover,
                    height: Dimensions.space50,
                    width: Dimensions.space50,
                  )),
      ),
    );
  }
}
