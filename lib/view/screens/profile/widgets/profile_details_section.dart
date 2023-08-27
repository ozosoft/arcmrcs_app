import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/core/utils/style.dart';
import 'package:get/get.dart';

class ProfileDetailsSection extends StatefulWidget {
  const ProfileDetailsSection({super.key});

  @override
  State<ProfileDetailsSection> createState() => _ProfileDetailsSectionState();
}

class _ProfileDetailsSectionState extends State<ProfileDetailsSection> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimensions.space18),
      child: Column(
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
            child: ListView.separated(
              shrinkWrap: true,
              separatorBuilder: (context, index) {
                return const Divider(color: MyColor.cardBorderColors, height: Dimensions.space2, indent: Dimensions.space20, endIndent: Dimensions.space20);
              },
              physics: const NeverScrollableScrollPhysics(),
              itemCount: MyStrings().itemList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    MyStrings().itemList[index]['title']!,
                    style: regularDefault.copyWith(color: MyColor.textColor),
                  ),
                  subtitle: Text(MyStrings().itemList[index]['description']!, style: semiBoldLarge.copyWith(color: MyColor.colorBlack, fontWeight: FontWeight.w500)),
                  onTap: () {},
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
