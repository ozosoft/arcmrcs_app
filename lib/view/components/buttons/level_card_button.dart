import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_svg/svg.dart';

class LevelCardButton extends StatelessWidget {
  final bool hasIcon ,hasbgColor,hastextColor;
  final bool hasImage,lifelineUsed;
  final double ? height,width;
  final String? text, image;
  final Color bgColor;
  final Color contentColor;

  const LevelCardButton(
      {Key? key,
      this.text,
      this.bgColor = MyColor.primaryColor,
      this.contentColor = MyColor.colorWhite,
      required this.hasIcon,
      this.image, this.height, this.width, required this.hasImage, this.lifelineUsed=false, this.hasbgColor=false, this.hastextColor=false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
        padding:  EdgeInsets.symmetric(
            horizontal: Dimensions.space15, vertical:hasbgColor? Dimensions.space1: Dimensions.space15),
        decoration: BoxDecoration(
            color:hasbgColor ?bgColor: MyColor.cardColor,
            borderRadius: BorderRadius.circular(Dimensions.space5),
            border: Border.all(color: MyColor.cardBorderColor)),
        child: Center(
            child: Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            hasIcon ? Opacity(opacity:20,child:  SvgPicture.asset(image!, color: MyColor.prifileBG,)) :const SizedBox(),
            hasImage==false? const SizedBox(
              width: 3,
            ):const SizedBox(),
          hasImage==false?  Text(text.toString(),style: TextStyle(color:hastextColor? MyColor.colorWhite:MyColor.colorBlack),):SvgPicture.asset(image!,fit: BoxFit.cover,),

          ],
        )),
      );
  }
}
