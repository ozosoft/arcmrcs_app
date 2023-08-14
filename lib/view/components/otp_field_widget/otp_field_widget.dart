import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter_prime/core/utils/style.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/my_color.dart';

class OTPFieldWidget extends StatelessWidget {
  final Color textcolor ,activeColor,inActiveColor;
  const OTPFieldWidget({Key? key, required this.onChanged, this.textcolor=MyColor.textColor, this.activeColor =MyColor.screenBgColor, this.inActiveColor=MyColor.cardBorderColors}) : super(key: key);

  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.space10),
      child: PinCodeTextField(
        appContext: context,
        pastedTextStyle: regularDefault.copyWith(color: MyColor.getTextColor()),
        length: 6,
        textStyle: regularExtraLarge.copyWith(color: MyColor.textColor),
        obscureText: false,
        obscuringCharacter: '*',
        blinkWhenObscuring: false,
        animationType: AnimationType.fade,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        pinTheme: PinTheme(
          fieldOuterPadding:const EdgeInsets.all(Dimensions.space4),
            shape: PinCodeFieldShape.box,
            borderWidth: Dimensions.space1,
            borderRadius: BorderRadius.circular(Dimensions.space8),
            fieldHeight: Dimensions.space45,
            fieldWidth: Dimensions.space45,
            inactiveColor: MyColor.cardBorderColors,
            inactiveFillColor: inActiveColor,
            activeFillColor: activeColor,
            activeColor: MyColor.getPrimaryColor(),
            selectedFillColor: MyColor.getScreenBgColor(),
            selectedColor: MyColor.getPrimaryColor()),
        cursorColor: MyColor.colorBlack,
        animationDuration: const Duration(milliseconds: 100),
        enableActiveFill: true,
        keyboardType: TextInputType.number,
        beforeTextPaste: (text) {
          return true;
        },
        onChanged: (value) => onChanged!(value),
      ),
    );
  }
}
