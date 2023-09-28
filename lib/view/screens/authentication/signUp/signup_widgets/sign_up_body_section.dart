import 'package:flutter/material.dart';
import 'package:quiz_lab/core/route/route.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';
import 'package:quiz_lab/core/utils/my_color.dart';
import 'package:quiz_lab/core/utils/my_images.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/core/utils/style.dart';
import 'package:quiz_lab/data/controller/auth/auth/registration_controller.dart';
import 'package:quiz_lab/data/repo/auth/general_setting_repo.dart';
import 'package:quiz_lab/data/repo/auth/signup_repo.dart';
import 'package:quiz_lab/data/services/api_service.dart';
import 'package:quiz_lab/view/components/buttons/rounded_button.dart';
import 'package:quiz_lab/view/components/buttons/rounded_loading_button.dart';
import 'package:quiz_lab/view/components/divider/custom_divider.dart';
import 'package:quiz_lab/view/components/text-form-field/custom_text_field.dart';
import 'package:quiz_lab/view/components/text/custom_underline_text.dart';
import 'package:quiz_lab/view/screens/authentication/signUp/signup_widgets/strong_password_section.dart';
import 'package:get/get.dart';

class SignUpBodySection extends StatefulWidget {
  const SignUpBodySection({super.key});

  @override
  State<SignUpBodySection> createState() => _SignUpBodySectionState();
}

class _SignUpBodySectionState extends State<SignUpBodySection> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(GeneralSettingRepo(apiClient: Get.find()));
    Get.put(RegistrationRepo(apiClient: Get.find()));
    Get.put(RegistrationController(registrationRepo: Get.find(), generalSettingRepo: Get.find()));

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<RegistrationController>().initData();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegistrationController>(
      builder: (controller) => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.space22,
          vertical: Dimensions.space15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              MyStrings.signUp.tr,
              style: semiBoldMediumLarge.copyWith(fontSize: Dimensions.space25),
            ),
            const SizedBox(height: Dimensions.space8),
            Text(
              MyStrings.pleaseEnterDetailstoSignUp.tr,
              style: regularLarge.copyWith(color: MyColor.authScreenTextColor, fontSize: Dimensions.space15),
            ),
            const SizedBox(height: Dimensions.space10),
            // const SocialLoginSection(),
            const CustomDivider(
              space: Dimensions.space10,
            ),
            Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomTextField(
                    controller: controller.userNameController,
                    hastextcolor: true,
                    hasIcon: true,
                    prefixicon: MyImages.personSVG,
                    animatedLabel: true,
                    needOutlineBorder: true,
                    labelText: MyStrings.username.tr,
                    onChanged: (value) {},
                    textInputType: TextInputType.emailAddress,
                    inputAction: TextInputAction.next,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return MyStrings.fieldErrorMsg.tr;
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: Dimensions.space20),
                  CustomTextField(
                    controller: controller.emailController,
                    hastextcolor: true,
                    hasIcon: true,
                    prefixicon: MyImages.mailSVG,
                    animatedLabel: true,
                    needOutlineBorder: true,
                    labelText: MyStrings.email.tr,
                    onChanged: (value) {},
                    textInputType: TextInputType.emailAddress,
                    inputAction: TextInputAction.next,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return MyStrings.fieldErrorMsg.tr;
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: Dimensions.space20),
                  CustomTextField(
                    controller: controller.passwordController,
                    hastextcolor: true,
                    hasIcon: true,
                    prefixicon: MyImages.lockSVG,
                    animatedLabel: true,
                    needOutlineBorder: true,
                    labelText: MyStrings.password.tr,
                    onChanged: (value) {
                      debugPrint(value);
                      //  controller.updateValidationList(value);
                      formKey.currentState!.validate();
                    },
                    isShowSuffixIcon: true,
                    isPassword: true,
                    textInputType: TextInputType.text,
                    inputAction: TextInputAction.done,
                    validator: (value) {
                      controller.updateValidationList(value);
                      if (controller.passwordValidationRules.where((element) => element.hasError == true).toList().isNotEmpty) {
                        return "";
                      } else {
                        return null;
                      }
                      // Password is valid if it passes all checks
                    },
                  ),
                  if (controller.passwordValidationRules.where((element) => element.hasError == true).toList().isEmpty) ...[
                    const SizedBox(
                      height: Dimensions.space10,
                    )
                  ],
                  if (controller.passwordController.text != '') ...[
                    StrongPassWordCheakSection(
                      passwordValidationRules: controller.passwordValidationRules,
                    ),
                  ],
                  const SizedBox(height: Dimensions.space15),
                  CustomTextField(
                    controller: controller.cPasswordController,
                    hastextcolor: true,
                    hasIcon: true,
                    prefixicon: MyImages.lockSVG,
                    animatedLabel: true,
                    needOutlineBorder: true,
                    labelText: MyStrings.confirmPassword.tr,
                    onChanged: (value) {
                      formKey.currentState!.validate();
                    },
                    isShowSuffixIcon: true,
                    isPassword: true,
                    textInputType: TextInputType.text,
                    inputAction: TextInputAction.done,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return MyStrings.fieldErrorMsg.tr;
                      }
                      if (value != controller.passwordController.text) {
                        return MyStrings.confirmYourPasswordNotMatch.tr;
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: Dimensions.space25),
                  controller.submitLoading
                      ? const RoundedLoadingBtn()
                      : RoundedButton(
                          text: MyStrings.signUp.tr,
                          press: () {
                            if (formKey.currentState!.validate()) {
                              controller.signUpUser();
                            }
                          },
                        ),
                  const SizedBox(height: Dimensions.space10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(MyStrings.alreadyAccount.tr, overflow: TextOverflow.ellipsis, style: regularLarge.copyWith(color: MyColor.getAuthTextColor(), fontWeight: FontWeight.w500)),
                      TextButton(
                        onPressed: () {
                          Get.toNamed(RouteHelper.loginScreen);
                        },
                        child: CustomUndelineText(text: MyStrings.signIn.tr),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
