import 'package:flutter/material.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';
import 'package:quiz_lab/core/utils/my_color.dart';
import 'package:quiz_lab/core/utils/util.dart';

class CustomCard extends StatefulWidget {
  final double paddingLeft, paddingRight, paddingTop, paddingBottom;
  final double width;
  final Color backgroundColor;
  final double radius;
  final VoidCallback? onPressed;
  final Widget child;
  final bool isPress;

  const CustomCard(
      {Key? key,
      required this.width,
      this.paddingLeft = Dimensions.space15,
      this.paddingRight = Dimensions.space15,
      this.paddingTop = Dimensions.space15,
      this.paddingBottom = Dimensions.space15,
      this.backgroundColor = MyColor.colorWhite,
      this.radius = Dimensions.cardRadius,
      this.onPressed,
      this.isPress = false,
      required this.child})
      : super(key: key);

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  @override
  Widget build(BuildContext context) {
    return widget.isPress
        ? GestureDetector(
            onTap: widget.onPressed,
            child: Container(
              width: widget.width,
              padding: EdgeInsetsDirectional.only(
                  start: widget.paddingLeft,
                  end: widget.paddingRight,
                  top: widget.paddingTop,
                  bottom: widget.paddingBottom),
              decoration: BoxDecoration(
                color: widget.backgroundColor,
                borderRadius: BorderRadius.circular(widget.radius),
                boxShadow: MyUtils.getCardShadow(),
              ),
              child: widget.child,
            ),
          )
        : Container(
            width: widget.width,
            padding: EdgeInsetsDirectional.only(
                start: widget.paddingLeft,
                end: widget.paddingRight,
                top: widget.paddingTop,
                bottom: widget.paddingBottom),
            decoration: BoxDecoration(
              color: widget.backgroundColor,
              borderRadius: BorderRadius.circular(widget.radius),
              boxShadow: MyUtils.getCardShadow(),
            ),
            child: widget.child,
          );
  }
}
