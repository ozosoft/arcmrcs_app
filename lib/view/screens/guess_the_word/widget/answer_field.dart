import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/style.dart';
import 'package:flutter_prime/data/controller/gesstheword/gess_the_word_Controller.dart';
import 'package:get/get.dart';

class AnswerField extends StatefulWidget {
  final int length;
  const AnswerField({super.key, required this.length});

  @override
  State<AnswerField> createState() => _AnswerFieldState();
}

class _AnswerFieldState extends State<AnswerField> {
  late List<int> submittedAnswer = [];
  late List<String> correctAnswerLetterList = [];
  //to controll the answer text
  late List<AnimationController> controllers = [];
  late List<Animation<double>> animations = [];
  late int currentSelectedIndex = 0;

  @override
  void initState() {
    super.initState();
    Get.find<GuessThewordController>().tempAns.clear();
    for (var i = 0; i < widget.length; i++) {
      Get.find<GuessThewordController>().tempAns.add('-1');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GuessThewordController>(builder: (controller) {
      return Wrap(
        spacing: 10,
        runSpacing: 10,
        alignment: WrapAlignment.center,
        children: List.generate(
          controller.tempAns.length,
          (index) {
            // controller.changeTempListLenght(0);

            return GestureDetector(
              onTap: () {
                controller.selectIndex(index);
              },
              child: Container(
                padding: const EdgeInsets.all(Dimensions.space3),
                height: Dimensions.space30,
                width: Dimensions.space40,
                decoration: BoxDecoration(
                  border: controller.selectedIndex == index
                      ? const Border(
                          top: BorderSide(width: 1, color: MyColor.primaryColor),
                          bottom: BorderSide(width: 1, color: MyColor.primaryColor),
                        )
                      : const Border(
                          bottom: BorderSide(width: 1.5, color: MyColor.borderColor),
                        ),
                  // color: MyColor.borderColor.withOpacity(0.4),
                ),
                child: Center(
                  child: Text(
                    controller.tempAns[index] == '-1' ? '' : controller.tempAns[index],
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
