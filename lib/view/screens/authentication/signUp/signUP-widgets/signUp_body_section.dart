import 'package:flutter/material.dart';
import 'package:flutter_prime/core/route/route.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_images.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/core/utils/style.dart';
import 'package:flutter_prime/view/components/buttons/rounded_button.dart';
import 'package:flutter_prime/view/components/divider/custom_divider.dart';
import 'package:flutter_prime/view/components/social_login/social_login_section.dart';
import 'package:flutter_prime/view/components/text-form-field/custom_text_field.dart';
import 'package:flutter_prime/view/components/text/custom_underline_text.dart';
import 'package:flutter_prime/view/screens/authentication/signUp/signUP-widgets/strong_password_section.dart';
import 'package:get/get.dart';

class SignUpBodySection extends StatefulWidget {
  const SignUpBodySection({super.key});

  @override
  State<SignUpBodySection> createState() => _SignUpBodySectionState();
}

class _SignUpBodySectionState extends State<SignUpBodySection> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.space30,
        vertical: Dimensions.space15,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            MyStrings.signUp,
            style: semiBoldMediumLarge.copyWith(fontSize: Dimensions.space25),
          ),
          const SizedBox(height: Dimensions.space8),
          Text(
            MyStrings.pleaseEnterDetailstoSignUp,
            style: regularLarge.copyWith(
                color: MyColor.authScreenTextColor,
                fontSize: Dimensions.space15),
          ),
          const SocialLoginSection(),
          const CustomDivider(
            space: Dimensions.space10,
          ),
          Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomTextField(
                  hastextcolor: true,
                  hasIcon: true,
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
                  hastextcolor: true,
                  hasIcon: true,
                  prefixicon: MyImages.mailSVG,
                  animatedLabel: true,
                  needOutlineBorder: true,
                  labelText: MyStrings.email,
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
                  hastextcolor: true,
                  hasIcon: true,
                  prefixicon: MyImages.lockSVG,
                  animatedLabel: true,
                  needOutlineBorder: true,
                  labelText: MyStrings.password,
                  onChanged: (value) {
                    print(value);
                  },
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
                const SizedBox(height: Dimensions.space2),
                const StrongPassWordCheakSection(),
                const SizedBox(height: Dimensions.space15),
                CustomTextField(
                  hastextcolor: true,
                  hasIcon: true,
                  prefixicon: MyImages.lockSVG,
                  animatedLabel: true,
                  needOutlineBorder: true,
                  labelText: MyStrings.confirmPassword,
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
                const SizedBox(height: Dimensions.space25),
                RoundedButton(
                  text: MyStrings.signUp,
                  press: () {},
                ),
                const SizedBox(height: Dimensions.space10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(MyStrings.alreadyAccount,
                        overflow: TextOverflow.ellipsis,
                        style: regularLarge.copyWith(
                            color: MyColor.getAuthTextColor(),
                            fontWeight: FontWeight.w500)),
                     TextButton(
                      onPressed: () {
                        Get.toNamed(RouteHelper.loginScreen);
                      },
                      child: const CustomUndelineText(text: MyStrings.signIn),
                    ),
                    
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
