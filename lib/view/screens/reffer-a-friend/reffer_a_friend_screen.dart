import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';
import 'package:quiz_lab/core/utils/my_color.dart';
import 'package:quiz_lab/core/utils/my_images.dart';
import 'package:quiz_lab/core/utils/style.dart';
import 'package:quiz_lab/view/components/app-bar/custom_appbar.dart';
import 'package:quiz_lab/view/components/card/custom_card.dart';
import 'package:quiz_lab/view/screens/reffer-a-friend/widgets/refferal_code_section.dart';
import 'package:quiz_lab/view/screens/reffer-a-friend/widgets/top_section.dart';

class RefferAFriendScreen extends StatefulWidget {
  const RefferAFriendScreen({super.key});

  @override
  State<RefferAFriendScreen> createState() => _RefferAFriendScreenState();
}

class _RefferAFriendScreenState extends State<RefferAFriendScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "",
        bgColor: MyColor.primaryColor,
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
       
       const TopSection(),
        const SizedBox(
          height: Dimensions.space30,
        ),
        const RefferalCodeSection(),
        Flexible(
          child: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(Dimensions.space8),
                child: CustomCard(
                  width: double.infinity,
                  child: Row(
                    children: [
                      CircleAvatar(
                        child: Image.asset(MyImages.person),
                      ),
                      const SizedBox(width: Dimensions.space10),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Name: Sania Khan", style: semiBoldLarge),
                          Text("#EKREF3123"),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        )
      ]),
    );
  }
}
