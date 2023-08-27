import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/style.dart';
import 'package:flutter_prime/data/controller/gesstheword/gess_the_word_Controller.dart';
import 'package:get/get.dart';

class AnswarField extends StatefulWidget {
  int length;
  AnswarField({super.key, required this.length});

  @override
  State<AnswarField> createState() => _AnswarFieldState();
}

class _AnswarFieldState extends State<AnswarField> {
  late List<int> submittedAnswer = [];
  late List<String> correctAnswerLetterList = [];
  //to controll the answer text
  late List<AnimationController> controllers = [];
  late List<Animation<double>> animations = [];
  late int currentSelectedIndex = 0;

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < widget.length; i++) {
      Get.find<GessThewordController>().tempAns.add('-1');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GessThewordController>(builder: (controller) {
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
                width: Dimensions.space30,
                decoration: BoxDecoration(
                  border: controller.selectedIndex == index
                      ? Border.all(
                          color: MyColor.primaryColor,
                        )
                      : const Border(
                          bottom: BorderSide(width: 1.5, color: MyColor.borderColor),
                        ),
                  color: MyColor.borderColor.withOpacity(0.4),
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
