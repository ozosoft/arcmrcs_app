import 'package:flutter/material.dart';
import 'package:flutter_prime/core/route/route.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_images.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/core/utils/style.dart';
import 'package:flutter_prime/view/components/buttons/rounded_button.dart';
import 'package:flutter_prime/view/components/text-form-field/custom_text_field.dart';
import 'package:get/get.dart';

class ForgetPasswordBodySection extends StatefulWidget {
  const ForgetPasswordBodySection({super.key});

  @override
  State<ForgetPasswordBodySection> createState() =>
      _ForgetPasswordBodySectionState();
}

class _ForgetPasswordBodySectionState extends State<ForgetPasswordBodySection> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.space40,
        vertical: Dimensions.space30,
      ),
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                MyStrings.forgetPassword,
                style:regularDefault.copyWith(fontSize: Dimensions.space20,fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: Dimensions.space8),
              Text(
                MyStrings.enterEmailAndPassword,
                style: regularLarge.copyWith(color: MyColor.authScreenTextColor),
              ),
            ],
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
                const SizedBox(height: Dimensions.space40),
                RoundedButton(
                    text: MyStrings.continues,
                    press: () {
                      Get.toNamed(RouteHelper.verificationScreen);
                    }),
                const SizedBox(height: Dimensions.space10),
              ],
            ),
          )
        ],
      ),
    );
  }
}
