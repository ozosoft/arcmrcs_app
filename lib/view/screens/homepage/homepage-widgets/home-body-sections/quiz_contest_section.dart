import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_images.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../core/utils/dimensions.dart';
import '../../../../../core/utils/my_strings.dart';
import '../../../../../core/utils/style.dart';

class QuizContestSection extends StatefulWidget {
  const QuizContestSection({super.key});

  @override
  State<QuizContestSection> createState() => _QuizContestSectionState();
}

class _QuizContestSectionState extends State<QuizContestSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(
              bottom: Dimensions.space3,
              left: Dimensions.space4,
              right: Dimensions.space4,
              top: Dimensions.space17),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                MyStrings.quizContest,
                style: semiBoldMediumLarge,
              ),
              Text(
                MyStrings.viewAll,
                style: semiBoldLarge.copyWith(
                    color: MyColor.colorlighterGrey,
                    fontSize: Dimensions.space15),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: Dimensions.space8,
        ),
        SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              child: Row(
                children: List.generate(
                    5,
                    (index) => Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: Dimensions.space5),
                          padding: const EdgeInsets.all(Dimensions.space12),
                          decoration: BoxDecoration(
                            color: MyColor.colorWhite,
                            borderRadius:
                                BorderRadius.circular(Dimensions.defaultRadius),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromARGB(61, 158, 158, 158),
                                blurRadius: 7,
                                spreadRadius: .5,
                                offset: Offset(
                                  .4,
                                  .4,
                                ),
                              )
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(
                                        top: Dimensions.space7,
                                        right: Dimensions.space12),
                                    height: Dimensions.space70,
                                    width: Dimensions.space50,
                                    child: Align(
                                      alignment: Alignment.topCenter,
                                      child: SvgPicture.asset(
                                          MyImages.healthQuizContestSVG),
                                    ),
                                  ),
                                  Container(
                                    // height: Dimensions.space70,
                                    // width: Dimensions.space220,
                                    padding: const EdgeInsets.only(
                                        bottom: Dimensions.space20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Text(
                                          MyStrings.healthAndQuiz,
                                          style: semiBoldMediumLarge,
                                        ),
                                        const SizedBox(
                                            height: Dimensions.space8),
                                        Text(
                                          MyStrings.healthAndQuizdescription
                                              .substring(0, 30),
                                          style: regularDefault.copyWith(
                                              color: MyColor.colorlighterGrey),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(
                                        top: Dimensions.space7),
                                    margin: const EdgeInsets.only(
                                        left: Dimensions.space50),
                                    height: Dimensions.space70,
                                    width: Dimensions.space50,
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: SvgPicture.asset(
                                        MyImages.bookmarkSVG,
                                        height: Dimensions.space27,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                height: 0.1,
                                color: MyColor.colorlighterGrey,
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                    top: Dimensions.space10,
                                    left: Dimensions.space10),
                                width: Dimensions.space330,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(
                                          Dimensions.space5),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: MyColor.cardColor,
                                            border: Border.all(
                                                color: MyColor.colorlighterGrey,
                                                width: 0.3)),
                                        padding: const EdgeInsets.all(
                                            Dimensions.space7),
                                        child: Center(
                                            child: Text(
                                          MyStrings.fee50Coins,
                                          style: regularDefault.copyWith(
                                              color: MyColor.colorGrey),
                                        )),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(
                                          Dimensions.space5),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: MyColor.cardColor,
                                            border: Border.all(
                                                color: MyColor.colorDarkGrey,
                                                width: 0.3)),
                                        padding: const EdgeInsets.all(
                                            Dimensions.space7),
                                        child: Center(
                                            child: Text(MyStrings.endDate,
                                                style: regularDefault.copyWith(
                                                    color: MyColor.colorGrey))),
                                      ),
                                    ),
                                    const Spacer(),
                                    Center(
                                        child: SvgPicture.asset(
                                            MyImages.playNowSVG))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )),
              )),
        ),
      ],
    );
  }
}
