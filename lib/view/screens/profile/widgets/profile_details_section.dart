import 'package:flutter/material.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';
import 'package:quiz_lab/core/utils/my_color.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/core/utils/style.dart';
import 'package:quiz_lab/data/controller/account/profile_controller.dart';
import 'package:get/get.dart';
import 'package:quiz_lab/view/components/buttons/rounded_button.dart';
import 'package:quiz_lab/view/components/custom_loader/custom_loader.dart';

import '../../../../data/controller/auth/logout/logout_controller.dart';
import '../../../components/buttons/rounded_loading_button.dart';

class ProfileDetailsSection extends StatefulWidget {
  const ProfileDetailsSection({super.key});

  @override
  State<ProfileDetailsSection> createState() => _ProfileDetailsSectionState();
}

class _ProfileDetailsSectionState extends State<ProfileDetailsSection> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (controller) => Padding(
        padding: const EdgeInsets.all(Dimensions.space18),
        child: (controller.isLoading == true)
            ? Padding(padding: EdgeInsetsDirectional.symmetric(vertical: context.width * 0.15), child: const CustomLoader())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: Dimensions.space10),
                  Text(
                    MyStrings.profileDetails.tr,
                    style: boldMediumLarge,
                  ),
                  const SizedBox(height: Dimensions.space10),
                  Container(
                    decoration: BoxDecoration(color: MyColor.colorWhite, borderRadius: BorderRadius.circular(Dimensions.space10)),
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                            MyStrings.fullname.tr,
                            style: regularDefault.copyWith(color: MyColor.textColor),
                          ),
                          subtitle: Text(controller.profileRepo.apiClient.getUserFullName().tr, style: semiBoldLarge.copyWith(color: MyColor.colorBlack, fontWeight: FontWeight.w500)),
                        ),
                        const Divider(height: Dimensions.space3),
                        ListTile(
                          title: Text(
                            MyStrings.emailAddress.tr,
                            style: regularDefault.copyWith(color: MyColor.textColor),
                          ),
                          subtitle: Text(controller.email.tr, style: semiBoldLarge.copyWith(color: MyColor.colorBlack, fontWeight: FontWeight.w500)),
                        ),
                        const Divider(height: Dimensions.space3),
                        ListTile(
                          title: Text(
                            MyStrings.address.tr,
                            style: regularDefault.copyWith(color: MyColor.textColor),
                          ),
                          subtitle: Text(controller.addressController.text.tr, style: semiBoldLarge.copyWith(color: MyColor.colorBlack, fontWeight: FontWeight.w500)),
                        ),
                        const Divider(height: Dimensions.space3),
                        ListTile(
                          title: Text(
                            MyStrings.city.tr,
                            style: regularDefault.copyWith(color: MyColor.textColor),
                          ),
                          subtitle: Text(controller.cityController.text.tr, style: semiBoldLarge.copyWith(color: MyColor.colorBlack, fontWeight: FontWeight.w500)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: Dimensions.space20,
                  ),
                  GetBuilder<LogoutController>(
                      builder: (logoutController) => logoutController.loaderStarted
                          ? const RoundedLoadingBtn()
                          : RoundedButton(
                              text: MyStrings.logout,
                              press: () {
                                logoutController.logout();
                              })),
                ],
              ),
      ),
    );
  }
}
