import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/view/components/bottom-sheet/custom_bottom_sheet.dart';
import 'package:flutter_prime/view/screens/drawer/drawer_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../core/utils/my_color.dart';
import '../../../../core/utils/my_images.dart';
import '../../../../core/utils/style.dart';
import '../../wallet/widgets/coin-redeem/payment_bottomSheet.dart';
import 'language-bottom-sheet/language_bottom_sheet_screen.dart';

class CustomHomeAppBar extends StatefulWidget {
  final double appbarSize;
  final GlobalKey<ScaffoldState> scaffoldKey;
  const CustomHomeAppBar(
      {super.key, required this.appbarSize, required this.scaffoldKey});

  @override
  State<CustomHomeAppBar> createState() => _CustomHomeAppBarState();
}

class _CustomHomeAppBarState extends State<CustomHomeAppBar> {
  // GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // void _openDrawer() {
  //   _scaffoldKey.currentState?.openDrawer();
  // }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
     
      height: widget.appbarSize < kToolbarHeight
          ? kToolbarHeight
          : widget.appbarSize,
      child: AppBar(
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: MyColor.primaryColor),
        leadingWidth: Dimensions.space30,
        leading: IconButton(
            onPressed: () {
                 widget.scaffoldKey.currentState!.openDrawer();
            },
            icon: const Icon(Icons.menu)),
        flexibleSpace: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(MyImages.appBarBGimage),
                fit: BoxFit.fitWidth),
          ),
        ),
        backgroundColor: MyColor.primaryColor,
        automaticallyImplyLeading: false,
        elevation: 0.0,
        title: FittedBox(
          fit: BoxFit.cover,
          child: Row(
            children: [
              const CircleAvatar(
                radius: Dimensions.space22,
                backgroundImage: AssetImage(MyImages.profileimagePng),
                backgroundColor: MyColor.lightprimaryColor,
              ),
              const SizedBox(width: Dimensions.space10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    MyStrings.hiMariya,
                    style: semiBoldLarge.copyWith(
                        fontSize: Dimensions.space17,
                        color: MyColor.colorWhite),
                  ),
                  const SizedBox(height: Dimensions.space5),
                  Text(
                    MyStrings.letsPlayQuiz,
                    style: regularDefault.copyWith(color: MyColor.colorWhite),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(Dimensions.space8),
            child: SvgPicture.asset(MyImages.reward),
          ),
          InkWell(
            onTap: () {
              CustomBottomSheet(child: const LanguageBottomSheetScreen())
                  .customBottomSheet(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(Dimensions.space8),
              child: SvgPicture.asset(MyImages.languagesSVG),
            ),
          ),
        ],
      ),
    );
  }
}
