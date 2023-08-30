import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/core/utils/style.dart';
import 'package:flutter_prime/data/controller/account/profile_controller.dart';
import 'package:get/get.dart';

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
        padding: const EdgeInsets.all( Dimensions.space18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             const SizedBox(height: Dimensions.space10),
            const Text(
              MyStrings.profileDetails,
              style: boldMediumLarge,
            ),
             const SizedBox(height: Dimensions.space10),
            Container(
              decoration: BoxDecoration(
                  color: MyColor.colorWhite,
                  borderRadius: BorderRadius.circular(Dimensions.space10)),
              child: Column(
                children: [
                  ListTile(
                    title: Text(MyStrings.username,style: regularDefault.copyWith(color: MyColor.textColor),),
                    subtitle: Text(controller.username,style: semiBoldLarge.copyWith(color: MyColor.colorBlack,fontWeight: FontWeight.w500 )),
                  ),
                  const Divider(height:Dimensions.space3),
                  ListTile(
                   title: Text(MyStrings.emailAddress,style: regularDefault.copyWith(color: MyColor.textColor),),
                   subtitle: Text(controller.email,style: semiBoldLarge.copyWith(color: MyColor.colorBlack,fontWeight: FontWeight.w500 )),
                   ),
                ],
              )
            ),
          ],
        ),
      ),
    );
  }
}
