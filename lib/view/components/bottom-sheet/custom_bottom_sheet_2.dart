import 'package:flutter/material.dart';
import 'package:quiz_lab/core/utils/my_color.dart';

class CustomBottomSheetPlus {
  final Widget child;
  bool isNeedMargin;
  final VoidCallback? voidCallback;
  final Color bgColor;
  final bool enableDrag;
  final bool isScrollControlled;

  CustomBottomSheetPlus({
    required this.child,
    this.isNeedMargin = false,
    this.isScrollControlled = true,
    this.enableDrag = true,
    this.voidCallback,
    this.bgColor = MyColor.colorWhite,
  });

  void customBottomSheet(BuildContext context) {
    // showModalBottomSheet(
    //   enableDrag: enableDrag,
    //   isDismissible: true,
    //   isScrollControlled: isScrollControlled,
    //   backgroundColor: MyColor.transparentColor,
    //   context: context,
    //   builder: (BuildContext context) {
    //     return SingleChildScrollView(
    //       child: Container(
    //         decoration: BoxDecoration(
    //           color: bgColor,
    //           borderRadius: isNeedMargin ? BorderRadius.circular(15) : const BorderRadius.vertical(top: Radius.circular(15)),
    //         ),
    //         child: Column(
    //           mainAxisSize: MainAxisSize.min,
    //           children: [
    //             if (isNeedMargin) SizedBox(height: 15),
    //             Padding(
    //               padding: const EdgeInsets.symmetric(horizontal: Dimensions.space15, vertical: Dimensions.space12),
    //               child: child,
    //             ),
    //           ],
    //         ),
    //       ),
    //     );
    //   },
    // ).then((value) => voidCallback);
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      enableDrag: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.only(
          topEnd: Radius.circular(25),
          topStart: Radius.circular(25),
        ),
      ),
      builder: (context) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsetsDirectional.only(
            start: 20,
            end: 20,
            bottom: 30,
            top: 8,
          ),
          child: AnimatedPadding(
            padding: EdgeInsetsDirectional.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            duration: const Duration(milliseconds: 50),
            curve: Curves.decelerate,
            child: IntrinsicHeight(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.90, // Maximum height
                ),
                child: child, // Your child widget goes here
              ),
            ),
          ),
        );
      },
    ).then((value) => voidCallback);
  }
}
