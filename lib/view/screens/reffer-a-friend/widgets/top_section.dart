import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';
import 'package:quiz_lab/core/utils/my_color.dart';
import 'package:quiz_lab/core/utils/my_images.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/core/utils/style.dart';

class TopSection extends StatefulWidget {
  const TopSection({super.key});

  @override
  State<TopSection> createState() => _TopSectionState();
}

class _TopSectionState extends State<TopSection> {
  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
         Container(
            width: double.infinity,
            decoration: const BoxDecoration(color: MyColor.primaryColor),
            child: Column(children: [
              Text(MyStrings.youWillGet, style: regularDefault.copyWith(color: MyColor.lightGray)),
              Text(
                MyStrings.refferalAmount,
                style: semiBoldExtraLarge.copyWith(color: MyColor.lightGray),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(Dimensions.space8),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(Dimensions.space6),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: const CircleAvatar(
                            backgroundImage: AssetImage(
                              MyImages.reffer,
                            ),
                            maxRadius: Dimensions.space35,
                            backgroundColor: MyColor.lightprimaryColor,
                          ),
                        )
                      ],
                    ),
                  ),
                  Image.asset(
                    MyImages.arrowNext,
                    color: MyColor.colorWhite,
                    height: Dimensions.space20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(Dimensions.space8),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(Dimensions.space6),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: const CircleAvatar(
                            backgroundImage: AssetImage(
                              MyImages.done,
                            ),
                            maxRadius: Dimensions.space35,
                            backgroundColor: MyColor.lightprimaryColor,
                          ),
                        )
                      ],
                    ),
                  ),
                  Image.asset(
                    MyImages.arrowNext,
                    color: MyColor.colorWhite,
                    height: Dimensions.space20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(Dimensions.space6),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(Dimensions.space8),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: const CircleAvatar(
                            backgroundImage: AssetImage(
                              MyImages.coinEarned,
                            ),
                            maxRadius: Dimensions.space35,
                            backgroundColor: MyColor.lightprimaryColor,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )
            ])),
        
      ],
    );
  }
}