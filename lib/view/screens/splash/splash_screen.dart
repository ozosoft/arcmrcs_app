import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';

import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_images.dart';
import 'package:flutter_prime/core/utils/util.dart';
import 'package:flutter_prime/data/controller/localization/localization_controller.dart';
import 'package:flutter_prime/data/controller/splash/splash_controller.dart';
import 'package:flutter_prime/data/repo/auth/general_setting_repo.dart';
import 'package:flutter_prime/data/services/api_service.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    MyUtils.allScreen();

    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(GeneralSettingRepo(apiClient: Get.find()));
    Get.put(LocalizationController(sharedPreferences: Get.find()));
    final controller = Get.put(SplashController(repo: Get.find(), localizationController: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.gotoNextPage();
    });
  }

  @override
  void dispose() {
    MyUtils.allScreen();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      builder: (conroller) => Stack(
        children: [
          SvgPicture.asset(
            MyImages.splashBGimage,
            fit: BoxFit.cover,
          ),
          Scaffold(
            backgroundColor: MyColor.primaryColor,
            body: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(Dimensions.space35),
                  child: Align(
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      MyImages.splashLogoSVG,
                    ),
                  ),
                ),
                SvgPicture.asset(MyImages.splashBGimage)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
