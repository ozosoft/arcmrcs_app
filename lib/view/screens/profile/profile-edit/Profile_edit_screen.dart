import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_images.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/core/utils/style.dart';
import 'package:flutter_prime/core/utils/url_container.dart';
import 'package:flutter_prime/data/controller/account/profile_controller.dart';
import 'package:flutter_prime/data/controller/account/profile_update_controller.dart';
import 'package:flutter_prime/data/repo/account/profile_repo.dart';
import 'package:flutter_prime/data/services/api_service.dart';
import 'package:flutter_prime/view/components/app-bar/custom_category_appBar.dart';
import 'package:flutter_prime/view/components/buttons/rounded_button.dart';
import 'package:flutter_prime/view/components/divider/custom_divider.dart';
import 'package:flutter_prime/view/components/divider/or_divider.dart';
import 'package:flutter_prime/view/components/text-form-field/custom_text_field.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'profile_image.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  String selectedAvatar = '';
  XFile? imageFile;

  
   @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(ProfileRepo(apiClient: Get.find()));

    Get.put(ProfileUpdateController(profileRepo: Get.find()));

    super.initState();

  
  } 


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomCategoryAppBar(
        title: MyStrings.editProfile,
      ),
      body: GetBuilder<ProfileUpdateController>(
        builder: (controller) => SingleChildScrollView(
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
                    FittedBox(fit: BoxFit.cover, child: ProfileWidget(isEdit: true, imagePath: UrlContainer.dashboardUserProfileImage + controller.avatar, onClicked: () async {})),
                    // InkWell(
                    //   onTap: () {
                    //     _openGallery(context);
                    //   },
                    //   child: Container(
                    //     margin: const EdgeInsets.only(top: Dimensions.space70, right: 0, bottom: 0, left: Dimensions.space45),
                    //     child: InkWell(
                    //       child: SvgPicture.asset(
                    //         MyImages.cameraSVG,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
                const SizedBox(
                  height: Dimensions.space10,
                ),
                const OrDivider(),
                const SizedBox(
                  height: Dimensions.space10,
                ),
                const Text(MyStrings.chooseAvatar, style: semiBoldExtraLarge),
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
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(MyStrings.profileDetails, style: semiBoldExtraLarge),
                      ),
                      const CustomDivider(
                        space: Dimensions.space4,
                      ),
                      CustomTextField(
                        controller: controller.userNameController,
                        onChanged: () {},
                        needOutlineBorder: true,
                        hintText: MyStrings.username,
                        readOnly: true,
                        prefixicon: MyImages.personSVG,
                        hasIcon: true,
                        animatedLabel: true,
                        hastextcolor: false,
                        fontColor: MyColor.colorBlack,
                      ),
                      const CustomDivider(space: Dimensions.space10),
                      CustomTextField(
                        controller: controller.emailController,
                        onChanged: () {},
                        needOutlineBorder: true,
                        hintText: MyStrings.username,
                        readOnly: true,
                        prefixicon: MyImages.mailSVG,
                        hasIcon: true,
                        animatedLabel: true,
                        hastextcolor: false,
                        fontColor: MyColor.colorBlack,
                      ),
                      const CustomDivider(),
                      RoundedButton(
                        text: MyStrings.updateProfile,
                        press: () {
                          controller.updateProfilePic();
                        },
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
      ),
    );
  }

  void _openGallery(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: false, type: FileType.custom, allowedExtensions: ['png', 'jpg', 'jpeg']);

    if (result != null && result.files.isNotEmpty) {
      final pickedFile = result.files.single;
      final imagePath = pickedFile.path;

      if (imagePath != null) {
        setState(() {
          Get.find<ProfileController>().imageFile = File(result!.files.single.path!);
          imageFile = XFile(result.files.single.path!);
        });
      }
    }
  }
}
