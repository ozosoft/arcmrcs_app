import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quiz_lab/core/helper/ads/admob_helper.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';
import 'package:quiz_lab/core/utils/my_color.dart';
import 'package:quiz_lab/core/utils/my_images.dart';
import 'package:quiz_lab/core/utils/style.dart';
import 'package:quiz_lab/view/components/app-bar/custom_appbar.dart';
import 'package:quiz_lab/view/components/card/custom_card.dart';

class EarnRewardScreen extends StatefulWidget {
  const EarnRewardScreen({super.key});

  @override
  State<EarnRewardScreen> createState() => _EarnRewardScreenState();
}

class _EarnRewardScreenState extends State<EarnRewardScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: ""),
      body: Column(
       
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: 5,
            itemBuilder: (BuildContext context, int index) {
            return  Padding(
              padding: const EdgeInsets.all(Dimensions.space8),
              child: CustomCard(
                
                  width: double.infinity,
                  child: Row(
                   
                    children: [
                     const CircleAvatar(),
                    const  SizedBox(width: Dimensions.space10),
                    const  Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                        children: [Text("Daily Ad 1"),Text("expired in :1 hour")],),
                          const Spacer(),
                          Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                        children: [Row(children: [SvgPicture.asset(MyImages.coin),const Text("10")],),
                        const SizedBox(height:Dimensions.space5),
                        InkWell(
                          onTap: () {
                             AdmobHelper().loadRewardAdAlways();
                          },
                          child: Container(
                            padding:const EdgeInsets.symmetric(horizontal: Dimensions.space10,vertical: Dimensions.space3),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.space5),color: MyColor.primaryColor),
                            child: Text("Play",style: regularDefault.copyWith(color: MyColor.colorWhite,)),),
                        )
                        
                        ],),
                    ],
                  )),
            );
          })
        ],
      ),
    );
  }
}
