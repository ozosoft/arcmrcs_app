import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/core/utils/style.dart';
import 'package:flutter_prime/core/utils/url_container.dart';
import 'package:flutter_prime/data/controller/leader_board/leader_board_controller.dart';

import 'package:get/get.dart';
import '../../../../core/utils/my_images.dart';

class RankingTabBar extends StatefulWidget {
  const RankingTabBar({super.key});

  @override
  State<RankingTabBar> createState() => _RankingTabBarState();
}

class _RankingTabBarState extends State<RankingTabBar> with SingleTickerProviderStateMixin {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;
    return SizedBox(
    child: GetBuilder<LeaderBoardController>(
      builder: (controller) =>  Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: Padding(
            padding:  EdgeInsets.only(top:orientation!=Orientation.portrait?size.width*.05:size.width*.1),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color:  MyColor.leaderBoardTabBar),
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: controller.rank2PlayerAvatar != ""? Container(
                      margin: EdgeInsets.all( orientation!=Orientation.portrait? Dimensions.space5:Dimensions.space8),
                      decoration: BoxDecoration(
                          color: MyColor.leaderBoardTabBar,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image:NetworkImage(UrlContainer.leaderboardProfileImage+controller.rank2PlayerAvatar.toString()),
                              fit: BoxFit.cover)),
                      height:orientation!=Orientation.portrait? Dimensions.space40: Dimensions.space60,
                      width: orientation!=Orientation.portrait? Dimensions.space40: Dimensions.space60,
                    ):Image.asset(MyImages.defaultAvatar,height: Dimensions.space70),
                  ),
                ),
                Text(MyStrings.at+ controller.rank2PlayerName,style: regularMediumLarge.copyWith(color: MyColor.colorWhite,)),
                const SizedBox(height: Dimensions.space5,),
                Container(
                    decoration:const BoxDecoration(color: MyColor.leaderBoardContainer,borderRadius:BorderRadius.all(Radius.circular(Dimensions.space30))),
                    padding:const EdgeInsets.all(Dimensions.space7),
                    child: Text(MyStrings.qP+controller.rank2PlayerScore,style: semiBoldDefault.copyWith(color: MyColor.colorWhite,))),
              ],
            ),
          )),

          Expanded(
            child: Padding(
              padding:  EdgeInsets.only(left: size.width*.05,top: Dimensions.space10,right:size.width*.05),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color:  MyColor.leaderBoardTabBar,),
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: controller.rank1PlayerAvatar != ""? Container(
                        margin: EdgeInsets.all( orientation!=Orientation.portrait? Dimensions.space5:Dimensions.space8),
                        decoration: BoxDecoration(
                          color: MyColor.leaderBoardTabBar,
                          borderRadius:
                          BorderRadius.circular(Dimensions.space40),
                          image: DecorationImage(
                            image:NetworkImage(UrlContainer.leaderboardProfileImage+controller.rank1PlayerAvatar.toString()),
                            fit: BoxFit.cover
                          )
                        ),
                        height:orientation!=Orientation.portrait? Dimensions.space40: Dimensions.space60,
                        width: orientation!=Orientation.portrait? Dimensions.space40: Dimensions.space60,
                      ):Image.asset(MyImages.defaultAvatar,height: Dimensions.space60,),
                    ),
                  ),
                  Text(MyStrings.at+ controller.rank1PlayerName,maxLines:1,style: regularMediumLarge.copyWith(color: MyColor.colorWhite,)),
                  const SizedBox(height: Dimensions.space5),
                  Container(
                      decoration:const BoxDecoration(color: MyColor.leaderBoardContainer,borderRadius:BorderRadius.all(Radius.circular(Dimensions.space30))),
                      padding:const EdgeInsets.all(Dimensions.space7),
                      child: Text(MyStrings.qP +controller.rank1PlayerScore,style: semiBoldDefault.copyWith(color: MyColor.colorWhite))),
                ],
              ),
            ),
          ),

          Expanded(
            child: Padding(
              padding:  EdgeInsets.only(top:orientation!=Orientation.portrait? size.width*.07:size.width*.15),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color:  MyColor.leaderBoardTabBar,),
                    child:FittedBox(
                      fit: BoxFit.cover,
                      child: controller.rank3PlayerAvatar.toString() != ""? Container(
                        margin: EdgeInsets.all( orientation!=Orientation.portrait? Dimensions.space5:Dimensions.space8),
                        decoration: BoxDecoration(
                            color: MyColor.leaderBoardTabBar,
                            borderRadius:BorderRadius.circular(Dimensions.space40),
                            image: DecorationImage(
                                image:NetworkImage(UrlContainer.leaderboardProfileImage+controller.rank3PlayerAvatar.toString()),
                                fit: BoxFit.cover)),
                        height:orientation!=Orientation.portrait? Dimensions.space40: Dimensions.space60,
                        width: orientation!=Orientation.portrait? Dimensions.space40: Dimensions.space60,
                      ):Image.asset(MyImages.defaultAvatar,height: Dimensions.space60,),
                    ),
                  ),
                  Text(MyStrings.at+ controller.rank3PlayerName,overflow:TextOverflow.ellipsis,style: regularMediumLarge.copyWith(color: MyColor.colorWhite)),
                  const SizedBox(height: Dimensions.space5),
                  Container(
                    decoration:const BoxDecoration(color: MyColor.leaderBoardContainer,borderRadius:BorderRadius.all(Radius.circular(Dimensions.space30))),
                    padding:const EdgeInsets.all(Dimensions.space7),
                    child: Text(MyStrings.qP+controller.rank3PlayerScore,style: semiBoldDefault.copyWith(color: MyColor.colorWhite,))
                  ),
                ],
              ),
            ),
          ),

        ],
      )
    ));
  }
}
