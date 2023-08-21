import 'package:flutter/material.dart';
import 'package:flutter_prime/core/route/route.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_images.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/core/utils/style.dart';
import 'package:flutter_prime/data/controller/auth/signin/signin_controller.dart';
import 'package:flutter_prime/view/components/buttons/rounded_button.dart';
import 'package:flutter_prime/view/components/divider/custom_divider.dart';
import 'package:flutter_prime/view/components/social_login/social_login_section.dart';
import 'package:flutter_prime/view/components/text/custom_underline_text.dart';
import 'package:flutter_prime/view/components/text/default_text.dart';
import 'package:get/get.dart';
import '../../../../components/text-form-field/custom_text_field.dart';

class LoginBodySection extends StatefulWidget {
  const LoginBodySection({super.key});

  @override
  State<LoginBodySection> createState() => _LoginBodySectionState();
}

class _LoginBodySectionState extends State<LoginBodySection> {
  final formKey = GlobalKey<FormState>();

  bool remember = false;

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<SignInController>();
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.space35, vertical: Dimensions.space7),
      child: Column(
        children: [
          SizedBox(
            height: Dimensions.space70,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  MyStrings.welcomeBack,
                  style: semiBoldMediumLarge.copyWith(
                      fontSize: Dimensions.space25),
                ),
                const SizedBox(height: Dimensions.space6),
                Text(
                  MyStrings.pleaseEnterDetails,
                  style: regularLarge.copyWith(
                      color: MyColor.authScreenTextColor,
                      fontSize: Dimensions.space15),
                ),
              ],
            ),
          ),
          const SocialLoginSection(),
          const CustomDivider(space: Dimensions.space10),
          Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomTextField(
                  hasIcon: true,
                  hastextcolor: true,
                  prefixicon: MyImages.personSVG,
                  animatedLabel: true,
                  needOutlineBorder: true,
                  labelText: MyStrings.username,
                  onChanged: (value) {},
                  textInputType: TextInputType.emailAddress,
                  inputAction: TextInputAction.next,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return MyStrings.fieldErrorMsg;
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: Dimensions.space20),
                CustomTextField(
                  hasIcon: true,
                  prefixicon: MyImages.lockSVG,
                  hastextcolor: true,
                  animatedLabel: true,
                  needOutlineBorder: true,
                  labelText: MyStrings.password,
                  onChanged: (value) {},
                  isShowSuffixIcon: true,
                  isPassword: true,
                  textInputType: TextInputType.text,
                  inputAction: TextInputAction.done,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return MyStrings.fieldErrorMsg;
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: Dimensions.space12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: Dimensions.space25,
                          height: Dimensions.space25,
                          child: Checkbox(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.defaultRadius)),
                              activeColor: MyColor.primaryColor,
                              checkColor: MyColor.colorWhite,
                              value: remember,
                              side: MaterialStateBorderSide.resolveWith(
                                (states) => BorderSide(
                                    width: Dimensions.space1,
                                    color: remember
                                        ? MyColor.getTextFieldEnableBorder()
                                        : MyColor.getTextFieldDisableBorder()),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  remember = !remember;
                                });
                              }),
                        ),
                        const SizedBox(width: Dimensions.space8),
                        DefaultText(
                          text: MyStrings.rememberMe,
                          textColor: MyColor.getAuthTextColor(),
                        )
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        Get.toNamed(RouteHelper.forgetpasswordScreen);
                      },
                      child: DefaultText(
                        text: MyStrings.forgotPassword,
                        textColor: MyColor.getAuthTextColor(),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: Dimensions.space25),
                RoundedButton(
                    text: MyStrings.signIn,
                    press: () {
                      Get.toNamed(RouteHelper.bottomNavBarScreen);
                    }),
                const SizedBox(height: Dimensions.space10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(MyStrings.doNotHaveAccount,
                        overflow: TextOverflow.ellipsis,
                        style: mediumOverSmall.copyWith(
                          fontSize: Dimensions.space14,
                          color: MyColor.getAuthTextColor(),
                        )),
                    TextButton(
                      onPressed: () {
                        Get.toNamed(RouteHelper.signupScreen);
                      },
                      child: const CustomUndelineText(text: MyStrings.signUp),
                    )
                  ],
                ),

                //ARMANS's DEMO CODE
                RoundedButton(
                  text: "Player 1 Login",
                  press: () {
                    // Perform authentication using authController methods
                    authController.signInWithEmailAndPassword(
                        "arman.khan.dev@gmail.com", "123456");
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                RoundedButton(
                  text: "Player 2 Login",
                  press: () {
                    // Perform authentication using authController methods
                    authController.signInWithEmailAndPassword(
                        "mr.akt.bd@gmail.com", "123456");
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                RoundedButton(
                  text: "Player 3 Login",
                  press: () {
                    // Perform authentication using authController methods
                    authController.signInWithEmailAndPassword(
                        "arman.khan.dev2@gmail.com", "123456");
                  },
                ),

                //ARMANS's DEMO CODE END
              ],
            ),
          )
        ],
      ),
    );
  }
}
