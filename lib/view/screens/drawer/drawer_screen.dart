import 'package:flutter/material.dart';
import 'package:flutter_prime/core/route/route.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_images.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/core/utils/style.dart';
import 'package:flutter_prime/data/services/api_service.dart';
import 'package:flutter_prime/view/screens/homepage/homepage-widgets/language-bottom-sheet/language_bottom_sheet_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../components/bottom-sheet/custom_bottom_sheet.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      key: _scaffoldKey,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: Dimensions.space25),
            width: double.infinity,
            child: Row(children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: Dimensions.space30, left: Dimensions.space15),
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.space40),
                        image: const DecorationImage(
                            image: AssetImage(MyImages.profileimageWomenPng),
                            fit: BoxFit.cover)),
                    height: Dimensions.space45,
                    width: Dimensions.space45,
                  ),
                ),
              ),
              const SizedBox(
                width: Dimensions.space20,
              ),
              Padding(
                padding: const EdgeInsets.only(top: Dimensions.space30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      MyStrings.hiMariya,
                      style: semiBoldMediumLarge,
                    ),
                    const SizedBox(height: Dimensions.space7),
                    Text(MyStrings.totalCoinFivethousand,
                        style: semiBoldLarge.copyWith(
                          color: MyColor.primaryColor,
                        ))
                  ],
                ),
              )
            ]),
          ),
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                ListTile(
                  leading: SvgPicture.asset(MyImages.profileDrawer),
                  title: const Text(
                    MyStrings.profile,
                    style: regularMediumLarge,
                  ),
                  minLeadingWidth: Dimensions.space1,
                  onTap: () {
                    Get.toNamed(RouteHelper.profileScreen);
                  },
                ),
                ListTile(
                  leading: SvgPicture.asset(MyImages.notificationSVG),
                  title: const Text(
                    MyStrings.notification,
                    style: regularMediumLarge,
                  ),
                  minLeadingWidth: Dimensions.space1,
                  onTap: () {
                    Get.toNamed(RouteHelper.notificationScreen);
                  },
                ),
                ListTile(
                  leading: SvgPicture.asset(MyImages.bookmarkDrawer),
                  title: const Text(
                    MyStrings.bookmark,
                    style: regularMediumLarge,
                  ),
                  minLeadingWidth: Dimensions.space1,
                  onTap: () {
                    Get.toNamed(RouteHelper.bookmarkScreen);
                  },
                ),
                const Divider(
                  endIndent: Dimensions.space70,
                ),
                ListTile(
                  leading: SvgPicture.asset(MyImages.walletDrawer),
                  title: const Text(
                    MyStrings.wallet,
                    style: regularMediumLarge,
                  ),
                  minLeadingWidth: Dimensions.space1,
                  onTap: () {
                    Get.toNamed(RouteHelper.walletScreen);
                  },
                ),
                ListTile(
                  leading: SvgPicture.asset(MyImages.coinStoreDrawer),
                  title: const Text(
                    MyStrings.coinStore,
                    style: regularMediumLarge,
                  ),
                  minLeadingWidth: Dimensions.space1,
                  onTap: () {
                    Get.toNamed(RouteHelper.coinStroeScreen);
                  },
                ),
                const Divider(
                  endIndent: Dimensions.space70,
                ),
                ListTile(
                  leading: SvgPicture.asset(MyImages.badgeDrawer),
                  title: const Text(
                    MyStrings.badges,
                    style: regularMediumLarge,
                  ),
                  minLeadingWidth: Dimensions.space1,
                  onTap: () {
                    Get.toNamed(RouteHelper.badgesScreen);
                  },
                ),
                ListTile(
                  leading: SvgPicture.asset(MyImages.coinStoreDrawer),
                  title: const Text(
                    MyStrings.coinHistory,
                    style: regularMediumLarge,
                  ),
                  onTap: () {
                    Get.toNamed(RouteHelper.coinHistoryScreen);
                  },
                  minLeadingWidth: Dimensions.space1,
                ),
                const Divider(
                  endIndent: Dimensions.space70,
                ),
                ListTile(
                    leading: SvgPicture.asset(MyImages.languageDrawer),
                    title: const Text(
                      MyStrings.language,
                      style: regularMediumLarge,
                    ),
                    minLeadingWidth: Dimensions.space1,
                    onTap: () {
                      CustomBottomSheet(
                              child: const LanguageBottomSheetScreen())
                          .customBottomSheet(context);
                    }),
                ListTile(
                  onTap: () {
                    ApiClient(sharedPreferences: Get.find())
                        .sharedPreferences
                        .clear();
                    Get.offAllNamed(RouteHelper.loginScreen);
                  },
                  leading: SvgPicture.asset(MyImages.logOutDrawer),
                  title: const Text(
                    MyStrings.logout,
                    style: regularMediumLarge,
                  ),
                  minLeadingWidth: Dimensions.space1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
