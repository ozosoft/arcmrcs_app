import 'package:flutter/material.dart';
import 'package:flutter_prime/core/route/route.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/core/utils/style.dart';
import 'package:flutter_prime/core/utils/url_container.dart';
import 'package:flutter_prime/data/controller/dashboard/dashboard_controller.dart';
import 'package:flutter_prime/data/repo/dashboard/dashboard_repo.dart';
import 'package:flutter_prime/data/services/api_service.dart';
import 'package:flutter_prime/view/components/snack_bar/show_custom_snackbar.dart';
import 'package:get/get.dart';

import '../../../../../components/image_widget/my_image_widget.dart';

class PlayDiffrentQuizes extends StatefulWidget {
  const PlayDiffrentQuizes({super.key});

  @override
  State<PlayDiffrentQuizes> createState() => _PlayDiffrentQuizesState();
}

class _PlayDiffrentQuizesState extends State<PlayDiffrentQuizes> {


  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashBoardController>(
      builder: (controller) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: Dimensions.space10, left: Dimensions.space5, right: Dimensions.space5, top: Dimensions.space20),
            child: Text(
              MyStrings.playDiffrentQuizs,
              style: boldMediumLarge,
            ),
          ),
          const SizedBox(height: Dimensions.space10),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.9),
            itemCount: controller.differentQuizlist.length,
            itemBuilder: (context, index) {
              var item = controller.differentQuizlist[index];
              return GestureDetector(
                onTap: () {
                  if (item.act == "fun") {
                    Get.toNamed(RouteHelper.funNlearnScreenScreen);
                  } else if (item.act == "guess_word") {
                    Get.toNamed(RouteHelper.guessTheWordCategory);
                  } else if (item.act == "daily_quiz") {
                    Get.toNamed(RouteHelper.dailyQuizQuestionsScreen);
                  } else if (item.act == "single_battle") {
                    Get.toNamed(RouteHelper.oneVSoneBattleScreen);
                  } else {
                    CustomSnackBar.error(errorList: [(MyStrings.serverError)]);
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.space10),
                  decoration: BoxDecoration(
                    color: MyColor.colorWhite,
                    borderRadius: BorderRadius.circular(Dimensions.space10),
                    boxShadow: const [
                      BoxShadow(
                        color: MyColor.cardShaddowColor2,
                        offset: Offset(0, 8),
                        blurRadius: 60,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  margin: const EdgeInsets.all(Dimensions.space5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: Dimensions.space10),
                        child: MyImageWidget(
                          height: context.width * 0.14,
                          width: context.width * 0.14,
                          imageUrl: UrlContainer.playdiffrentImage + controller.differentQuizlist[index].image.toString(),
                        ),
                      ),
                      const SizedBox(
                        height: Dimensions.space10,
                      ),
                      Text(
                        controller.differentQuizlist[index].name.toString(),
                        style: semiBoldExtraLarge,
                      ),
                      const SizedBox(height: Dimensions.space10),
                      Text("${controller.differentQuizlist[index].shortDescription.toString()} ", maxLines: 3, overflow: TextOverflow.ellipsis, style: regularDefault.copyWith(color: MyColor.textColor, fontSize: Dimensions.fontDefault12), textAlign: TextAlign.center),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
