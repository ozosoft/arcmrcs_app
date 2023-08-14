import 'package:flutter/material.dart';
import 'package:flutter_prime/core/route/route.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_images.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/core/utils/style.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ProfileOverAllAchivementSection extends StatefulWidget {
  const ProfileOverAllAchivementSection({super.key});

  @override
  State<ProfileOverAllAchivementSection> createState() =>
      _ProfileOverAllAchivementSectionState();
}

class _ProfileOverAllAchivementSectionState
    extends State<ProfileOverAllAchivementSection> {
  bool _showNotch = false;

  void _toggleNotch() {
    setState(() {
      _showNotch = !_showNotch;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
Orientation orientation = MediaQuery.of(context).orientation;
    print(size.width);

    return Padding(
      padding: const EdgeInsets.only(
          top: Dimensions.space40,
          right: Dimensions.space18,
          left: Dimensions.space18),
      child: Container(
        padding: const EdgeInsets.all(Dimensions.space15),
        decoration: BoxDecoration(
            color: MyColor.colorWhite,
            borderRadius: BorderRadius.circular(Dimensions.space10)),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    FittedBox(
                      fit: BoxFit.cover,
                      child: Container(
                        margin: const EdgeInsets.only(top: Dimensions.space20),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.space40),
                            image: const DecorationImage(
                                image:
                                    AssetImage(MyImages.profileimageWomenPng),
                                fit: BoxFit.cover)),
                        height: Dimensions.space70,
                        width: Dimensions.space70,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                          top: Dimensions.space70,
                          right: 0,
                          bottom: 0,
                          left: Dimensions.space45),
                      child: InkWell(
                        onTap: () {
                          Get.toNamed(RouteHelper.profileEditScreen);
                        },
                        child: SvgPicture.asset(
                          MyImages.cameraSVG,
                        ),
                      ),
                    ),
                  ],
                ),
                const Text(
                  MyStrings.hiMariya,
                  style: semiBoldExtraLarge,
                ),
                const SizedBox(
                  height: Dimensions.space10,
                ),
                GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: orientation==Orientation.portrait? .9 : 2,
                        crossAxisSpacing: Dimensions.space14),
                    itemCount: MyStrings().achivements.length,
                    itemBuilder: (BuildContext context, index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: Container(
                            decoration: BoxDecoration(
                                color: MyColor.lobbycardColor,
                                border: Border.all(
                                  color: MyColor.cardBorderColors,
                                ),
                                borderRadius:
                                    BorderRadius.circular(Dimensions.space10)),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: Dimensions.space10),
                                  child: SvgPicture.asset(MyImages()
                                      .achivementsType[index]
                                      .toString()),
                                ),
                                Text(
                                  MyStrings().achivements[index].title,
                                  style: semiBoldMediumLarge.copyWith(
                                      color: MyColor.primaryColor,
                                      fontWeight: FontWeight.w500),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: Dimensions.space5),
                                  child: Text(
                                    MyStrings().achivements[index].points,
                                    style: regularMediumLarge,
                                  ),
                                ),
                              ],
                            ),
                          )),
                        ],
                      );
                    }),
                const SizedBox(
                  height: Dimensions.space15,
                ),
                const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      MyStrings.yourBadges,
                      style: semiBoldMediumLarge,
                    )),
                const SizedBox(
                  height: Dimensions.space5,
                ),
                GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                         SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: orientation==Orientation.portrait? 1.5:.08,
                            crossAxisSpacing: Dimensions.space12),
                    itemCount: MyStrings().achivements.length,
                    itemBuilder: (BuildContext context, index) {
                      return Stack(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                              top: Dimensions.space20,
                            ),
                            padding: EdgeInsets.only(top: size.height * .025),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: MyColor.lobbycardColor,
                                border: Border.all(
                                  color: MyColor.cardBorderColors,
                                ),
                                borderRadius:
                                    BorderRadius.circular(Dimensions.space8)),
                            child: Column(
                              children: [
                                Text(MyStrings().badgeList[index]['title']!,
                                    style: regularLarge.copyWith(
                                        color: MyColor.textColor)),
                                Text(
                                  MyStrings().badgeList[index]['description']!,
                                  style: regularLarge.copyWith(
                                      color: MyColor.textColor),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: size.width * .09),
                            child: SvgPicture.asset(
                              alignment: Alignment.center,
                              MyImages().badges[index],
                              height: Dimensions.space33,
                            ),
                          ),
                        ],
                      );
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
