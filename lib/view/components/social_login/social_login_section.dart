import 'package:flutter/material.dart';
import 'package:flutter_prime/core/route/route.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_images.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/core/utils/style.dart';
import 'package:flutter_prime/data/controller/auth/login_controller.dart';
import 'package:flutter_prime/view/components/social_login/widgets/social_login_button.dart';

import 'package:get/get.dart';

class SocialLoginSection extends StatelessWidget {
  final LoginController? loginController;
  const SocialLoginSection({super.key, this.loginController});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: Dimensions.space20,
        ),
        Padding(
          padding: EdgeInsets.all(Dimensions.space1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SocialLoginButton(
                title: MyStrings.continueWithGmail.tr,
                image: MyImages.google,
                ontap: () async {
                  await loginController!.signInWithGoogle();
                },
              ),
              SocialLoginButton(
                title: MyStrings.continueWithPhone.tr,
                image: MyImages.telephone,
                ontap: () {
                  Get.toNamed(RouteHelper.mobileLoginScreen);
                },
              ),
            ],
          ),
        ),
        const SizedBox(
          height: Dimensions.space20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Expanded(
                child: Divider(
              color: MyColor.colorLightGrey,
            )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.space15),
              child: Text(
                MyStrings.orsigninwith.tr,
                style: regularDefault.copyWith(color: MyColor.colorlighterGrey),
              ),
            ),
            const Expanded(
                child: Divider(
              color: MyColor.colorLightGrey,
            )),
          ],
        ),
      ],
    );
  }
}
