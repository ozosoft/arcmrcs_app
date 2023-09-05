import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_images.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/core/utils/style.dart';
import 'package:flutter_prime/core/utils/url_container.dart';
import 'package:flutter_prime/data/controller/leader_board/leader_board_controller.dart';
import 'package:flutter_prime/data/repo/leaderBoard/leaderBoard_repo.dart';
import 'package:flutter_prime/data/services/api_service.dart';
import 'package:flutter_prime/view/components/custom_loader/custom_loader.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../core/utils/my_color.dart';
import 'ranking_tabs.dart';

class BackGroundWithRankCard extends StatefulWidget {
  const BackGroundWithRankCard({super.key});

  @override
  State<BackGroundWithRankCard> createState() => _BackGroundWithRankCardState();
}

class _BackGroundWithRankCardState extends State<BackGroundWithRankCard> with SingleTickerProviderStateMixin {


  @override
  void initState() {

    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(LeaderBoardRepo(apiClient: Get.find()));
    LeaderBoardController controller = Get.put(LeaderBoardController(leaderBoardRepo: Get.find()));

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    Size size = MediaQuery.of(context).size;
    return GetBuilder<LeaderBoardController>(
      builder: (controller) => Column(
        children: [

          const Padding(
            padding: EdgeInsets.all(Dimensions.space10),
            child: SizedBox(
              child: RankingTabBar(),
            ),
          ),

          const SizedBox(height: Dimensions.space15),

          SvgPicture.asset(
            MyImages.leaderBoardRankSVG,
            width: orientation != Orientation.portrait ? size.width * .5 : size.width * .7,
          ),
          const SizedBox(height: Dimensions.space20),
          controller.isLoading
              ? const CustomLoader(isPagination: true)
              : Container(
                  margin: const EdgeInsets.only(left: Dimensions.space20, right: Dimensions.space20),
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.space20),
            decoration: const BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(Dimensions.space20), topRight: Radius.circular(Dimensions.space20)), color: MyColor.colorWhite),
                  child: ListView.separated(
                      separatorBuilder: (context, index) {
                      return  const Divider(color:MyColor.greyTextColor,);
                      },
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: controller.leaderBoardlist.length - 3 >= 0 ? controller.leaderBoardlist.length - 3 : 0,
                itemBuilder: (BuildContext context, int index) {
                  final item = controller.leaderBoardlist[index + 3];
                        int ranking = index + 4;
                        return Padding(
                        padding: const EdgeInsets.all(Dimensions.space12),
                        child: Row(
                          children: [
                            item.avatar.toString() != "null"
                                ? Container(
                                    
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: MyColor.leaderBoardTabBar,
                                    ),
                                    child: Container(
                                      margin: EdgeInsets.all(orientation != Orientation.portrait ? Dimensions.space5 : Dimensions.space5),
                                      decoration: BoxDecoration(color: MyColor.leaderBoardTabBar, borderRadius: BorderRadius.circular(Dimensions.space30), image: DecorationImage(image: NetworkImage(UrlContainer.leaderboardProfileImage + item.avatar.toString()), fit: BoxFit.cover)),
                                      height: orientation != Orientation.portrait ? Dimensions.space30 : Dimensions.space50,
                                      width: orientation != Orientation.portrait ? Dimensions.space30 : Dimensions.space50,
                                    ),
                                  )
                                : Image.asset(
                                    MyImages.defaultAvatar,
                                    height: Dimensions.space30,
                                  ),
                            const SizedBox(
                              width: Dimensions.space10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.username.toString(),
                                  style: semiBoldMediumLarge,
                                ),
                                const SizedBox(height: Dimensions.space5),
                                Row(
                                  children: [
                                    // SvgPicture.asset(MyImages().flagImages[index]),
                                     
                                    const SizedBox(
                                      width: Dimensions.space8,
                                    ),
                                    Text(
                                      item.score.toString() + MyStrings.points,
                                      style: semiBoldLarge.copyWith(color: MyColor.textColor),
                                    ),
                                    

                                     
                                  ],

                                ),
                              ],
                              ),
                             const Spacer(),
                               Text(' $ranking',style: semiBoldOverLarge.copyWith(color: MyColor.greyTextColor,),)
                          ],
                        ),
                        );
                }),
          ),
        ],
      ),
    );
  }
}
