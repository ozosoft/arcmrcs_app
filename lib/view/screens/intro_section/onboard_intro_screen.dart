import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_prime/core/route/route.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_images.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/core/utils/style.dart';
import 'package:flutter_prime/view/components/buttons/rounded_button.dart';
import 'package:flutter_prime/view/components/divider/custom_divider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import '../../components/text/custom_underline_text.dart';

class OnBoardIntroScreen extends StatefulWidget {
  const OnBoardIntroScreen({super.key});

  @override
  State<OnBoardIntroScreen> createState() => _OnBoardIntroScreenState();
}

class _OnBoardIntroScreenState extends State<OnBoardIntroScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();

  @override
  Widget build(BuildContext context) {
    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
      bodyTextStyle: TextStyle(fontSize: 18),

      imagePadding: EdgeInsets
          .zero, // Set this to zero since we control image height in custom page widget.
    );

    return IntroductionScreen(
      
      bodyPadding: const EdgeInsets.only(top: Dimensions.space200),
      key: introKey,
      globalBackgroundColor: Colors.white,
      allowImplicitScrolling: true,
      infiniteAutoScroll: false,
      globalHeader: Align(
        alignment: Alignment.topCenter,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: Dimensions.space50),
            child: SvgPicture.asset(
              MyImages.appLogoSVG,
              height: Dimensions.space60,
            ),
          ),
        ),
      ),
      globalFooter: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.space25),
            child: RoundedButton(
                text: MyStrings.getStarted,
                cornerRadius: Dimensions.space10,
                press: () {
                  Get.toNamed(RouteHelper.loginScreen);
                }),
          ),
          const SizedBox(height: Dimensions.space15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                MyStrings.dontHaveAnaccount,
                style: regularLarge.copyWith(color: MyColor.colorDarkGrey),
              ),
              const SizedBox(width: Dimensions.space5),
              InkWell(
                onTap: () {
                  Get.toNamed(RouteHelper.signupScreen);
                },
                child: const CustomUndelineText(text: MyStrings.signUp),
              )
            ],
          ),
          const CustomDivider(hascolor: false)
        ],
      ),
      pages: [
        PageViewModel(
          title: MyStrings.onboardTitle,
          body: MyStrings.onboardDescription,
          image: SvgPicture.asset(
            MyImages.onboard1SVG,
          ),
          decoration: PageDecoration(
            titleTextStyle:
                semiBoldMediumLarge.copyWith(fontSize: Dimensions.space20),
            titlePadding: const EdgeInsets.symmetric(
                vertical: Dimensions.space5, horizontal: Dimensions.space15),
            bodyPadding: const EdgeInsets.symmetric(
                vertical: Dimensions.space5, horizontal: Dimensions.space15),
            bodyTextStyle: regularLarge.copyWith(color: MyColor.textColor),
          ),
        ),
        PageViewModel(
          title: MyStrings.realMoney,
          body: MyStrings.pickTheCorrectAnswer,
          image: SvgPicture.asset(MyImages.onBoard2SVG),
          decoration: PageDecoration(
            titlePadding: const EdgeInsets.symmetric(
                vertical: Dimensions.space5, horizontal: Dimensions.space15),
            bodyPadding: const EdgeInsets.symmetric(
                vertical: Dimensions.space5, horizontal: Dimensions.space15),
            titleTextStyle:
                semiBoldMediumLarge.copyWith(fontSize: Dimensions.space20),
            bodyTextStyle: regularLarge.copyWith(color: MyColor.textColor),
          ),
        ),
        PageViewModel(
          title: MyStrings.completeWIthFriends,
          body: MyStrings.whoIsSmartest,
          image: SvgPicture.asset(MyImages.onBoard3SVG),
          decoration: PageDecoration(
            titlePadding: const EdgeInsets.symmetric(
                vertical: Dimensions.space5, horizontal: Dimensions.space15),
            bodyPadding: const EdgeInsets.symmetric(
                vertical: Dimensions.space5, horizontal: Dimensions.space15),
            titleTextStyle:
                semiBoldMediumLarge.copyWith(fontSize: Dimensions.space20),
            bodyTextStyle: regularLarge.copyWith(color: MyColor.textColor),
          ),
        ),
      ],
      showSkipButton: false,
      dotsFlex: 1,
      showDoneButton: false,
      showBackButton: false,
      back: const Icon(Icons.arrow_back),
      next: const Icon(Icons.arrow_forward),
      showNextButton: false,
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(Dimensions.space16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(Dimensions.space12)
          : const EdgeInsets.fromLTRB(Dimensions.space8, Dimensions.space4,
              Dimensions.space8, Dimensions.space10),
      dotsDecorator: const DotsDecorator(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(Dimensions.space3))),
        activeColor: MyColor.primaryColor,
        size: Size(10.0, 5.0),
        color: MyColor.colorLightGrey,
        activeSize: Size(Dimensions.space22, Dimensions.space5),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(Dimensions.space3)),
        ),
      ),
    );
  }
}
