import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_images.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/core/utils/style.dart';
import 'package:flutter_prime/view/screens/1vs1/appbar-components/one_vs_one_card.dart';
import 'package:flutter_prime/view/screens/1vs1/appbar-components/custom_one_vs_one_battele_appBar.dart';
import 'package:flutter_svg/svg.dart';

class CustomSliverDelegates extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final bool hideTitleWhenExpanded;
  final bool isGroupBattle;
  CustomSliverDelegates({
    required this.expandedHeight,
    this.hideTitleWhenExpanded = true,
    this.isGroupBattle=false, 
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final appBarSize = expandedHeight - shrinkOffset;
    final cardTopPosition = expandedHeight / 2 - shrinkOffset;
    final proportion = 2 - (expandedHeight / appBarSize);
    final percent = proportion < 0 || proportion > 1 ? 0.0 : proportion;
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(Dimensions.space20))),
      height: expandedHeight + expandedHeight / 2,
      child: Stack(
        children: [
          CustomOneVSOneAppBar(appbarSize: appBarSize,isGroupBattle: isGroupBattle),
          Padding(
            padding: const EdgeInsets.only(right: Dimensions.space30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(Dimensions.space5),
                  margin: const EdgeInsets.only(top: Dimensions.space55),
                  height: Dimensions.space60,
                  width: Dimensions.space60,
                  decoration: BoxDecoration(
                      color: MyColor.prifileBG,
                      borderRadius: BorderRadius.circular(Dimensions.space30)),
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.space40),
                          image: const DecorationImage(
                              image: AssetImage(MyImages.profileimageWomenPng),
                              fit: BoxFit.cover)),
                      height: Dimensions.space70,
                      width: Dimensions.space70,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: Dimensions.space55),
                  padding: const EdgeInsets.all(Dimensions.space10),
                  child: Text(
                    MyStrings.versus,
                    style:
                        semiBoldExtraLarge.copyWith(color: MyColor.colorWhite),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: Dimensions.space55),
                  padding: const EdgeInsets.all(Dimensions.space5),
                  height: Dimensions.space60,
                  width: Dimensions.space60,
                  decoration: BoxDecoration(
                      color: MyColor.prifileBG,
                      borderRadius: BorderRadius.circular(30)),
                  child: SvgPicture.asset(MyImages.player2),
                ),
              ],
            ),
          ),
          Positioned(
            left: 0.0,
            right: 0.0,
            top: cardTopPosition > 0 ? cardTopPosition : 0,
            bottom: 0.0,
            child: Opacity(
              opacity: percent,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.space20 * percent,
                    vertical: Dimensions.space45 * percent),
                child: const OneVSOneCustomCardWidget(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => expandedHeight + expandedHeight / 2;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
