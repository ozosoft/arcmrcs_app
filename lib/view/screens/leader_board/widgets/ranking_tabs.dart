import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/core/utils/style.dart';
import 'package:flutter_prime/core/utils/url_container.dart';
import 'package:flutter_prime/data/controller/leader_board/leader_board_controller.dart';
import 'package:flutter_prime/view/components/image_widget/my_image_widget.dart';
import 'package:get/get.dart';

import '../../../../core/utils/my_images.dart';

class RankingTabBar extends StatefulWidget {
  const RankingTabBar({Key? key}) : super(key: key);

  @override
  State<RankingTabBar> createState() => _RankingTabBarState();
}

class _RankingTabBarState extends State<RankingTabBar> {
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
        builder: (controller) => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildRankingItem(
              controller.rank2PlayerAvatar,
              controller.rank2PlayerName,
              controller.rank2PlayerScore,
              size,
              orientation,
              2, // Player 2
            ),
            _buildRankingItem(
              controller.rank1PlayerAvatar,
              controller.rank1PlayerName,
              controller.rank1PlayerScore,
              size,
              orientation,
              1, // Player 1
            ),
            _buildRankingItem(
              controller.rank3PlayerAvatar,
              controller.rank3PlayerName,
              controller.rank3PlayerScore,
              size,
              orientation,
              3, // Player 3
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRankingItem(
    String playerAvatar,
    String playerName,
    String playerScore,
    Size size,
    Orientation orientation,
    int rank,
  ) {
    double topPadding = 0.0;

    if (rank == 1) {
      topPadding = size.width * 0;
    } else if (rank == 2) {
      topPadding = size.width * 0.1;
    } else if (rank == 3) {
       topPadding = size.width * 0.1;
    }

    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(top: topPadding, left: Dimensions.space10, right: Dimensions.space10),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: MyColor.leaderBoardTabBar,
              ),
              child: FittedBox(
                fit: BoxFit.cover,
                child: playerAvatar.isNotEmpty
                    ? Container(
                        margin: EdgeInsets.all(
                          orientation != Orientation.portrait ? Dimensions.space10 : Dimensions.space8,
                        ),
                        decoration: const BoxDecoration(
                          color: MyColor.leaderBoardTabBar,
                          shape: BoxShape.circle,
                        ),
                        height: orientation != Orientation.portrait ? Dimensions.space60 : Dimensions.space60,
                        width: orientation != Orientation.portrait ? Dimensions.space60 : Dimensions.space60,
                        child: MyImageWidget(radius: Dimensions.space100, imageUrl: UrlContainer.leaderboardProfileImage + playerAvatar),
                      )
                    : Container(
                        margin: EdgeInsets.all(
                          orientation != Orientation.portrait ? Dimensions.space10 : Dimensions.space8,
                        ),
                        decoration: const BoxDecoration(
                          color: MyColor.leaderBoardTabBar,
                          shape: BoxShape.circle,
                        ),
                        height: orientation != Orientation.portrait ? Dimensions.space60 : Dimensions.space60,
                        width: orientation != Orientation.portrait ? Dimensions.space60 : Dimensions.space60,
                        child: Image.asset(MyImages.defaultAvatar),
                      ),
              ),
            ),
            const SizedBox(
              height: Dimensions.space10,
            ),
            FittedBox(
              child: Text(
                MyStrings.at + playerName,
                style: regularMediumLarge.copyWith(
                  color: MyColor.colorWhite,
                ),
              ),
            ),
            const SizedBox(
              height: Dimensions.space10,
            ),
            Container(
              decoration: const BoxDecoration(
                color: MyColor.leaderBoardContainer,
                borderRadius: BorderRadius.all(Radius.circular(Dimensions.space30)),
              ),
              padding: const EdgeInsets.all(Dimensions.space7),
              child: Text(
                "$playerScore ${MyStrings.qP.tr}",
                style: semiBoldDefault.copyWith(
                  color: MyColor.colorWhite,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
