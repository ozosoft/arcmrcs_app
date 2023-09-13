import 'package:flutter/material.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';
import 'package:quiz_lab/core/utils/my_color.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/core/utils/style.dart';
import 'package:quiz_lab/data/controller/dashboard/dashboard_controller.dart';
import 'package:quiz_lab/view/screens/wallet/widgets/wallet_request_section.dart';
import 'package:get/get.dart';


class TabBarWithButtons extends StatefulWidget {
  const TabBarWithButtons({super.key});

  @override
  State<TabBarWithButtons> createState() => _TabBarWithButtonsState();
}

class _TabBarWithButtonsState extends State<TabBarWithButtons>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;
  int selectedIndex = 1;


  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 1);
    setState(() {
      selectedIndex = tabController.index;
    });
  }

  @override
  Widget build(BuildContext context) {
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
