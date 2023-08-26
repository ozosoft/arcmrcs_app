import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_images.dart';
import 'package:flutter_prime/data/controller/battle/battle_result_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../core/utils/my_color.dart';
import '../../../../core/utils/my_strings.dart';
import '../../../../core/utils/style.dart';
import '../../../../data/repo/battle/battle_repo.dart';
import '../../../../data/services/api_service.dart';
import '../../../components/divider/custom_dashed_divider.dart';
import 'bottom_section_buttons.dart';
import 'player_profile_details.dart';
import 'player_profile_picture.dart';
import 'rewards_section.dart';
import 'right_and_wrong_ans_section.dart';

class BattleQuizResultBodySection extends StatefulWidget {
  const BattleQuizResultBodySection({super.key});

  @override
  State<BattleQuizResultBodySection> createState() => _BattleQuizResultBodySectionState();
}

class _BattleQuizResultBodySectionState extends State<BattleQuizResultBodySection> {
  @override
  void initState() {
    super.initState();
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(BattleRepo(apiClient: Get.find()));
    Get.put(BattleResultController(Get.find()));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<BattleResultController>(builder: (controller) {
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
                    // Container(
                    //   width: double.infinity,
                    //   padding: const EdgeInsets.only(top: Dimensions.space40, left: Dimensions.space8, right: Dimensions.space8),
                    //   child: SvgPicture.asset(
                    //     MyImages.victory,
                    //     fit: BoxFit.cover,
                    //   ),
                    // ),
                    Container(
                        width: double.infinity,
                        padding: const EdgeInsets.only(top: Dimensions.space20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (controller.messageStatus.contains('Congratulations') == true) ...[
                              Text(
                                MyStrings.victory,
                                style: semiBoldOverLarge.copyWith(fontSize: Dimensions.space30),
                              ),
                              const SizedBox(
                                height: Dimensions.space10,
                              ),
                              Text(
                                MyStrings.congratulation,
                                style: regularOverLarge.copyWith(color: MyColor.colorQuizBodyText, fontSize: Dimensions.fontLarge),
                              )
                            ] else ...[
                              Text(
                                MyStrings.defeat,
                                style: semiBoldOverLarge.copyWith(fontSize: Dimensions.space30),
                              ),
                              const SizedBox(
                                height: Dimensions.space10,
                              ),
                              Text(
                                MyStrings.betterLuckNextTime,
                                style: regularOverLarge.copyWith(color: MyColor.colorQuizBodyText, fontSize: Dimensions.fontLarge),
                              )
                            ],
                          ],
                        )),
                  ],
                ),
                const SizedBox(
                  height: Dimensions.space20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        const PlayerProfileDetails(),
                        const SizedBox(
                          height: Dimensions.space20,
                        ),
                        Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.space6), color: MyColor.categoryCardBodyColor),
                          padding: const EdgeInsets.symmetric(vertical: Dimensions.space10, horizontal: Dimensions.space14),
                          child: Row(
                            children: [
                              SvgPicture.asset(MyImages.greenTikSvg),
                              const SizedBox(width: Dimensions.space6),
                              Text(
                                "${controller.correctAnswer}/${controller.totalQuestion}",
                                style: regularDefault.copyWith(
                                  color: MyColor.rightAnswerbgColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const PlayerProfileDetails(),
                        const SizedBox(
                          height: Dimensions.space20,
                        ),
                        Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.space6), color: MyColor.categoryCardBodyColor),
                          padding: const EdgeInsets.symmetric(vertical: Dimensions.space10, horizontal: Dimensions.space14),
                          child: Row(
                            children: [
                              SvgPicture.asset(MyImages.greenTikSvg),
                              const SizedBox(width: Dimensions.space6),
                              Text(
                                "${controller.correctAnswer}/${controller.totalQuestion}",
                                style: regularDefault.copyWith(
                                  color: MyColor.rightAnswerbgColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     RightOrWrongAnsSection(
                //       correctAns: controller.correctAnswer,
                //       wrongAns: controller.wrongAnswer,
                //       totalQuestion: controller.totalQuestion,
                //     ),

                //   ],
                // ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: Dimensions.space20),
                  child: CustomDashedDivider(
                    height: Dimensions.space1,
                    width: double.infinity,
                    strokeWidth: 1,
                  ),
                ),
                const BottomSectionButtons()
              ],
            ),
          ),
        ],
      );
    });
  }
}
