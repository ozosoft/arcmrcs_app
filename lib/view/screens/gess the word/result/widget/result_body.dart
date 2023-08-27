import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_prime/core/route/route.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_images.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/core/utils/style.dart';
import 'package:flutter_prime/data/controller/gesstheword/gess_the_word_Controller.dart';
import 'package:flutter_prime/view/components/buttons/rounded_button.dart';
import 'package:flutter_prime/view/components/column_widget/bottom_sheet_column.dart';
import 'package:flutter_prime/view/components/divider/custom_dashed_divider.dart';
import 'package:flutter_prime/view/components/image/custom_svg_picture.dart';
import 'package:flutter_prime/view/screens/quiz-result/widgets/bottom_section_buttons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class GessResultBody extends StatefulWidget {
  const GessResultBody({super.key});

  @override
  State<GessResultBody> createState() => _GessResultBodyState();
}

class _GessResultBodyState extends State<GessResultBody> {
  bool showQuestions = false;
  bool audienceVote = false;
  bool tapAnswer = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<GessThewordController>(builder: (controller) {
      return Container(
        margin: const EdgeInsets.only(top: Dimensions.space20),
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.space20, vertical: Dimensions.space30),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.space20), color: MyColor.colorWhite),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: Dimensions.space40, left: Dimensions.space8, right: Dimensions.space8),
                  child: SvgPicture.asset(
                    MyImages.victory,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: CustomSvgPicture(image: MyImages.cup, color: Colors.orange.shade400, height: 200),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: Dimensions.space20),
              child: CustomDashedDivider(
                height: Dimensions.space1,
                width: double.infinity,
              ),
            ),
            RoundedButton(text: MyStrings.nextLevel, press: () {}, textSize: Dimensions.space21),
            const SizedBox(
              height: Dimensions.space20,
            ),
            RoundedButton(
              text: MyStrings.playAgain,
              press: () {
                Get.toNamed(RouteHelper.reviewAnswerScreen);
              },
              color: MyColor.colorBlack,
              textSize: Dimensions.space21,
            ),
          ],
        ),
      );
    });
  }
}
