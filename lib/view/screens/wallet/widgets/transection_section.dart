import 'package:flutter/material.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';
import 'package:quiz_lab/core/utils/my_color.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/core/utils/style.dart';
import 'package:quiz_lab/view/components/divider/custom_dashed_divider.dart';
import 'package:get/get.dart';

import 'reedem_request_card.dart';

class TransectionSection extends StatefulWidget {
  const TransectionSection({super.key});

  @override
  State<TransectionSection> createState() => _TransectionSectionState();
}

class _TransectionSectionState extends State<TransectionSection> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          const SizedBox(height: Dimensions.space20),
          Text(
            MyStrings.totalCoins.tr,
            style: regularExtraLarge.copyWith(color: MyColor.textColor),
          ),
          const SizedBox(
            height: Dimensions.space10,
          ),
           Text(MyStrings.fivehundredCoin.tr, style: semiBoldOverLarge),
          const SizedBox(height: Dimensions.space20),
          const CustomDashedDivider(height: .2, width: double.infinity),
          const SizedBox(height: Dimensions.space10),
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return  ReedemRequestCard(
                    amount: MyStrings.twoHundredFortyDollar.tr,
                    paymentType: MyStrings.paymentSystem.tr,
                    date: MyStrings.dates.tr,
                    pending: true,
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider(
                    color: MyColor.textColor,
                  );
                },
                itemCount: 3),
          )
        ],
      ),
    );
  }
}
