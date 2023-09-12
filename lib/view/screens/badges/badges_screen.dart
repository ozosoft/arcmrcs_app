import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_images.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/core/utils/style.dart';
import 'package:flutter_prime/view/components/app-bar/custom_category_appBar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class BadgesScreen extends StatefulWidget {
  const BadgesScreen({super.key});

  @override
  State<BadgesScreen> createState() => _BadgesScreenState();
}

class _BadgesScreenState extends State<BadgesScreen> {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> badgeLists = [
      {
        'title': MyStrings.supperbattleMan,
      },
      {
        'title': MyStrings.quizerMaster,
      },
      {
        'title': MyStrings.goldenquizMan,
      },
      {
        'title': MyStrings.battleMaster,
      },
      {
        'title': MyStrings.perfectQuizMan,
      },
      {
        'title': MyStrings.ultimatePlayer,
      },
    ];
    Orientation orientation = MediaQuery.of(context).orientation;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomCategoryAppBar(title: MyStrings.badges.tr),
      body: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.height * .01),
        child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: orientation == Orientation.portrait ? 3 : 4, childAspectRatio: orientation == Orientation.portrait ? .88 : 1.6),
            itemCount: MyImages().badgesList.length,
            itemBuilder: (BuildContext context, index) {
              return Stack(
                children: [
                  Container(
                    width: double.infinity,
                    margin:
                        EdgeInsetsDirectional.only(top: orientation != Orientation.portrait ? MediaQuery.of(context).size.height * .05 : MediaQuery.of(context).size.height * .028, end: MediaQuery.of(context).size.height * .01, start: orientation != Orientation.portrait ? MediaQuery.of(context).size.height * .025 : MediaQuery.of(context).size.height * .01, bottom: MediaQuery.of(context).size.height * .03),
                    padding: EdgeInsetsDirectional.only(top: orientation != Orientation.portrait ? size.height * .1 : size.height * .04, start: Dimensions.space10, end: Dimensions.space10),
                    decoration: BoxDecoration(color: MyColor.colorWhite, borderRadius: BorderRadius.circular(Dimensions.space8)),
                    child: Column(
                      children: [
                        Text(
                          badgeLists[index]['title']!,
                          style: regularDefault.copyWith(color: MyColor.textColor),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                      padding: EdgeInsetsDirectional.only(start: orientation != Orientation.portrait ? MediaQuery.of(context).size.width * .106 : MediaQuery.of(context).size.width * .110),
                      child: SvgPicture.asset(
                        MyImages().badgesList[index],
                        height: Dimensions.space45,
                      )),
                  Container(padding: EdgeInsetsDirectional.only(top: orientation != Orientation.portrait ? Dimensions.space20 : Dimensions.space30), height: Dimensions.space100, width: size.width, color: badgeLists[index]['title'] != MyStrings.supperbattleMan ? MyColor.notActivatedFadeColor : MyColor.transparentColor)
                ],
              );
            }),
      ),
    );
  }
}
