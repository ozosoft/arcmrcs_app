import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/core/utils/style.dart';
import '../../../../core/utils/my_images.dart';

class RankingTabBar extends StatefulWidget {
  const RankingTabBar({super.key});

  @override
  State<RankingTabBar> createState() => _RankingTabBarState();
}

class _RankingTabBarState extends State<RankingTabBar>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;
  int selectedIndex = 1;

  TextEditingController _textEditingController = TextEditingController();
  String _inputText = ""; 
  void initState() {
    tabController = TabController(vsync: this, length: 2);
    setState(() {
      selectedIndex = tabController.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;
    return 
    DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: MyColor.transparentColor,
          appBar: TabBar(
              controller: tabController,
              unselectedLabelColor: MyColor.colorWhite,
              labelStyle: regularMediumLarge,
              indicatorPadding: EdgeInsets.zero,
              indicator:const ShapeDecoration(
                
                  color: MyColor.leaderBoardTabBar,
                  shape: RoundedRectangleBorder(
                      borderRadius:   BorderRadius.all(Radius.circular(Dimensions.space14) )
                          )),
              onTap: (value) {
                setState(() {
                  selectedIndex = tabController.index;
                });
              },
              tabs: const [
                Tab(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(MyStrings.weekly),
                  ),
                ),
                Tab(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(MyStrings.allTimes),
                  ),
                ),
              ]),
          body: TabBarView(controller: tabController, children: [
            Row(
              children: [
                    Padding(
                   padding:  EdgeInsets.only(left:orientation!=Orientation.portrait? size.width*.24:size.width*.12,top:orientation!=Orientation.portrait?size.width*.05:size.width*.1),
                   child: Column(
                   children: [
                     Container(
                     decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color:  MyColor.leaderBoardTabBar,),
                       child: FittedBox(
                              fit: BoxFit.cover,
                              child: Container(
                                margin: EdgeInsets.all( orientation!=Orientation.portrait? Dimensions.space5:Dimensions.space8),
                                decoration: BoxDecoration(
                                  color: MyColor.leaderBoardTabBar,
                                    borderRadius:
                                        BorderRadius.circular(Dimensions.space40),
                                    image: const DecorationImage(
                                        image:AssetImage(MyImages.profileimageWomenPng),
                                        fit: BoxFit.cover)),
                                height:orientation!=Orientation.portrait? Dimensions.space40: Dimensions.space60,
                                width: orientation!=Orientation.portrait? Dimensions.space40: Dimensions.space60,
                              ),
                            ),
                     ),
                     Text(MyStrings.marton,style: regularMediumLarge.copyWith(color: MyColor.colorWhite,)),
                    const SizedBox(height: Dimensions.space5,),
                     Container(
                      decoration:const BoxDecoration(color: MyColor.leaderBoardContainer,borderRadius:BorderRadius.all(Radius.circular(Dimensions.space30))),
                      padding:const EdgeInsets.all(Dimensions.space7),
                      child: Text(MyStrings.qP,style: semiBoldDefault.copyWith(color: MyColor.colorWhite,))),
                   ],
                                ),
                 ),
             
                 Padding(
                   padding:  EdgeInsets.only(left: size.width*.08,top: Dimensions.space10),
                   child: Column(
                   children: [
                     Container(
                     decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color:  MyColor.leaderBoardTabBar,),
                       child: FittedBox(
                              fit: BoxFit.cover,
                              child: Container(
                                margin:const EdgeInsets.all(  Dimensions.space8),
                                decoration: BoxDecoration(
                                  color: MyColor.leaderBoardTabBar,
                                    borderRadius:
                                        BorderRadius.circular(Dimensions.space40),
                                    image: const DecorationImage(
                                        image:AssetImage(MyImages.profileimageWomenPng),
                                        fit: BoxFit.cover)),
                               height:orientation!=Orientation.portrait? Dimensions.space40: Dimensions.space60,
                                width: orientation!=Orientation.portrait? Dimensions.space40: Dimensions.space60,
                              ),
                            ),
                     ),
                     Text(MyStrings.marton,style: regularMediumLarge.copyWith(color: MyColor.colorWhite,)),
                    const SizedBox(height: Dimensions.space5,),
                     Container(
                      decoration:const BoxDecoration(color: MyColor.leaderBoardContainer,borderRadius:BorderRadius.all(Radius.circular(Dimensions.space30))),
                      padding:const EdgeInsets.all(Dimensions.space7),
                      child: Text(MyStrings.qP,style: semiBoldDefault.copyWith(color: MyColor.colorWhite,))),
                   ],
                                ),
                 ),
               
                   Padding(
                   padding:  EdgeInsets.only(left: size.width*.07,top:orientation!=Orientation.portrait? size.width*.07:size.width*.15),
                   child: Column(
                   children: [
                     Container(
                     decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color:  MyColor.leaderBoardTabBar,),
                       child: FittedBox(
                              fit: BoxFit.cover,
                              child: Container(
                                margin:const EdgeInsets.all(  Dimensions.space8),
                                decoration: BoxDecoration(
                                  color: MyColor.leaderBoardTabBar,
                                    borderRadius:
                                        BorderRadius.circular(Dimensions.space40),
                                    image: const DecorationImage(
                                        image:AssetImage(MyImages.profileimageWomenPng),
                                        fit: BoxFit.cover)),
                              height:orientation!=Orientation.portrait? Dimensions.space40: Dimensions.space60,
                                width: orientation!=Orientation.portrait? Dimensions.space40: Dimensions.space60,
                              ),
                            ),
                     ),
                     Text(MyStrings.marton,style: regularMediumLarge.copyWith(color: MyColor.colorWhite,)),
                    const SizedBox(height: Dimensions.space5,),
                     Container(
                      decoration:const BoxDecoration(color: MyColor.leaderBoardContainer,borderRadius:BorderRadius.all(Radius.circular(Dimensions.space30))),
                      padding:const EdgeInsets.all(Dimensions.space7),
                      child: Text(MyStrings.qP,style: semiBoldDefault.copyWith(color: MyColor.colorWhite,))),
                   ],
                                ),
                 ),
             
               ],
            ),
             Row(
              children: [
                    Padding(
                   padding:  EdgeInsets.only(left:orientation!=Orientation.portrait? size.width*.24:size.width*.12,top:orientation!=Orientation.portrait?size.width*.05:size.width*.1),
                   child: Column(
                   children: [
                     Container(
                     decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color:  MyColor.leaderBoardTabBar,),
                       child: FittedBox(
                              fit: BoxFit.cover,
                              child: Container(
                                margin: EdgeInsets.all( orientation!=Orientation.portrait? Dimensions.space5:Dimensions.space8),
                                decoration: BoxDecoration(
                                  color: MyColor.leaderBoardTabBar,
                                    borderRadius:
                                        BorderRadius.circular(Dimensions.space40),
                                    image: const DecorationImage(
                                        image:AssetImage(MyImages.profileimageWomenPng),
                                        fit: BoxFit.cover)),
                                height:orientation!=Orientation.portrait? Dimensions.space40: Dimensions.space60,
                                width: orientation!=Orientation.portrait? Dimensions.space40: Dimensions.space60,
                              ),
                            ),
                     ),
                     Text(MyStrings.marton,style: regularMediumLarge.copyWith(color: MyColor.colorWhite,)),
                    const SizedBox(height: Dimensions.space5,),
                     Container(
                      decoration:const BoxDecoration(color: MyColor.leaderBoardContainer,borderRadius:BorderRadius.all(Radius.circular(Dimensions.space30))),
                      padding:const EdgeInsets.all(Dimensions.space7),
                      child: Text(MyStrings.qP,style: semiBoldDefault.copyWith(color: MyColor.colorWhite,))),
                   ],
                                ),
                 ),
             
                 Padding(
                   padding:  EdgeInsets.only(left: size.width*.08,top: Dimensions.space10),
                   child: Column(
                   children: [
                     Container(
                     decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color:  MyColor.leaderBoardTabBar,),
                       child: FittedBox(
                              fit: BoxFit.cover,
                              child: Container(
                                margin:const EdgeInsets.all(  Dimensions.space8),
                                decoration: BoxDecoration(
                                  color: MyColor.leaderBoardTabBar,
                                    borderRadius:
                                        BorderRadius.circular(Dimensions.space40),
                                    image: const DecorationImage(
                                        image:AssetImage(MyImages.profileimageWomenPng),
                                        fit: BoxFit.cover)),
                               height:orientation!=Orientation.portrait? Dimensions.space40: Dimensions.space60,
                                width: orientation!=Orientation.portrait? Dimensions.space40: Dimensions.space60,
                              ),
                            ),
                     ),
                     Text(MyStrings.marton,style: regularMediumLarge.copyWith(color: MyColor.colorWhite,)),
                    const SizedBox(height: Dimensions.space5,),
                     Container(
                      decoration:const BoxDecoration(color: MyColor.leaderBoardContainer,borderRadius:BorderRadius.all(Radius.circular(Dimensions.space30))),
                      padding:const EdgeInsets.all(Dimensions.space7),
                      child: Text(MyStrings.qP,style: semiBoldDefault.copyWith(color: MyColor.colorWhite,))),
                   ],
                                ),
                 ),
               
                   Padding(
                   padding:  EdgeInsets.only(left: size.width*.07,top:orientation!=Orientation.portrait? size.width*.07:size.width*.15),
                   child: Column(
                   children: [
                     Container(
                     decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color:  MyColor.leaderBoardTabBar,),
                       child: FittedBox(
                              fit: BoxFit.cover,
                              child: Container(
                                margin:const EdgeInsets.all(  Dimensions.space8),
                                decoration: BoxDecoration(
                                  color: MyColor.leaderBoardTabBar,
                                    borderRadius:
                                        BorderRadius.circular(Dimensions.space40),
                                    image: const DecorationImage(
                                        image:AssetImage(MyImages.profileimageWomenPng),
                                        fit: BoxFit.cover)),
                              height:orientation!=Orientation.portrait? Dimensions.space40: Dimensions.space60,
                                width: orientation!=Orientation.portrait? Dimensions.space40: Dimensions.space60,
                              ),
                            ),
                     ),
                     Text(MyStrings.marton,style: regularMediumLarge.copyWith(color: MyColor.colorWhite,)),
                    const SizedBox(height: Dimensions.space5,),
                     Container(
                      decoration:const BoxDecoration(color: MyColor.leaderBoardContainer,borderRadius:BorderRadius.all(Radius.circular(Dimensions.space30))),
                      padding:const EdgeInsets.all(Dimensions.space7),
                      child: Text(MyStrings.qP,style: semiBoldDefault.copyWith(color: MyColor.colorWhite,))),
                   ],
                                ),
                 ),
             
               ],
            ),
            
          ]),
        ));
  }
}
