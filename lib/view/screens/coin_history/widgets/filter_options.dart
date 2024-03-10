
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';
import 'package:quiz_lab/core/utils/my_color.dart';
import 'package:quiz_lab/core/utils/my_images.dart';
import 'package:quiz_lab/data/controller/coin_history/coin_history_controller.dart';

class FilterOptions extends StatefulWidget {
  const FilterOptions({super.key});

  @override
  State<FilterOptions> createState() => _FilterOptionsState();
}

class _FilterOptionsState extends State<FilterOptions> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CoinHistoryController>(
      builder: (controller) => Padding(
        padding: const EdgeInsets.all(Dimensions.space12),
        child: InkWell(
          customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * .22),
              ),
            onTap: () {
              controller.changeShowFilterVisibility();
            },
            child: CircleAvatar(
              
              backgroundColor: MyColor.primaryColor,
              child: SvgPicture.asset(
                controller.isFilterOn ? MyImages.cross : MyImages.filter,
                height: Dimensions.space15,
                colorFilter: const ColorFilter.mode(MyColor.colorWhite, BlendMode.srcIn),
              ),
            )),
      ),
    );
  }
}
