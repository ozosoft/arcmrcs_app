import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/style.dart';
import 'package:flutter_prime/core/utils/util.dart';
import 'package:flutter_prime/data/controller/gesstheword/gess_the_word_Controller.dart';
import 'package:get/get.dart';

class GuessWordKeyBoard extends StatefulWidget {
  final String ans;
  const GuessWordKeyBoard({super.key, required this.ans});

  @override
  State<GuessWordKeyBoard> createState() => _GuessWordKeyBoardState();
}

class _GuessWordKeyBoardState extends State<GuessWordKeyBoard> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<GuessThewordController>(builder: (controller) {
      return Wrap(
        spacing: 10,
        runSpacing: 10,
        children: List.generate(
          widget.ans.length,
          (index) {
            return InkWell(
              onTap: () {
                controller.replace(widget.ans[index].toString());
                MyUtils.vibrate();
              },
              child: Container(
                padding: const EdgeInsets.all(Dimensions.space3),
                height: Dimensions.space40,
                width: Dimensions.space40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  border: Border.all(
                    color: MyColor.borderColor.withOpacity(0.3),
                  ),
                  color: MyColor.lightGray,
                ),
                child: Center(
                  child: Text(
                    widget.ans[index],
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
