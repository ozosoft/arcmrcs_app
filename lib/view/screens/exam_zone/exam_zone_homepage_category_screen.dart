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

class ExamZoneCategoryScreen extends StatefulWidget {
  const ExamZoneCategoryScreen({super.key});

  @override
  State<ExamZoneCategoryScreen> createState() => _ExamZoneCategoryScreenState();
}

class _ExamZoneCategoryScreenState extends State<ExamZoneCategoryScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(DashBoardRepo(apiClient: Get.find()));
    Get.put(DashBoardController(dashRepo: Get.find()));
    DashBoardController controller = Get.put(DashBoardController(dashRepo: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getdata();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashBoardController>(
      builder: (controller) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          controller.examZonelist != null
              ? Padding(
                  padding: const EdgeInsets.only(bottom: Dimensions.space3, left: Dimensions.space4, right: Dimensions.space4, top: Dimensions.space17),
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
                        child: Text(
                          MyStrings.viewAll,
                          style: semiBoldLarge.copyWith(color: MyColor.colorlighterGrey, fontSize: Dimensions.space15),
                        ),
                      ),
                    ],
                  ),
                )
              : const SizedBox(),
          const SizedBox(
            height: Dimensions.space8,
          ),
          controller.examZonelist != null
              ? SizedBox(
                  width: double.infinity,
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                            controller.examZonelist.length,
                            (index) => InkWell(
                                  onTap: () {
                                    // Get.toNamed(RouteHelper.examZoneScreen);
                                    CustomBottomSheet(child: EnterRoomBottomSheetWidget()).customBottomSheet(context);
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
                                              padding: const EdgeInsets.only(top: Dimensions.space7, right: Dimensions.space12),
                                              height: Dimensions.space70,
                                              width: Dimensions.space50,
                                              child: Align(
                                                alignment: Alignment.topCenter,
                                                child: SvgPicture.asset(MyImages.examzoneSVG),
                                              ),
                                            ),
                                            Container(
                                              // height: Dimensions.space70,
                                              // width: Dimensions.space220,
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
                                                    controller.examZonelist[index].description.toString(),
                                                    style: regularDefault.copyWith(color: MyColor.colorlighterGrey),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(right: 0, top: 0, bottom: MediaQuery.of(context).size.height * .05, left: MediaQuery.of(context).size.width * .25),
                                              child: SvgPicture.asset(
                                                MyImages.bookmarkSVG,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          padding: const EdgeInsets.only(top: Dimensions.space10, left: Dimensions.space10),
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
                                                    MyStrings.feeCoins + controller.examZonelist[index].point.toString(),
                                                    style: regularDefault.copyWith(color: MyColor.colorGrey),
                                                  )),
                                                ),
                                              ),
                                              Container(
                                                decoration: BoxDecoration(color: MyColor.cardColor, border: Border.all(color: MyColor.colorDarkGrey, width: 0.3)),
                                                padding: const EdgeInsets.all(Dimensions.space7),
                                                child: Center(child: Text(controller.examZonelist[index].winningmark.toString() + MyStrings.markss, style: regularDefault.copyWith(color: MyColor.colorGrey))),
                                              ),
                                              Container(
                                                decoration: BoxDecoration(color: MyColor.cardColor, border: Border.all(color: MyColor.colorDarkGrey, width: 0.3)),
                                                padding: const EdgeInsets.all(Dimensions.space7),
                                                margin: const EdgeInsets.all(Dimensions.space7),
                                                child: Center(child: Text(controller.examZonelist[index].examDuration.toString() + MyStrings.minutess, style: regularDefault.copyWith(color: MyColor.colorGrey))),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )),
                      )),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
