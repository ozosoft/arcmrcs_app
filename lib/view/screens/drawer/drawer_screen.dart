import 'package:flutter/material.dart';
import 'package:flutter_prime/core/route/route.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_images.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/core/utils/style.dart';

import 'package:flutter_prime/core/utils/url_container.dart';
import 'package:flutter_prime/data/controller/auth/logout/logout_controller.dart';
import 'package:flutter_prime/data/controller/dashboard/dashboard_controller.dart';
import 'package:flutter_prime/data/repo/auth/logout/logout_repo.dart';

import 'package:flutter_prime/data/services/api_service.dart';
import 'package:flutter_prime/view/screens/home_page/homepage-widgets/language-bottom-sheet/language_bottom_sheet_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../core/utils/util.dart';
import '../../components/bottom-sheet/custom_bottom_sheet.dart';
import '../../components/image_widget/my_image_widget.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(LogoutRepo(apiClient: Get.find()));
    Get.put(LogoutController(logoutRepo: Get.find()));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      key: _scaffoldKey,
      child: Column(
        children: [
          GetBuilder<DashBoardController>(
            builder: (controller) => Container(
              padding: const EdgeInsets.only(top: Dimensions.space25),
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(top: Dimensions.space30, left: Dimensions.space20),
                child: Row(children: [
                  if (controller.userImage.toString() != "null")
                    SizedBox(
                      child: CircleAvatar(
                        backgroundColor: MyColor.primaryColor.withOpacity(0.2),
                        child: MyImageWidget(
                          radius: Dimensions.space100,
                          imageUrl: UrlContainer.dashboardUserProfileImage + controller.userImage.toString(),
                        ),
                      ),
                    )
                  else
                    CircleAvatar(
                      radius: Dimensions.space22,
                      backgroundColor: MyColor.primaryColor.withOpacity(0.2),
                      child: Image.asset(MyImages.defaultAvatar),
                    ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: Dimensions.space20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.dashRepo.apiClient.getUserFullName().tr,
                            style: semiBoldMediumLarge,
                          ),
                          const SizedBox(height: Dimensions.space7),
                          Text("${MyStrings.totalCoin.tr} - ${MyUtils().formatNumberWithLeadingZero(controller.coins.tr)}", style: semiBoldLarge.copyWith(color: MyColor.primaryColor, fontSize: Dimensions.fontDefault12))
                        ],
                      ),
                    ),
                  )
                ]),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                ListTile(
                  leading: SvgPicture.asset(MyImages.profileDrawer),
                  title: Text(
                    MyStrings.profile.tr,
                    style: regularMediumLarge,
                  ),
                  minLeadingWidth: Dimensions.space1,
                  onTap: () {
                    Get.toNamed(RouteHelper.profileScreen);
                  },
                ),
                // ListTile(
                //   leading: SvgPicture.asset(MyImages.notificationSVG),
                //   title: const Text(
                //     MyStrings.notification,
                //     style: regularMediumLarge,
                //   ),
                //   minLeadingWidth: Dimensions.space1,
                //   onTap: () {
                //     Get.toNamed(RouteHelper.notificationScreen);
                //   },
                // ),
                // ListTile(
                //   leading: SvgPicture.asset(MyImages.bookmarkDrawer),
                //   title: const Text(
                //     MyStrings.bookmark,
                //     style: regularMediumLarge,
                //   ),
                //   minLeadingWidth: Dimensions.space1,
                //   onTap: () {
                //     Get.toNamed(RouteHelper.bookmarkScreen);
                //   },
                // ),
                // const Divider(
                //   endIndent: Dimensions.space70,
                // ),
                // ListTile(
                //   leading: SvgPicture.asset(MyImages.walletDrawer),
                //   title: const Text(
                //     MyStrings.wallet,
                //     style: regularMediumLarge,
                //   ),
                //   minLeadingWidth: Dimensions.space1,
                //   onTap: () {
                //     Get.toNamed(RouteHelper.walletScreen);
                //   },
                // ),
                ListTile(
                  leading: SvgPicture.asset(MyImages.coinStoreDrawer),
                  title: Text(
                    MyStrings.coinStore.tr,
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
                // ListTile(
                //   leading: SvgPicture.asset(MyImages.badgeDrawer),
                //   title: const Text(
                //     MyStrings.badges,
                //     style: regularMediumLarge,
                //   ),
                //   minLeadingWidth: Dimensions.space1,
                //   onTap: () {
                //     Get.toNamed(RouteHelper.badgesScreen);
                //   },
                // ),
                ListTile(
                  leading: SvgPicture.asset(MyImages.coinStoreDrawer),
                  title: Text(
                    MyStrings.coinHistory.tr,
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
                    title: Text(
                      MyStrings.language.tr,
                      style: regularMediumLarge,
                    ),
                    minLeadingWidth: Dimensions.space1,
                    onTap: () {
                      CustomBottomSheet(child: const LanguageBottomSheetScreen()).customBottomSheet(context);
                    }),

                GetBuilder<LogoutController>(
                  builder: (logoutController) => ListTile(
                    onTap: () {
                      logoutController.logout();
                    },
                    leading: logoutController.loaderStarted
                        ? const SizedBox(
                            width: Dimensions.space25,
                            height: Dimensions.space25,
                            child: SpinKitPouringHourGlass(
                              strokeWidth: 0.2,
                              color: MyColor.primaryColor,
                              size: Dimensions.space40,
                            ),
                          )
                        : SvgPicture.asset(
                            MyImages.logOutDrawer,
                            width: Dimensions.space20,
                          ),
                    title: Text(
                      MyStrings.logout.tr,
                      style: regularMediumLarge,
                    ),
                    minLeadingWidth: Dimensions.space1,
                  ),
                ),
                // ListTile(
                //   leading: SvgPicture.asset(MyImages.logOutDrawer),
                //   title: const Text(
                //     MyStrings.logout,
                //     style: regularMediumLarge,
                //   ),
                //   onTap: (){

                //   },
                //   minLeadingWidth: Dimensions.space1,
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
