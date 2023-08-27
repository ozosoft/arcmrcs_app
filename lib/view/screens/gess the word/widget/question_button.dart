import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/style.dart';
import 'package:flutter_prime/core/utils/util.dart';
import 'package:flutter_prime/data/controller/gesstheword/gess_the_word_Controller.dart';
import 'package:get/get.dart';

class QuestionButton extends StatefulWidget {
  String ans;
  QuestionButton({super.key, required this.ans});

  @override
  State<QuestionButton> createState() => _QuestionButtonState();
}

class _QuestionButtonState extends State<QuestionButton> {
  @override
  void initState() {
    // TODO: implement initState
    // widget.ans = generateRandomString(widget.ans.length);
    // print(widget.ans);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GessThewordController>(builder: (controller) {
      return Wrap(
        spacing: 10,
        runSpacing: 10,
        children: List.generate(
          widget.ans.length,
          (index) {
            return GestureDetector(
              onTap: () {
                controller.replace(widget.ans[index].toString());
                MyUtils.vibrate();
                log(controller.tempAns.toString());
              },
              child: Container(
                padding: const EdgeInsets.all(Dimensions.space3),
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  border: Border.all(
                    color: index == 3 ? MyColor.primaryColor : MyColor.borderColor,
                  ),
                  color: index == 3 ? MyColor.primaryColor : MyColor.borderColor,
                ),
                child: Center(
                  child: Text(
                    widget.ans[index].toUpperCase(),
                    style: semiBoldDefault.copyWith(
                      fontSize: Dimensions.fontMediumLarge,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );
    });
  }
}
