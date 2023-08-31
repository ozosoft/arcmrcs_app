import 'package:flutter/material.dart';
import 'package:flutter_prime/core/route/route.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_images.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/core/utils/style.dart';
import 'package:flutter_prime/data/controller/dashboard/dashboard_controller.dart';
import 'package:flutter_prime/data/repo/dashboard/dashboard_repo.dart';
import 'package:flutter_prime/data/services/api_service.dart';
import 'package:flutter_prime/view/components/bottom-sheet/custom_bottom_sheet.dart';
import 'package:flutter_prime/view/screens/exam_zone/widgets/enter_exam_room_bottom_sheet.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../../core/utils/url_container.dart';
import '../../../../../components/image_widget/my_image_widget.dart';

class ExamZoneCategoryScreen extends StatefulWidget {
  const ExamZoneCategoryScreen({super.key});

  @override
  State<ExamZoneCategoryScreen> createState() => _ExamZoneCategoryScreenState();
}

class _ExamZoneCategoryScreenState extends State<ExamZoneCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashBoardController>(
      builder: (controller) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: Dimensions.space5, left: Dimensions.space5, right: Dimensions.space5, top: Dimensions.space20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  MyStrings.examZone,
                  style: semiBoldMediumLarge,
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(RouteHelper.examZoneScreen);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(Dimensions.space5),
                    child: Text(
                      MyStrings.viewAll,
                      style: semiBoldLarge.copyWith(color: MyColor.colorlighterGrey, fontSize: Dimensions.space15),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: Dimensions.space8,
          ),
          controller.examZonelist.isNotEmpty
              ? SizedBox(
                  width: double.infinity,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                          controller.examZonelist.length,
                          (index) => SizedBox(
                                width: context.width * 0.85,
                                child: GestureDetector(
                                  onTap: () {
                                    // Get.toNamed(RouteHelper.examZoneScreen);

                                    CustomBottomSheet(
                                        child: EnterRoomBottomSheetWidget(
                                      quizInfo_id: controller.examZonelist[index].id.toString(),
                                    )).customBottomSheet(context);
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
                                          margin: const EdgeInsets.only(top: Dimensions.space3),
                                          padding: const EdgeInsets.all(Dimensions.space12),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              //Image
                                              if (controller.examZonelist[index].image.toString() == "null") ...[
                                                Container(
                                                  margin: const EdgeInsets.only(right: Dimensions.space10),
                                                  child: SvgPicture.asset(
                                                    MyImages.examzoneSVG,
                                                    height: context.width * 0.15,
                                                    width: context.width * 0.15,
                                                  ),
                                                ),
                                              ] else ...[
                                                Container(
                                                  margin: const EdgeInsets.only(right: Dimensions.space10),
                                                  child: MyImageWidget(
                                                    height: context.width * 0.15,
                                                    width: context.width * 0.15,
                                                    imageUrl: UrlContainer.examZoneImage + controller.examZonelist[index].image.toString(),
                                                  ),
                                                ),
                                              ],
                                              //Contents
                                              Expanded(
                                                child: Container(
                                                  padding: const EdgeInsets.only(bottom: Dimensions.space20),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      Text(
                                                        controller.examZonelist[index].title.toString(),
                                                        style: semiBoldMediumLarge,
                                                      ),
                                                      const SizedBox(height: Dimensions.space8),
                                                      Text(
                                                        "${controller.examZonelist[index].description.toString()} ",
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
                                          height: Dimensions.space20,
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
                                              Container(
                                                margin: const EdgeInsets.only(right: Dimensions.space10),
                                                decoration: BoxDecoration(
                                                  color: MyColor.cardBgLighGreyColor,
                                                  borderRadius: BorderRadius.circular(Dimensions.space5),
                                                  border: Border.all(color: MyColor.colorlighterGrey, width: 0.3),
                                                ),
                                                padding: const EdgeInsets.all(Dimensions.space7),
                                                child: Center(
                                                    child: Text(
                                                  MyStrings.feeCoins + controller.examZonelist[index].point.toString(),
                                                  style: regularDefault.copyWith(color: MyColor.colorGrey),
                                                )),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.only(right: Dimensions.space10),
                                                decoration: BoxDecoration(
                                                  color: MyColor.cardBgLighGreyColor,
                                                  borderRadius: BorderRadius.circular(Dimensions.space5),
                                                  border: Border.all(color: MyColor.colorlighterGrey, width: 0.3),
                                                ),
                                                padding: const EdgeInsets.all(Dimensions.space7),
                                                child: Center(child: Text(controller.examZonelist[index].winningmark.toString() + MyStrings.markss, style: regularDefault.copyWith(color: MyColor.colorGrey))),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.only(right: Dimensions.space10),
                                                decoration: BoxDecoration(
                                                  color: MyColor.cardBgLighGreyColor,
                                                  borderRadius: BorderRadius.circular(Dimensions.space5),
                                                  border: Border.all(color: MyColor.colorlighterGrey, width: 0.3),
                                                ),
                                                padding: const EdgeInsets.all(Dimensions.space7),
                                                child: Center(child: Text(controller.examZonelist[index].examDuration.toString() + MyStrings.minutess, style: regularDefault.copyWith(color: MyColor.colorGrey))),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
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
                      MyStrings.noExamFound,
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
