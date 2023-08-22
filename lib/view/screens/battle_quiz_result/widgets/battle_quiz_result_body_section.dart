import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_images.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/utils/my_color.dart';
import '../../../../core/utils/my_strings.dart';
import '../../../../core/utils/style.dart';
import '../../../components/divider/custom_dashed_divider.dart';
import 'bottom_section_buttons.dart';
import 'player_profile_picture.dart';
import 'rewards_section.dart';
import 'right_and_wrong_ans_section.dart';

class BattleQuizResultBodySection extends StatefulWidget {
  const BattleQuizResultBodySection({super.key});

  @override
  State<BattleQuizResultBodySection> createState() => _BattleQuizResultBodySectionState();
}

class _BattleQuizResultBodySectionState extends State<BattleQuizResultBodySection> {
  bool showQuestions = false;
  bool audienceVote = false;
  bool tapAnswer = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        SvgPicture.asset(MyImages.reviewBgImage),
        Container(
          margin: const EdgeInsets.only(top: Dimensions.space20),
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.space20),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.space20), color: MyColor.colorWhite),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
                  Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(left: size.width * .3, top: Dimensions.space140),
                      child: Text(
                        MyStrings.victory,
                        style: semiBoldOverLarge.copyWith(fontSize: Dimensions.space30),
                      )),
                  Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(left: size.width * .256, top: Dimensions.space180),
                      child: Text(
                        MyStrings.congratulation,
                        style: regularOverLarge.copyWith(color: MyColor.colorQuizBodyText),
                      )),
                ],
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [RightOrWrongAnsSection(), PlayerProfilePicture(), RewardsSection()],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: Dimensions.space50),
                child: CustomDashedDivider(
                  height: Dimensions.space1,
                  width: double.infinity,
                ),
              ),
              const BottomSectionButtons()
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * .36),
          child: CircularCountDownTimer(
            duration: Dimensions.space60.toInt(),
            initialDuration: 0,
            controller: CountDownController(),
            width: Dimensions.space80,
            height: Dimensions.space90,
            ringColor: MyColor.primaryColor,
            ringGradient: null,
            fillColor: MyColor.timerbgColor,
            backgroundColor: MyColor.timerbgColor,
            strokeWidth: Dimensions.space5,
            strokeCap: StrokeCap.round,
            textStyle: semiBoldExtraLarge.copyWith(color: MyColor.primaryColor),
            textFormat: CountdownTextFormat.S,
            isReverse: true,
            isReverseAnimation: false,
            isTimerTextShown: true,
            autoStart: true,
            onComplete: () {},
          ),
        ),
      ],
    );
  }
}
