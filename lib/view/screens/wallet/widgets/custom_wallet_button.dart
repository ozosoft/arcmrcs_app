// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/style.dart';

class WalletButton extends StatefulWidget {
  final Color buttonColor;
  final String buttonText;
  final double height, topLeftradious, topRightRadious;
  bool tapped;
  final VoidCallback onTap;
  WalletButton({
    super.key,
    this.buttonColor = MyColor.cardColor,
    this.height = Dimensions.space45,
    this.tapped = false,
    required this.onTap,
    required this.buttonText,
    this.topLeftradious = 0,
    this.topRightRadious = 0,
  });

  @override
  State<WalletButton> createState() => _WalletButtonState();
}

class _WalletButtonState extends State<WalletButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          widget.tapped = !widget.tapped;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(widget.topLeftradious), topRight: Radius.circular(widget.topRightRadious)),
          color: widget.tapped ? widget.buttonColor : MyColor.cardColor,
        ),
        height: widget.height,
        child: Center(
            child: Text(
          widget.buttonText,
          style: regularMediumLarge.copyWith(color: widget.tapped ? MyColor.colorWhite : MyColor.textColor),
        )),
      ),
    );
  }
}
