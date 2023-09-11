import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_images.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/data/controller/dashboard/dashboard_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../core/utils/my_color.dart';
import '../../../../core/utils/style.dart';


class WalletRequestSection extends StatefulWidget {
  const WalletRequestSection({super.key});

  @override
  State<WalletRequestSection> createState() => _WalletRequestSectionState();
}

class _WalletRequestSectionState extends State<WalletRequestSection> {


  @override
  Widget build(BuildContext context) {
    return   GetBuilder<DashBoardController>(
        builder: (controller) => SingleChildScrollView(
        physics:const BouncingScrollPhysics(),
        child: Column(
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
                                MyStrings.yourCoins.tr,
                                style: regularMediumLarge.copyWith(
                                    color: MyColor.textColor),
                              ),
                              const SizedBox(
                                height: Dimensions.space5,
                              ),
                              Text(
                                controller.coins,
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
                    // const Align(
                    //   alignment: Alignment.topLeft,
                    //   child: Padding(
                    //     padding: EdgeInsets.symmetric(
                    //       horizontal: Dimensions.space12,
                    //     ),
                    //     child: Text(
                    //       MyStrings.reedemableAmount.tr,
                    //       style: regularLarge,
                    //     ),
                    //   ),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(
                    //       horizontal: Dimensions.space12,
                    //       vertical: Dimensions.space10),
                    //   child: SizedBox(
                    //     height: Dimensions.space47,
                    //     child: TextField(
                    //       controller: _textEditingController,
                    //       keyboardType: TextInputType.number,
                    //       onChanged: (value) {
                    //         setState(() {
                    //           _inputText = value;
                    //         });
                    //       },
                    //       decoration: InputDecoration(
                    //           hintText: MyStrings.twoForty.tr,
                    //           filled: true,
                    //           fillColor: MyColor.cardColor,
                    //           labelStyle: regularMediumLarge.copyWith(
                    //               color: MyColor.textColor),
                    //           focusedBorder: const OutlineInputBorder(
                    //               borderSide: BorderSide(
                    //                   color: MyColor.cardBorderColors,
                    //                   width: .5)),
                    //           enabledBorder: OutlineInputBorder(
                    //               borderSide: const BorderSide(
                    //                   color: MyColor.cardBorderColors,
                    //                   width: .8),
                    //               borderRadius: BorderRadius.circular(
                    //                   Dimensions.space8))),
                    //     ),
                    //   ),
                    // ),
               
                    Padding(
                        padding: const EdgeInsets.all(Dimensions.space10),
                        child: ListView.builder(
                          physics:const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: 5,
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
                                          "Demo title",
                                          style: regularDefault.copyWith(
                                              color: MyColor.textColor),
                                        ))
                                  ],
                                ),
                              );
                            })),
                    // Padding(
                    //   padding: const EdgeInsets.all(Dimensions.space14),
                    //   child: RoundedButton(
                    //     text: MyStrings.reedemNow.tr,
                    //     press: () {
                    //        CustomBottomSheet(child: const PaymentBottomSheetScreen())
                    //       .customBottomSheet(context);
                    //     },
                    //     textSize: Dimensions.space18,
                    //     cornerRadius: Dimensions.space8,
                    //     verticalPadding: Dimensions.space15,
                    //   ),
                    // )
                  ],
                ),
      ),
    )
           ;
  }
}