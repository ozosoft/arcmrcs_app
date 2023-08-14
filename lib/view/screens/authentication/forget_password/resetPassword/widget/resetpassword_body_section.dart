import 'package:flutter/material.dart';
import 'package:flutter_prime/core/route/route.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_images.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/core/utils/style.dart';
import 'package:flutter_prime/view/components/buttons/rounded_button.dart';
import 'package:flutter_prime/view/components/text-form-field/custom_text_field.dart';
import 'package:get/get.dart';
import '../../../../../../core/utils/my_color.dart';

class ResetPasswordBodySection extends StatefulWidget {
  const ResetPasswordBodySection({super.key});

  @override
  State<ResetPasswordBodySection> createState() =>
      _ResetPasswordBodySectionState();
}

class _ResetPasswordBodySectionState extends State<ResetPasswordBodySection> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.space40,
        vertical: Dimensions.space20,
      ),
      child: Column(
        children: [
          Text(
            MyStrings.resetpassword,
            style:regularDefault.copyWith(fontSize: Dimensions.space20,fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: Dimensions.space8),
          Text(
            MyStrings.passwordMustBeDiffrentFromBefore,
            style: regularLarge.copyWith(color: MyColor.authScreenTextColor),
          ),
          Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: Dimensions.space20),
                CustomTextField(
                  hastextcolor: true,
                  hasIcon: true,
                  prefixicon: MyImages.lockSVG,
                  animatedLabel: true,
                  needOutlineBorder: true,
                  isShowSuffixIcon: true,
                  isPassword: true,
                  labelText: MyStrings.newPassword,
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
                const SizedBox(height: Dimensions.space25),
                CustomTextField(
                  hastextcolor: true,
                  hasIcon: true,
                  prefixicon: MyImages.lockSVG,
                  animatedLabel: true,
                  needOutlineBorder: true,
                  isShowSuffixIcon: true,
                  isPassword: true,
                  labelText: MyStrings.confirmPassword,
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
                const SizedBox(height: Dimensions.space40),
                RoundedButton(
                    text: MyStrings.continues,
                    press: () {
                      Get.toNamed(RouteHelper.loginScreen);
                    },textSize: Dimensions.space17),
               
              ],
            ),
          )
        ],
      ),
    );
  }
}
