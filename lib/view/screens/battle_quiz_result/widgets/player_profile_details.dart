import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_images.dart';
import 'package:flutter_prime/core/utils/style.dart';

import '../../../../core/utils/dimensions.dart';
import '../../../../core/utils/url_container.dart';

class PlayerProfileDetails extends StatelessWidget {
  final Map userData;
  const PlayerProfileDetails({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(Dimensions.space2),
          height: Dimensions.space100,
          width: Dimensions.space100,
          decoration: BoxDecoration(color: MyColor.colorLightGrey, borderRadius: BorderRadius.circular(Dimensions.space100)),
          child: FittedBox(
            fit: BoxFit.cover,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(Dimensions.space100),
                child: userData["avatar"] == null
                    ? Image.asset(
                        MyImages.defaultAvatar,
                        fit: BoxFit.cover,
                        height: Dimensions.space50,
                        width: Dimensions.space50,
                      )
                    : Image.network(
                        "${UrlContainer.userImagePath}/${userData["avatar"]}",
                        fit: BoxFit.cover,
                        height: Dimensions.space50,
                        width: Dimensions.space50,
                      )),
          ),
        ),
        const SizedBox(
          height: Dimensions.space10,
        ),
        Text("${userData["firstname"] ?? ""} ${userData["lastname"] ?? ""}",
            style: regularLarge.copyWith(
              fontSize: Dimensions.fontMediumLarge,
            ))
      ],
    );
  }
}
