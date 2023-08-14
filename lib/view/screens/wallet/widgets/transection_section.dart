import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/style.dart';

class TransectionSection extends StatefulWidget {
  const TransectionSection({super.key});

  @override
  State<TransectionSection> createState() => _TransectionSectionState();
}

class _TransectionSectionState extends State<TransectionSection> {
  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Card(
            elevation: 0,
            child: Column(
              children: [
                Text("Total Earnings",style: regularExtraLarge.copyWith(color: MyColor.textColor),),
                const SizedBox(height: Dimensions.space10,),
                const Text("\$ 0.0",style: semiBoldOverLarge,)
              ],
            ),
          ),
        )
      ],
    );
  }
}