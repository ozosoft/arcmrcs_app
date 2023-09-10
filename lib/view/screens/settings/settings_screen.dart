import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/data/controller/settings/settings_controller.dart';
import 'package:flutter_prime/view/components/app-bar/custom_category_appBar.dart';
import 'package:get/get.dart';

import '../../../data/services/api_service.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));

    SettingsController controller = Get.put(SettingsController(apiClient: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.loadSetting();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsController>(
      builder: (controller) => Scaffold(
        appBar: CustomCategoryAppBar(
          title: MyStrings.settings.tr,
        ),
        body: Card(
          margin: const EdgeInsets.all(Dimensions.space15),
          elevation: 0,
          child: Column(
            children: [
              ListTile(
                title: Text(MyStrings.sound.tr),
                trailing: CupertinoSwitch(
                  activeColor: MyColor.primaryColor,
                  value: controller.isSoundEnable,
                  onChanged: (value) {
                    controller.setSound(value);
                  },
                ),
              ),
              const Divider(color: MyColor.colorBlack, endIndent: Dimensions.space15, indent: Dimensions.space15, thickness: .1),
              ListTile(
                title: Text(MyStrings.vibration.tr),
                trailing: CupertinoSwitch(
                  activeColor: MyColor.primaryColor,
                  value: controller.isVibrationEnable,
                  onChanged: (value) {
                    controller.setVibration(value);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
