import 'package:flutter/material.dart';
import 'package:flutter_prime/core/route/route.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/core/utils/style.dart';
import 'package:flutter_prime/view/components/bottom-sheet/custom_bottom_sheet.dart';
import 'package:flutter_prime/view/components/buttons/rounded_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

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

  TextEditingController _textEditingController = TextEditingController();
  String _inputText = "";
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
          body: TabBarView(controller: tabController, children: [
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(
                    top: Dimensions.space30,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        MyImages.coin,
                        fit: BoxFit.cover,
                        height: Dimensions.space47,
                      ),
                      const SizedBox(
                        width: Dimensions.space10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            MyStrings.yourCoins,
                            style: regularMediumLarge.copyWith(
                                color: MyColor.textColor),
                          ),
                          const SizedBox(
                            height: Dimensions.space5,
                          ),
                          const Text(
                            MyStrings.fivehundred,
                            style: semiBoldOverLarge,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: Dimensions.space20,
                ),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.space12,
                    ),
                    child: Text(
                      MyStrings.reedemableAmount,
                      style: regularLarge,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.space12,
                      vertical: Dimensions.space10),
                  child: SizedBox(
                    height: Dimensions.space47,
                    child: TextField(
                      controller: _textEditingController,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          _inputText = value;
                        });
                      },
                      decoration: InputDecoration(
                          hintText: MyStrings.twoForty,
                          filled: true,
                          fillColor: MyColor.cardColor,
                          labelStyle: regularMediumLarge.copyWith(
                              color: MyColor.textColor),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: MyColor.cardBorderColors,
                                  width: .5)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: MyColor.cardBorderColors,
                                  width: .8),
                              borderRadius: BorderRadius.circular(
                                  Dimensions.space8))),
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(Dimensions.space10),
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: MyStrings().rulesOfReedem.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  MyStrings.dot,
                                  style: regularDefault.copyWith(
                                      color: MyColor.textColor),
                                ),
                                const SizedBox(
                                  width: Dimensions.space10,
                                ),
                                SizedBox(
                                    width: Dimensions.space220,
                                    child: Text(
                                      MyStrings()
                                          .rulesOfReedem[index]["title"]
                                          .toString(),
                                      style: regularDefault.copyWith(
                                          color: MyColor.textColor),
                                    ))
                              ],
                            ),
                          );
                        })),
                Padding(
                  padding: const EdgeInsets.all(Dimensions.space14),
                  child: RoundedButton(
                    text: MyStrings.reedemNow,
                    press: () {
                       CustomBottomSheet(child: const PaymentBottomSheetScreen())
                      .customBottomSheet(context);
                    },
                    textSize: Dimensions.space18,
                    cornerRadius: Dimensions.space8,
                    verticalPadding: Dimensions.space15,
                  ),
                )
              ],
            ),
            const TransectionSection()
          ]),
        ));
  }
}
