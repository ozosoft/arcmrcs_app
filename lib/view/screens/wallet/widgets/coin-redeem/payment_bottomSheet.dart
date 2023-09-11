import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_images.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/core/utils/style.dart';
import 'package:flutter_prime/view/components/bottom-sheet/bottom_sheet_bar.dart';
import 'package:flutter_prime/view/components/buttons/rounded_button.dart';
import 'package:flutter_prime/view/components/divider/or_divider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class PaymentBottomSheetScreen extends StatefulWidget {
  const PaymentBottomSheetScreen({super.key});

  @override
  State<PaymentBottomSheetScreen> createState() => _PaymentBottomSheetScreenState();
}

class _PaymentBottomSheetScreenState extends State<PaymentBottomSheetScreen> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const BottomSheetBar(),
        const SizedBox(
          height: Dimensions.space20,
        ),
        Align(
            alignment: Alignment.centerLeft,
            child: Text(
              MyStrings.payment.tr,
              style: semiBoldExtraLarge,
            )),
        const SizedBox(
          height: Dimensions.space20,
        ),
        Container(
            padding: const EdgeInsets.all(Dimensions.space12),
            width: double.infinity,
            decoration: BoxDecoration(border: Border.all(color: MyColor.colorBlack), borderRadius: BorderRadius.circular(3)),
            child: Row(
              children: [
                const SizedBox(
                  width: Dimensions.space10,
                ),
                SvgPicture.asset(MyImages.googleSvg),
                const SizedBox(
                  width: Dimensions.space20,
                ),
                Text(
                  MyStrings.paymentwithGooglePay.tr,
                  style: regularExtraLarge.copyWith(fontWeight: FontWeight.w500),
                ),
              ],
            )),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: Dimensions.space27),
          child: OrDivider(),
        ),
        Align(
            alignment: Alignment.centerLeft,
            child: Text(
              MyStrings.paymentMethod.tr,
              style: regularMediumLarge,
            )),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: Dimensions.space10),
          child: SizedBox(
            height: Dimensions.space47,
            child: TextField(
              controller: _textEditingController,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                });
              },
              decoration: InputDecoration(
                  hintText: MyStrings.twoForty.tr,
                  filled: true,
                  fillColor: MyColor.cardColor,
                  labelStyle: regularMediumLarge.copyWith(color: MyColor.textColor),
                  focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: MyColor.cardBorderColors, width: .5)),
                  enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: MyColor.cardBorderColors, width: .8), borderRadius: BorderRadius.circular(Dimensions.space8))),
            ),
          ),
        ),
        Align(
            alignment: Alignment.centerLeft,
            child: Text(
              MyStrings.selectGateway.tr,
              style: regularMediumLarge,
            )),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: Dimensions.space10),
          child: SizedBox(
            height: Dimensions.space47,
            child: TextField(
              controller: _textEditingController,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                });
              },
              decoration: InputDecoration(
                  hintText: MyStrings.twoForty.tr,
                  filled: true,
                  fillColor: MyColor.cardColor,
                  labelStyle: regularMediumLarge.copyWith(color: MyColor.textColor),
                  focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: MyColor.cardBorderColors, width: .5)),
                  enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: MyColor.cardBorderColors, width: .8), borderRadius: BorderRadius.circular(Dimensions.space8))),
            ),
          ),
        ),
        const SizedBox(
          height: Dimensions.space20,
        ),
        RoundedButton(
          text: MyStrings.submit.tr,
          press: () {},
          cornerRadius: Dimensions.space8,
          textSize: Dimensions.space20,
          verticalPadding: Dimensions.space16,
        )
      ],
    );
  }
}
