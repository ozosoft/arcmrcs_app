import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_images.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/core/utils/style.dart';
import 'package:flutter_prime/data/controller/auth/login_controller.dart';
import 'package:flutter_prime/data/repo/auth/login_repo.dart';
import 'package:flutter_prime/data/services/api_service.dart';
import 'package:flutter_prime/view/components/buttons/rounded_button.dart';
import 'package:flutter_prime/view/components/buttons/rounded_loading_button.dart';
import 'package:flutter_prime/view/components/divider/custom_divider.dart';
import 'package:flutter_prime/view/components/image_widget/my_image_widget.dart';
import 'package:flutter_prime/view/components/snack_bar/show_custom_snackbar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../../core/utils/url_container.dart';
import '../../../../components/otp_field_widget/otp_field_widget.dart';
import 'country_bottom_sheet.dart';

class MobileLoginBodySection extends StatefulWidget {
  const MobileLoginBodySection({super.key});

  @override
  State<MobileLoginBodySection> createState() => _MobileLoginBodySectionState();
}

class _MobileLoginBodySectionState extends State<MobileLoginBodySection> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(LoginRepo(apiClient: Get.find()));
    Get.put(LoginController(loginRepo: Get.find()));

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<LoginController>().initMobileAuthData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      builder: (controller) => Column(
        children: [
          const SizedBox(height: Dimensions.space20),

          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.space25,
            ),
            child: SizedBox(
              height: Dimensions.space70,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    MyStrings.hiThere.tr,
                    style: semiBoldMediumLarge.copyWith(
                      fontSize: Dimensions.space25,
                    ),
                  ),
                  const SizedBox(height: Dimensions.space6),
                  Text(
                    controller.isInOTPpage == true ? MyStrings.pleaseEnterOTP.tr : MyStrings.pleaseEnterPhone.tr,
                    style: regularLarge.copyWith(
                      color: MyColor.authScreenTextColor,
                      fontSize: Dimensions.space15,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // const SocialLoginSection(),
          const CustomDivider(space: Dimensions.space10),
          const SizedBox(height: Dimensions.space20),

          Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (controller.isInOTPpage != true)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.space25,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: MyColor.colorWhite,
                        border: Border.all(color: MyColor.primaryColor.withOpacity(0.08)),
                        borderRadius: BorderRadius.circular(Dimensions.space8),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: Dimensions.space10, vertical: Dimensions.space2),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              CountryBottomSheet.bottomSheet(context, controller);
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                MyImageWidget(
                                  imageUrl: UrlContainer.countryFlagImageLink.replaceAll("{countryCode}", controller.selectedCountryData.countryCode.toString().toLowerCase()),
                                  height: Dimensions.space25,
                                  width: Dimensions.space42,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: Dimensions.space10),
                                  child: Text(
                                    "${MyStrings.plusText.tr}${controller.selectedCountryData.dialCode}",
                                    style: regularMediumLarge,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: Dimensions.space10),
                              child: TextFormField(
                                controller: controller.mobileNumberController,
                                focusNode: controller.mobileNumberFocusNode,
                                decoration: InputDecoration(
                                    suffixIcon: Padding(
                                      padding: const EdgeInsets.all(Dimensions.space15),
                                      child: SvgPicture.asset(MyImages.phoneSVG),
                                    ),
                                    border: InputBorder.none, // Remove border
                                    filled: false, // Remove fill
                                    contentPadding: const EdgeInsets.only(top: 14.5, left: 0, right: 15, bottom: 5),
                                    hintStyle: regularMediumLarge.copyWith(color: MyColor.greyTextColor),
                                    hintText: MyStrings.enterPhoneNumber000),
                                keyboardType: TextInputType.phone, // Set keyboard type to phone
                                style: regularMediumLarge,
                                cursorColor: MyColor.primaryColor, // Set cursor color to red
                                onChanged: (value) {
                                  return;
                                },
                                validator: (value) {
                                  final whitespaceOrEmpty = RegExp(r"^\s*$|^$");
                                  if (whitespaceOrEmpty.hasMatch(value ?? "")) {
                                    controller.validatePhoneNumber(false);
                                    CustomSnackBar.error(errorList: [MyStrings.enterYourPhoneNumber.tr]);
                                    return null;
                                  } else {
                                    controller.validatePhoneNumber(true);
                                    return null;
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                if (controller.isInOTPpage)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: Dimensions.space10, vertical: Dimensions.space2),
                    child: OTPFieldWidget(
                      tController: controller.otpFiledController,
                      length: 6,
                       
                      onChanged: (value) {
                        // controller.currentText = value;
                      },
                    ),
                  ),
                const SizedBox(height: Dimensions.space25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.space25, vertical: Dimensions.space7),
                  child: Column(
                    children: [
                      controller.sendOtpButtonLoading == true
                          ? const RoundedLoadingBtn()
                          : RoundedButton(
                              text: controller.isInOTPpage == true ? MyStrings.confirm.tr : MyStrings.sendOTP.tr,
                              press: () {
                                // Get.toNamed(RouteHelper.bottomNavBarScreen);

                                if (controller.isInOTPpage == true && controller.otpFiledController.text.isNotEmpty) {
                                  print("From Otp Button");
                                  controller.signInWithOTP(controller.otpFiledController.text);
                                } else {
                                  if (formKey.currentState!.validate() && controller.phoneNumberValidate == true) {
                                    controller.verifyPhoneNumber();
                                  }
                                }
                              }),
                    ],
                  ),
                ),
                const SizedBox(height: Dimensions.space10),
              ],
            ),
          )
        ],
      ),
    );
  }
}
