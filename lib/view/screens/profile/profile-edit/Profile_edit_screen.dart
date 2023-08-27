import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_images.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/core/utils/style.dart';
import 'package:flutter_prime/view/components/app-bar/custom_category_appBar.dart';
import 'package:flutter_prime/view/components/buttons/rounded_button.dart';
import 'package:flutter_prime/view/components/divider/custom_divider.dart';
import 'package:flutter_prime/view/components/divider/or_divider.dart';
import 'package:flutter_prime/view/components/text-form-field/custom_text_field.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomCategoryAppBar(
        title: MyStrings.editProfile.tr,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: Dimensions.space40, right: Dimensions.space18, left: Dimensions.space18),
        child: Container(
          padding: const EdgeInsets.all(Dimensions.space16),
          width: double.infinity,
          decoration: BoxDecoration(color: MyColor.colorWhite, borderRadius: BorderRadius.circular(Dimensions.space10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                children: [
                  FittedBox(
                    fit: BoxFit.cover,
                    child: Container(
                      margin: const EdgeInsets.only(top: Dimensions.space20),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.space40), image: const DecorationImage(image: AssetImage(MyImages.profileimageWomenPng), fit: BoxFit.cover)),
                      height: Dimensions.space70,
                      width: Dimensions.space70,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: Dimensions.space70, right: 0, bottom: 0, left: Dimensions.space45),
                    child: InkWell(
                      // onTap: () {
                      //   Get.toNamed(RouteHelper.profileEditScreen);
                      // },
                      child: SvgPicture.asset(
                        MyImages.cameraSVG,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: Dimensions.space10,
              ),
              const OrDivider(),
              const SizedBox(
                height: Dimensions.space10,
              ),
              Text(MyStrings.chooseAvatar.tr, style: semiBoldExtraLarge),
              GridView.builder(
                  scrollDirection: Axis.vertical,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                  ),
                  itemCount: MyImages().avatars.length,
                  itemBuilder: (BuildContext context, index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [SvgPicture.asset(MyImages().avatars[index])],
                          ),
                        )
                      ],
                    );
                  }),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: Dimensions.space14),
                child: Divider(color: MyColor.colorLightGrey),
              ),
              Padding(
                padding: const EdgeInsets.all(Dimensions.space8),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(MyStrings.profileDetails.tr, style: semiBoldExtraLarge),
                    ),
                    const CustomDivider(
                      space: Dimensions.space4,
                    ),
                    CustomTextField(
                      onChanged: () {},
                      needOutlineBorder: true,
                      hintText: MyStrings.username.tr,
                      labelText: MyStrings.username.tr,
                      animatedLabel: true,
                      hastextcolor: false,
                      fontColor: MyColor.colorBlack,
                    ),
                    const CustomDivider(
                      space: Dimensions.space10,
                    ),
                    CustomTextField(
                      onChanged: () {},
                      needOutlineBorder: true,
                      hintText: MyStrings.username.tr,
                      labelText: MyStrings.email.tr,
                      prefixicon: MyImages.mailSVG,
                      hasIcon: true,
                      animatedLabel: true,
                      hastextcolor: false,
                      fontColor: MyColor.colorBlack,
                    ),
                    const CustomDivider(),
                    RoundedButton(
                      text: MyStrings.updateProfile.tr,
                      press: () {},
                      textSize: Dimensions.space17,
                      verticalPadding: Dimensions.space16,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
