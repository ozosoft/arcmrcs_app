import 'package:flutter/material.dart';
import 'package:flutter_prime/core/route/route.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_images.dart';
import 'package:flutter_prime/core/utils/url_container.dart';
import 'package:flutter_prime/data/controller/dashboard/dashboard_controller.dart';
import 'package:flutter_prime/data/controller/quiz_contest/quiz_contest_questions_controller.dart';
import 'package:flutter_prime/view/components/snack_bar/show_custom_snackbar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/my_strings.dart';
import '../../../core/utils/style.dart';

class QuizContestSection extends StatefulWidget {
  const QuizContestSection({super.key});

  @override
  State<QuizContestSection> createState() => _QuizContestSectionState();
}

class _QuizContestSectionState extends State<QuizContestSection> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashBoardController>(
      builder: (controller) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.only(bottom: Dimensions.space3, start: Dimensions.space4, end: Dimensions.space4, top: Dimensions.space17),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 Text(
                  MyStrings.quizContest.tr,
                  style: semiBoldMediumLarge,
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(RouteHelper.quizContestListscreen);
                  },
                  child: Text(
                    MyStrings.viewAll.tr,
                    style: semiBoldLarge.copyWith(color: MyColor.colorlighterGrey, fontSize: Dimensions.space15),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: Dimensions.space8,
          ),
          SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                      controller.contestlist.length,
                      (index) => GetBuilder<QuizContestQuestionsController>(
                            builder: (quizQuestionscontrollers) => InkWell(
                              onTap: () {
                                debugPrint(quizQuestionscontrollers.examQuestionsList as String?);
                                if (quizQuestionscontrollers.examQuestionsList != "") {
                                  Get.toNamed(RouteHelper.quizContestQuestionscreen, arguments: [
                                    controller.contestlist[index].id.toString(),
                                    controller.contestlist[index].title.toString(),
                                  ]);
                                } else {
                                  CustomSnackBar.error(errorList: ["Sorry this contest is not available right now"]);
                                }
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(horizontal: Dimensions.space5),
                                padding: const EdgeInsets.all(Dimensions.space12),
                                decoration: BoxDecoration(
                                  color: MyColor.colorWhite,
                                  borderRadius: BorderRadius.circular(Dimensions.defaultRadius),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color.fromARGB(61, 158, 158, 158),
                                      blurRadius: 7,
                                      spreadRadius: .5,
                                      offset: Offset(
                                        .4,
                                        .4,
                                      ),
                                    )
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          padding: const EdgeInsetsDirectional.only(top: Dimensions.space7, end: Dimensions.space12),
                                          height: Dimensions.space70,
                                          width: Dimensions.space50,
                                          child: Align(
                                            alignment: Alignment.topCenter,
                                            child: Image.network(UrlContainer.quizContestImage + controller.contestlist[index].image.toString()),
                                          ),
                                        ),
                                        Container(
                                          // height: Dimensions.space70,
                                          // width: Dimensions.space220,
                                          padding: const EdgeInsetsDirectional.only(bottom: Dimensions.space20),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                controller.contestlist[index].title.toString(),
                                                style: semiBoldMediumLarge,
                                              ),
                                              const SizedBox(height: Dimensions.space8),
                                              Text(
                                                controller.contestlist[index].description.toString(),
                                                // .substring(3, 10),
                                                style: regularDefault.copyWith(color: MyColor.colorlighterGrey),
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsetsDirectional.only(end: 0, top: 0, bottom: MediaQuery.of(context).size.height * .05, start: MediaQuery.of(context).size.width * .25),
                                          child: SvgPicture.asset(
                                            MyImages.bookmarkSVG,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      height: 0.1,
                                      color: MyColor.colorlighterGrey,
                                    ),
                                    Container(
                                      padding: const EdgeInsetsDirectional.only(top: Dimensions.space10, start: Dimensions.space10),
                                      width: Dimensions.space330,
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(Dimensions.space5),
                                            child: Container(
                                              decoration: BoxDecoration(color: MyColor.cardColor, border: Border.all(color: MyColor.colorlighterGrey, width: 0.3)),
                                              padding: const EdgeInsets.all(Dimensions.space7),
                                              child: Center(
                                                  child: Text(
                                                MyStrings.feeCoins.tr + controller.contestlist[index].point.toString(),
                                                style: regularDefault.copyWith(color: MyColor.colorGrey),
                                              )),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(Dimensions.space5),
                                            child: Container(
                                              decoration: BoxDecoration(color: MyColor.cardColor, border: Border.all(color: MyColor.colorDarkGrey, width: 0.3)),
                                              padding: const EdgeInsets.all(Dimensions.space7),
                                              child: Center(child: Text(MyStrings.end.tr + controller.contestlist[index].endDate.toString(), style: regularDefault.copyWith(color: MyColor.colorGrey))),
                                            ),
                                          ),
                                          const Spacer(),
                                          Center(child: SvgPicture.asset(MyImages.playNowSVG))
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )),
                )),
          ),
        ],
      ),
    );
  }
}
