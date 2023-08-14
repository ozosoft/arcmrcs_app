import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/view/components/buttons/rounded_button.dart';
import 'package:flutter_prime/view/components/otp_field_widget/otp_field_widget.dart';
import 'package:get/get.dart';

import '../../../../../../../core/utils/style.dart';

class JoinRoomBodySection extends StatefulWidget {
  const JoinRoomBodySection({super.key});

  @override
  State<JoinRoomBodySection> createState() => _JoinRoomBodySectionState();
}

class _JoinRoomBodySectionState extends State<JoinRoomBodySection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
              top: Dimensions.space20,
              left: Dimensions.space10,
              right: Dimensions.space10),
          child: Container(
              padding: const EdgeInsets.only(top: Dimensions.space8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.space10),
                color: MyColor.colorWhite,
              ),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: Dimensions.space12, left: Dimensions.space15),
                    child: Text(
                      MyStrings.entryRoomCode,
                      style: regularMediumLarge.copyWith(
                          color: MyColor.textColor,
                          fontSize: Dimensions.space18),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                    vertical: Dimensions.space11),
                    child: OTPFieldWidget(onChanged: (value) {
                     },),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: Dimensions.space15,
                        top: Dimensions.space10,
                        bottom: Dimensions.space25,
                        right: Dimensions.space15),
                    child: RoundedButton(
                      text: MyStrings.start,
                      press: () {
                        Get.back();
                      },
                      color: MyColor.cardColor,
                      textColor: MyColor.textColor,
                      textSize: Dimensions.space18,
                      cornerRadius: Dimensions.space10,
                    ),
                  )
                ],
              )),
        ),
      ],
    );
  }
}
