import 'package:flutter/material.dart';
import 'package:flutter_prime/core/route/route.dart';
import 'package:get/get.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_images.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/core/utils/style.dart';

class NoDataWidget extends StatelessWidget {
  final double margin;
  final String? messages;
  final Widget? child;
  final bool showHomeButton;
  final bool showBack;

  const NoDataWidget({Key? key, this.margin = 4, this.messages, this.child, this.showHomeButton = true, this.showBack = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height / margin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          child ?? Image.asset(MyImages.noContentFound, height: 120, width: 120),
          const SizedBox(height: Dimensions.space20),
          Text(
            messages ?? MyStrings.noDataToShow.tr,
            style: regularLarge.copyWith(color: MyColor.getTextColor()),
          ),
          const SizedBox(height: Dimensions.space30),
          if (showHomeButton == true)
            TextButton(
              onPressed: () {
                if (showBack == true) {
                  Get.back();
                } else {
                  Get.offAllNamed(RouteHelper.bottomNavBarScreen);
                }
              },
              style: TextButton.styleFrom(
                splashFactory: InkSplash.splashFactory, // Use the default splash factory
                backgroundColor: MyColor.primaryColor.withOpacity(0.2),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  " ${showBack == true ? MyStrings.back : MyStrings.home} ",
                  style: regularLarge.copyWith(color: MyColor.primaryColor, fontWeight: FontWeight.bold),
                ),
              ),
            )
        ],
      ),
    );
  }
}
