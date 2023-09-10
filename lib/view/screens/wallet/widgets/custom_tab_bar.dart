import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/core/utils/style.dart';
import 'package:flutter_prime/data/controller/dashboard/dashboard_controller.dart';
import 'package:flutter_prime/view/screens/wallet/widgets/wallet_request_section.dart';
import 'package:get/get.dart';

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
    tabController = TabController(vsync: this, length: 1);
    setState(() {
      selectedIndex = tabController.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  DefaultTabController(
        length: 1,
        child:  GetBuilder<DashBoardController>(
           builder: (controller) => Scaffold(
            backgroundColor: MyColor.colorWhite,
            appBar: TabBar(
                controller: tabController,
                unselectedLabelColor: MyColor.textColor,
                labelStyle: regularMediumLarge,
                indicatorPadding: EdgeInsets.zero,
                indicator:const ShapeDecoration(
                    color: MyColor.primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: 
                        // selectedIndex == 0
                        //     ? 
                            BorderRadius.only(
                                topLeft: Radius.circular(Dimensions.space10),topRight: Radius.circular(Dimensions.space10)
                              )
                            // : const BorderRadius.only(
                            //     topRight: Radius.circular(Dimensions.space10),
                            //   ),
                              
                              )),
                onTap: (value) {
                  setState(() {
                    selectedIndex = tabController.index;
                  });
                },
                tabs:  [
                  Tab(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(MyStrings.request.tr),
                    ),
                  ),
                  // Tab(
                  //   child: Align(
                  //     alignment: Alignment.center,
                  //     child: Text(MyStrings.transaction.tr),
                  //   ),
                  // ),
                ]),
            body: TabBarView(controller: tabController, children: const[
               WalletRequestSection(),
              //  TransectionSection()
            ]),
          ),
        ));
  }
}
