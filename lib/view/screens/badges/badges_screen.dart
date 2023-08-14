import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_images.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/core/utils/style.dart';
import 'package:flutter_prime/view/components/app-bar/custom_category_appBar.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BadgesScreen extends StatefulWidget {
  const BadgesScreen({super.key});

  @override
  State<BadgesScreen> createState() => _BadgesScreenState();
}

class _BadgesScreenState extends State<BadgesScreen> {
  
  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar:const CustomCategoryAppBar(title: MyStrings.badges),
      body: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.height * .01),
        child: GridView.builder(
            shrinkWrap: true,
            gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount:orientation==Orientation.portrait? 3:4,
              childAspectRatio:orientation==Orientation.portrait? .88:1.6
            ),
            itemCount: MyImages().badgesList.length,
            itemBuilder: (BuildContext context, index) {
              return Stack(
                children: [
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(
                      top:orientation!=Orientation.portrait? MediaQuery.of(context).size.height * .05:MediaQuery.of(context).size.height * .028,
                      right: MediaQuery.of(context).size.height * .01,
                      left:orientation!=Orientation.portrait? MediaQuery.of(context).size.height * .025:MediaQuery.of(context).size.height * .01,
                      bottom: MediaQuery.of(context).size.height * .03),
                    padding: EdgeInsets.only(top:orientation!=Orientation.portrait? size.height * .1:size.height * .04,left: Dimensions.space10,right: Dimensions.space10),
                    decoration: BoxDecoration(
                       color: MyColor.colorWhite,
                        borderRadius:BorderRadius.circular(Dimensions.space8)),
                    child: Column(
                      children: [
                        Text(MyStrings().badgeLists[index]['title']!,
                            style: regularDefault.copyWith(
                                color: MyColor.textColor),
                                textAlign: TextAlign.center,
                                ),
                      ],
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                          left:orientation!=Orientation.portrait? MediaQuery.of(context).size.width * .106: MediaQuery.of(context).size.width * .110),
                      child: SvgPicture.asset(
                        MyImages().badgesList[index],
                        height: Dimensions.space45,
                      )),
                     Container(
                       padding: EdgeInsets.only(top:orientation!=Orientation.portrait? Dimensions.space20:Dimensions.space30),
                       height: Dimensions.space100,width: size.width,color: MyStrings().badgeLists[index]['title'] !=MyStrings.supperbattleMan? MyColor.notActivatedFadeColor:MyColor.transparentColor)
                 ],
              );
            }),
      ),
    );
  }
}
