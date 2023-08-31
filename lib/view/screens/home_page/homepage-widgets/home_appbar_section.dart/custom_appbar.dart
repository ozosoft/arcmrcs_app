import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_prime/core/route/route.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/core/utils/url_container.dart';
import 'package:flutter_prime/data/controller/dashboard/dashboard_controller.dart';
import 'package:flutter_prime/view/components/bottom-sheet/custom_bottom_sheet.dart';
import 'package:flutter_prime/view/components/image_widget/my_image_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../../core/utils/my_color.dart';
import '../../../../../core/utils/my_images.dart';
import '../../../../../core/utils/style.dart';
import '../language-bottom-sheet/language_bottom_sheet_screen.dart';

class CustomHomeAppBar extends StatefulWidget {
  final double appbarSize;
  final GlobalKey<ScaffoldState> scaffoldKey;
  const CustomHomeAppBar({super.key, required this.appbarSize, required this.scaffoldKey});

  @override
  State<CustomHomeAppBar> createState() => _CustomHomeAppBarState();
}

class _CustomHomeAppBarState extends State<CustomHomeAppBar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.appbarSize < kToolbarHeight ? kToolbarHeight : widget.appbarSize,
      child: GetBuilder<DashBoardController>(
        builder: (controller) => AppBar(
          leadingWidth: Dimensions.space30,
          leading: IconButton(
              onPressed: () {
                widget.scaffoldKey.currentState!.openDrawer();
              },
              icon: const Icon(Icons.menu)),
          flexibleSpace: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage(MyImages.appBarBGimage), fit: BoxFit.fitWidth),
            ),
          ),
          backgroundColor: MyColor.primaryColor,
          automaticallyImplyLeading: false,
          elevation: 0.0,
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (controller.userImage.toString() != "null")
                SizedBox(
                  child: CircleAvatar(
                    backgroundColor: MyColor.colorWhite.withOpacity(0.2),
                    child: Padding(
                      padding: const EdgeInsets.all(Dimensions.space5),
                      child: MyImageWidget(
                        radius: Dimensions.space100,
                        imageUrl: UrlContainer.dashboardUserProfileImage + controller.userImage.toString(),
                      ),
                    ),
                  ),
                )
              else
                const CircleAvatar(
                  radius: Dimensions.space22,
                  backgroundImage: AssetImage(MyImages.defaultAvatar),
                  backgroundColor: MyColor.lightprimaryColor,
                ),
              const SizedBox(width: Dimensions.space10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${MyStrings.hi} ${controller.dashRepo.apiClient.getUserFullName()}",
                      style: semiBoldLarge.copyWith(fontSize: Dimensions.fontMediumLarge, color: MyColor.colorWhite),
                    ),
                    const SizedBox(height: Dimensions.space5),
                    Text(
                      MyStrings.letsPlayQuiz,
                      style: regularDefault.copyWith(color: MyColor.colorWhite),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            InkWell(
              onTap: () {
                Get.toNamed(RouteHelper.leaderBoardScreen);
              },
              child: Padding(
                padding: const EdgeInsets.all(Dimensions.space8),
                child: SvgPicture.asset(MyImages.reward),
              ),
            ),
            InkWell(
              onTap: () {
                CustomBottomSheet(child: const LanguageBottomSheetScreen()).customBottomSheet(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(Dimensions.space8),
                child: SvgPicture.asset(MyImages.languagesSVG),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
