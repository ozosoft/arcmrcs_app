import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_images.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CustomHeadSection extends StatelessWidget {
  final double height,iconPosition,backbuttonPosition;
  final bool hasBackButton,iconHasSize;
  const CustomHeadSection({super.key, this.height = Dimensions.space180, this.hasBackButton=true, this.iconPosition=Dimensions.space70, this.iconHasSize=false, this.backbuttonPosition=Dimensions.space65});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            foregroundDecoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0x00FFFFFF), Colors.white],
                    stops: [.8, 7])),
            height: height,
            width: double.infinity,
            child: SvgPicture.asset(MyImages.authBgImage, fit: BoxFit.cover)),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
              padding: EdgeInsets.only(top: iconPosition),
              child: SvgPicture.asset(
            MyImages.appLogoSVG,
            height: iconHasSize?Dimensions.space81:null,
            fit: BoxFit.cover,
          )),
        ),
      hasBackButton?  Positioned(
            top: backbuttonPosition,
            left: Dimensions.space10,
            child: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.arrow_back))):const SizedBox(),
      ],
    );
  }
}
