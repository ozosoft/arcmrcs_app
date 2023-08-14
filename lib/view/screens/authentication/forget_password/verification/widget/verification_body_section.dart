import 'package:flutter/material.dart';
import 'package:flutter_prime/core/route/route.dart';
import 'package:flutter_prime/core/utils/style.dart';
import 'package:flutter_prime/view/components/otp_field_widget/otp_field_widget.dart';
import 'package:flutter_prime/view/components/text/custom_underline_text.dart';
import 'package:get/get.dart';
import '../../../../../../core/utils/dimensions.dart';
import '../../../../../../core/utils/my_color.dart';
import '../../../../../../core/utils/my_strings.dart';
import '../../../../../components/buttons/rounded_button.dart';

class VerificationBodySection extends StatefulWidget {
  const VerificationBodySection({super.key});

  @override
  State<VerificationBodySection> createState() =>
      _VerificationBodySectionState();
}

class _VerificationBodySectionState extends State<VerificationBodySection> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: Dimensions.space70,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                MyStrings.enterVerificationcode,
                style:regularDefault.copyWith(fontSize: Dimensions.space20,fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: Dimensions.space8,
              ),
              Text(
                MyStrings.wehaveSentaCode,
               style: regularLarge.copyWith(color: MyColor.authScreenTextColor),
              ),
            ],
          ),
        ),
       Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: Dimensions.space20),
             Padding(
                 padding: const EdgeInsets.symmetric(horizontal: Dimensions.space25),
               child: OTPFieldWidget(onChanged: (value) {
                     },activeColor: MyColor.colorWhite,inActiveColor: MyColor.colorWhite, ),
             ),
              const SizedBox(height: Dimensions.space25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.space38),
                child: RoundedButton(
                    text: MyStrings.verifyNow,
                    press: () {Get.toNamed(RouteHelper.resetPassword);},
                    textSize: Dimensions.space17,
                    ),
              ),
              const SizedBox(height: Dimensions.space10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(MyStrings.didNotReceiveCode,style: regularLarge.copyWith(color: MyColor.getAuthTextColor(),fontWeight: FontWeight.w500)),
                  TextButton(onPressed: () {},child: const CustomUndelineText(text: MyStrings.resendCode))
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
