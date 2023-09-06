import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';

import '../../../core/utils/my_color.dart';
import '../../../core/utils/style.dart';

class CustomCategoryAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? children;
  const CustomCategoryAppBar({super.key, required this.title,  this.children});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: semiBoldMediumLarge,
      ),
      backgroundColor: MyColor.colorWhite,
      iconTheme: const IconThemeData(color: MyColor.colorBlack),
      toolbarHeight: Dimensions.space70,
      elevation: .1,
      shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(Dimensions.space25),
      )),
      actions: children,
    );
  }

  @override
  Size get preferredSize => const Size(
        double.maxFinite,
        Dimensions.space56,
      );
}
