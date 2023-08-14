import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/core/utils/style.dart';

class ReedemRequestCard extends StatefulWidget {
  final String paymentType, date, amount;
 final  bool pending, completed;

  const ReedemRequestCard({super.key, this.paymentType="", this.date="", this.amount="",  this.pending=false, this.completed=false});

  @override
  State<ReedemRequestCard> createState() => _ReedemRequestCardState();
}

class _ReedemRequestCardState extends State<ReedemRequestCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.space10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                MyStrings.reedemRequest,
                style: semiBoldMediumLarge,
              ),
              const SizedBox(
                height: Dimensions.space5,
              ),
              Text(
                widget.paymentType,
                style: regularLarge.copyWith(color: MyColor.textColor),
              ),
              const SizedBox(
                height: Dimensions.space5,
              ),
              Text(
                widget.date,
                style: regularLarge.copyWith(color: MyColor.textColor),
              ),
            ],
          ),
          Column(crossAxisAlignment: CrossAxisAlignment.end,
            children: [
               Text(widget.amount,
                  style: semiBoldMediumLarge),
              const SizedBox(
                height: Dimensions.space5,
              ),
            widget.pending?  Container(
                padding: const EdgeInsets.all(Dimensions.space3),
                decoration: BoxDecoration(
                    color: MyColor.pendingContainerColor,
                    border: Border.all(color: MyColor.pendingBorderColor),
                    borderRadius: BorderRadius.circular(Dimensions.space5)),
                child: Text(MyStrings.pending,
                    style: regularDefault.copyWith(
                        color: MyColor.pendingBorderColor,
                        fontSize: Dimensions.space10)),
              ):
              Container(
                padding: const EdgeInsets.all(Dimensions.space3),
                decoration: BoxDecoration(
                    color: MyColor.completedContainerColor,
                    border: Border.all(color: MyColor.completedBorderColor),
                    borderRadius: BorderRadius.circular(Dimensions.space5)),
                child: Text(MyStrings.complete,
                    style: regularDefault.copyWith(
                        color: MyColor.completedBorderColor,
                        fontSize: Dimensions.space10)),
              ),
              const SizedBox(height: Dimensions.space20),
            ],
          )
        ],
      ),
    );
  }
}
