import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/core/utils/style.dart';
import 'package:flutter_prime/view/components/bottom-sheet/custom_bottom_sheet.dart';
import 'package:flutter_prime/view/components/buttons/rounded_button.dart';
import 'package:flutter_prime/view/screens/wallet/widgets/wallet_request_section.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/utils/my_images.dart';
import 'coin-redeem/payment_bottomSheet.dart';
import 'transection_section.dart';

class TabBarWithButtons extends StatefulWidget {
  const TabBarWithButtons({super.key});

  @override
  State<TabBarWithButtons> createState() => _TabBarWithButtonsState();
}

class _TabBarWithButtonsState extends State<TabBarWithButtons>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;
  int selectedIndex = 1;


  void initState() {
    tabController = TabController(vsync: this, length: 2);
    setState(() {
      selectedIndex = tabController.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: MyColor.colorWhite,
          appBar: TabBar(
              controller: tabController,
              unselectedLabelColor: MyColor.textColor,
              labelStyle: regularMediumLarge,
              indicatorPadding: EdgeInsets.zero,
              indicator: ShapeDecoration(
                  color: MyColor.primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: selectedIndex == 0
                          ? const BorderRadius.only(
                              topLeft: Radius.circular(Dimensions.space10),
                            )
                          : const BorderRadius.only(
                              topRight: Radius.circular(Dimensions.space10),
                            ))),
              onTap: (value) {
                setState(() {
                  selectedIndex = tabController.index;
                });
              },
              tabs: const [
                Tab(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(MyStrings.request),
                  ),
                ),
                Tab(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(MyStrings.transaction),
                  ),
                ),
              ]),
          body: TabBarView(controller: tabController, children: const[
             WalletRequestSection(),
             TransectionSection()
          ]),
        ));
  }
}
