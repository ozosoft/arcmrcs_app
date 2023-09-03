import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_images.dart';
import 'package:flutter_prime/core/utils/style.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LevelListCard extends StatelessWidget {

  final String levelName;
  final bool isLocked;
  final VoidCallback press;
  final bool isAlreadyPlayed;

  const LevelListCard({
    super.key,
    required this.levelName,
    required this.isLocked,
    required this.press,
    this.isAlreadyPlayed = false
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: Dimensions.space5, horizontal: Dimensions.space5),
        child: InkWell(
          onTap: press,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.space8, vertical: Dimensions.space8),
            decoration: BoxDecoration(
                color: isAlreadyPlayed? MyColor.completedlevel : isLocked ? MyColor.lockedLevel :  MyColor.unlockedLevelColor , borderRadius: BorderRadius.circular(Dimensions.space7), border: Border.all(color: isAlreadyPlayed? MyColor.completedlevel : isLocked ? MyColor.lockedLevel :  MyColor.unlockedLevelColor)),
            child: Row(
              children: [
                SvgPicture.asset(isAlreadyPlayed? MyImages.levelGreenTikSVG : isLocked ?  MyImages.lockLevelSVG :  MyImages.unlockLevelSVG),
                const SizedBox(width: Dimensions.space4),
                Text(
                  levelName,
                  style: regularLarge,
                ),
              ],
            ),
          ),
        ));
  }
}
