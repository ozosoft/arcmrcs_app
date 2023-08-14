import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_images.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/core/utils/style.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/utils/my_color.dart';
import 'ranking_tabs.dart';

class BackGroundWithRankCard extends StatefulWidget {
  const BackGroundWithRankCard({super.key});

  @override
  State<BackGroundWithRankCard> createState() => _BackGroundWithRankCardState();
}

class _BackGroundWithRankCardState extends State<BackGroundWithRankCard>
    with SingleTickerProviderStateMixin {
  bool showQuestions = false;
  bool audienceVote = false;
  bool tapAnswer = false;

  late final TabController tabController;
  int selectedIndex = 1;
  void initState() {
    tabController = TabController(vsync: this, length: 2);
    setState(() {
      selectedIndex = tabController.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        SvgPicture.asset(MyImages.leaderBoardSVG, fit: BoxFit.cover),
        const Padding(
          padding: EdgeInsets.all(Dimensions.space10),
          child: SizedBox(
            height: Dimensions.space300,
            child: RankingTabBar(),
          ),
        ),
        Padding(
          padding:
              EdgeInsets.only(top: size.height * .33, left: size.width * .13),
          child: SvgPicture.asset(
            MyImages.leaderBoardRankSVG,
          ),
        ),
        Container(
          margin: EdgeInsets.only(
              top: size.height * .45,
              left: Dimensions.space20,
              right: Dimensions.space20),
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.space20),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.space20),
                  topRight: Radius.circular(Dimensions.space20)),
              color: MyColor.colorWhite),
          child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: MyImages().avatars.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                    margin: const EdgeInsets.all(Dimensions.space10),
                    child: Padding(
                      padding: const EdgeInsets.all(Dimensions.space12),
                      child: Row(
                        children: [
                          SvgPicture.asset(MyImages().avatars[index]),
                          const SizedBox(
                            width: Dimensions.space10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                MyStrings.jkobos,
                                style: semiBoldMediumLarge,
                              ),
                              const SizedBox(height: Dimensions.space5),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                      MyImages().flagImages[index]),
                                  const SizedBox(
                                    width: Dimensions.space8,
                                  ),
                                  Text(
                                    MyStrings.points,
                                    style: semiBoldLarge.copyWith(
                                        color: MyColor.textColor),
                                  ),
                                  SvgPicture.asset(MyImages().arrows[index]),
                                  const SizedBox(
                                    width: Dimensions.space8,
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ));
              }),
        ),
      ],
    );
  }
}
