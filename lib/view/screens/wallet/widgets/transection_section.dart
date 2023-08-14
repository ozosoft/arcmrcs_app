import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/core/utils/style.dart';
import 'package:flutter_prime/view/components/divider/custom_dashed_divider.dart';

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
      physics:const BouncingScrollPhysics(),
      child: Column(
        children: [
          const SizedBox(height: Dimensions.space20),
          Text(
            MyStrings.totalCoins,
            style: regularExtraLarge.copyWith(color: MyColor.textColor),
          ),
          const SizedBox(
            height: Dimensions.space10,
          ),
          const Text(MyStrings.fivehundredCoin, style: semiBoldOverLarge),
          const SizedBox(height: Dimensions.space20),
         const CustomDashedDivider(height: .2, width: double.infinity),
            const SizedBox(height: Dimensions.space10),
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return const ReedemRequestCard(amount: MyStrings.twoHundredFortyDollar,paymentType: MyStrings.paymentSystem,date: MyStrings.dates,pending: true,);
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
