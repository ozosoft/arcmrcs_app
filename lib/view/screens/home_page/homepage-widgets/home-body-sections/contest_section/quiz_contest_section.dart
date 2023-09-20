import 'package:flutter/material.dart';
import 'package:quiz_lab/core/route/route.dart';
import 'package:quiz_lab/core/utils/my_color.dart';
import 'package:quiz_lab/core/utils/my_images.dart';
import 'package:quiz_lab/core/utils/url_container.dart';
import 'package:quiz_lab/data/controller/dashboard/dashboard_controller.dart';
import 'package:quiz_lab/data/controller/quiz_contest/quiz_contest_questions_controller.dart';
import 'package:quiz_lab/view/components/snack_bar/show_custom_snackbar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../../../core/helper/date_converter.dart';
import '../../../../../../core/utils/dimensions.dart';
import '../../../../../../core/utils/my_strings.dart';
import '../../../../../../core/utils/style.dart';
import '../../../../../components/chips/custom_chips_widget.dart';
import '../../../../../components/image_widget/my_image_widget.dart';

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
            padding: const EdgeInsetsDirectional.only(bottom: Dimensions.space5, start: Dimensions.space5, end: Dimensions.space5, top: Dimensions.space20),
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
                  child: Padding(
                    padding: const EdgeInsets.all(Dimensions.space5),
                    child: Text(
                      MyStrings.viewAll.tr,
                      style: semiBoldLarge.copyWith(color: MyColor.colorlighterGrey, fontSize: Dimensions.space15),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: Dimensions.space10,
          ),
          controller.contestlist.isNotEmpty
              ? SizedBox(
                  width: double.infinity,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                          controller.contestlist.length,
                          (index) => SizedBox(
                                width: context.width * 0.85,
                                child: GetBuilder<QuizContestQuestionsController>(
                                  builder: (quizQuestionscontrollers) => GestureDetector(
                                    onTap: () {
                                      if (quizQuestionscontrollers.examQuestionsList != "[]") {
                                        Get.toNamed(RouteHelper.quizContestQuestionscreen, arguments: [controller.contestlist[index].id.toString(), controller.contestlist[index].title.toString(), debugPrint("this is quiz id" + controller.contestlist[index].id.toString()), debugPrint("this is quiz title" + controller.contestlist[index].title.toString())]);
                                      } else {
                                        CustomSnackBar.error(errorList: [MyStrings.noContestFound.tr,]);
                                      }
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(horizontal: Dimensions.space5),
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
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: const EdgeInsetsDirectional.only(top: Dimensions.space3),
                                            padding: const EdgeInsets.all(Dimensions.space12),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                //Image
                                                if (controller.contestlist[index].image.toString() == "null") ...[
                                                  Container(
                                                    margin: const EdgeInsetsDirectional.only(end: Dimensions.space10),
                                                    child: SvgPicture.asset(
                                                      MyImages.examzoneSVG,
                                                      height: context.width * 0.15,
                                                      width: context.width * 0.15,
                                                    ),
                                                  ),
                                                ] else ...[
                                                  Container(
                                                    margin: const EdgeInsetsDirectional.only(end: Dimensions.space10),
                                                    child: MyImageWidget(
                                                      height: context.width * 0.15,
                                                      width: context.width * 0.15,
                                                      imageUrl: UrlContainer.quizContestImage + controller.contestlist[index].image.toString(),
                                                    ),
                                                  ),
                                                ],
                                                //Contents
                                                Expanded(
                                                  child: Container(
                                                    padding: const EdgeInsetsDirectional.only(bottom: Dimensions.space20),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        Text(
                                                          controller.contestlist[index].title.toString().tr,
                                                          style: semiBoldMediumLarge,
                                                        ),
                                                        const SizedBox(height: Dimensions.space8),
                                                        Text(
                                                          "${controller.contestlist[index].description.toString().tr} ",
                                                          maxLines: 3,
                                                          overflow: TextOverflow.ellipsis,
                                                          style: regularDefault.copyWith(color: MyColor.colorlighterGrey),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: Dimensions.space10,
                                          ),
                                          Container(
                                            height: 0.1,
                                            color: MyColor.colorlighterGrey,
                                          ),
                                          Container(
                                            padding: const EdgeInsets.all(Dimensions.space10),
                                            width: Dimensions.space330,
                                            child: Row(
                                              children: [
                                                CustomChipsWidget(
                                                  right: Dimensions.space7,
                                                  child: Center(
                                                      child: Text(
                                                    "${MyStrings.entryFee.tr} - ${controller.contestlist[index].point!.tr}",
                                                    style: regularDefault.copyWith(color: MyColor.colorGrey),
                                                  )),
                                                ),
                                                CustomChipsWidget(
                                                  right: Dimensions.space7,
                                                  child: Center(
                                                    child: Text(
                                                      '${MyStrings.end.tr}${DateConverter.stringDateToDate(controller.contestlist[index].endDate.toString()).tr}',
                                                      style: regularDefault.copyWith(color: MyColor.colorGrey),
                                                    ),
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
                                ),
                              )),
                    ),
                  ),
                )
              : Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: Dimensions.space5),
                  padding: const EdgeInsets.all(Dimensions.space20),
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
                  child: Center(
                    child: Text(
                      MyStrings.noContestFound.tr,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: regularDefault.copyWith(color: MyColor.spinLoadColor),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
