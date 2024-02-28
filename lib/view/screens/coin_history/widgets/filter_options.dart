import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';
import 'package:quiz_lab/core/utils/my_color.dart';
import 'package:quiz_lab/core/utils/my_images.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/core/utils/style.dart';
import 'package:quiz_lab/data/controller/coin_history/coin_history_controller.dart';
import 'package:quiz_lab/view/components/alert-dialog/custom_alert_dialog.dart';
import 'package:quiz_lab/view/components/divider/custom_divider.dart';

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
        padding: const EdgeInsets.all(Dimensions.space8),
        child: InkWell(
            onTap: () {
              CustomAlertDialog(
                  child: Column(
                children: [
                  const Text(
                    MyStrings.chooseAnOption,
                    style: semiBoldLarge,
                  ),
                  const SizedBox(height: Dimensions.space15),
                  GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                    shrinkWrap: true,
                    itemCount: controller.filterOptionList.length,
                    itemBuilder: (context, index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              controller.selectedFilteredValue = controller.filterOptionList[index].toString();
                              controller.filterdList();
                              print(controller.filterOptionList[index].toString());
                            },
                            child: Container(
                                margin: const EdgeInsets.all(Dimensions.space8),
                                padding: const EdgeInsets.symmetric(horizontal: Dimensions.space15, vertical: Dimensions.space10),
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.space5), border: Border.all(color: MyColor.getGreyText())),
                                child: Text(
                                  controller.filterOptionList[index].toString(),
                                  style: regularExtraLarge,
                                )),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              )).customAlertDialog(context);
            },
            child: SvgPicture.asset(
              MyImages.arrowDown,
              height: 15,
            )),
      ),
    );
  }
}
