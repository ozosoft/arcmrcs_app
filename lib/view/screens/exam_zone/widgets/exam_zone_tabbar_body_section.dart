import 'package:flutter/material.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';
import 'package:quiz_lab/core/utils/my_color.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/core/utils/style.dart';
import 'package:quiz_lab/data/controller/exam_zone/exam_zone_controller.dart';
import 'package:quiz_lab/data/repo/exam_zone/exam_zone_repo.dart';
import 'package:quiz_lab/data/services/api_service.dart';
import 'package:quiz_lab/view/components/bottom-sheet/custom_bottom_sheet.dart';
import 'package:quiz_lab/view/components/custom_loader/custom_loader.dart';
import 'package:quiz_lab/view/components/no_data.dart';
import 'package:get/get.dart';

import 'completed_exam_list_card_widget.dart';
import 'enter_exam_room_bottom_sheet.dart';
import 'exam_list_card_widget.dart';

class ExamZoneTabBarBodySection extends StatefulWidget {
  const ExamZoneTabBarBodySection({super.key});

  @override
  State<ExamZoneTabBarBodySection> createState() => _ExamZoneTabBarBodySectionState();
}

class _ExamZoneTabBarBodySectionState extends State<ExamZoneTabBarBodySection> {
  @override
  void initState() {
    super.initState();
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(ExamZoneRepo(apiClient: Get.find()));
    ExamZoneController controller = Get.put(ExamZoneController(examZoneRepo: Get.find()));

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.examZoneListData(fromLoad: true);
      controller.completedExamList(fromLoad: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<ExamZoneController>(
      builder: (controller) => SizedBox(
        height: double.maxFinite,
        child: DefaultTabController(
            length: 2,
            child: Scaffold(
              backgroundColor: MyColor.transparentColor,
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(size.height * .4),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.space10, vertical: Dimensions.space10),
                  decoration: BoxDecoration(
                    // color: Colors.amber,
                    borderRadius: BorderRadius.circular(Dimensions.space25),
                  ), // Make it rounded),
                  child: TabBar(
                      controller: controller.tabController,
                      unselectedLabelColor: MyColor.textColor,
                      labelColor: MyColor.colorWhite,
                      labelStyle: regularMediumLarge.copyWith(),
                      indicatorPadding: EdgeInsets.zero,
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.space25), // Make it rounded
                        color: MyColor.primaryColor, // Change the color to green
                      ),
                      onTap: (value) {
                        controller.selectTab();
                      },
                      tabs:  [
                        Tab(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(MyStrings.today.tr),
                          ),
                        ),
                        Tab(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(MyStrings.completed.tr),
                          ),
                        ),
                      ]),
                ),
              ),
              body: controller.loading == true || controller.loadingForCompletedList == true
                  ? const CustomLoader()
                  : TabBarView(physics: const BouncingScrollPhysics(), controller: controller.tabController, children: [
                      RefreshIndicator(
                        color: MyColor.primaryColor,
                        onRefresh: () async {
                          controller.examZoneListData(fromLoad: true);
                        },
                        child: controller.examcategoryList.isEmpty
                            ?  NoDataWidget(messages: MyStrings.noExamFound.tr,)
                            : ListView.builder(
                                physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                                shrinkWrap: true,
                                itemCount: controller.examcategoryList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  var item = controller.examcategoryList[index];
                                  return ExamListTileCard(
                                    exam: item,
                                    index: index,
                                    marks: "${item.prize.toString()} ${MyStrings.points.tr}",
                                    date: "${item.examStartTime.toString()} ",
                                    minute: "${item.examDuration.toString()} ${MyStrings.min.tr}",
                                    image: item.image.toString(),
                                    title: item.title.toString(),
                                    onTap: () async {
                                      // controller.enterExamKey = item.examKey!;
                                      CustomBottomSheet(
                                        child: EnterRoomBottomSheetWidget(
                                          quizInfo: item,
                                        ),
                                      ).customBottomSheet(context);
                                      await controller.examZoneRepo.getExamCode(item.id.toString());
                                    },
                                  );
                                }),
                      ),
                      RefreshIndicator(
                        color: MyColor.primaryColor,
                        onRefresh: () async {
                          controller.completedExamList(fromLoad: true);
                        },
                        child: ListView.builder(
                            physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                            shrinkWrap: true,
                            itemCount: controller.completedExamDataList.length,
                            itemBuilder: (BuildContext context, int index) {
                              var item = controller.completedExamDataList[index];
                              return CompletedExamListTileCard(
                                exam: item,
                                index: index,
                                image: item.image.toString(),
                                title: item.title.toString(),
                                onTap: () {
                                  return;
                                },
                              );
                            }),
                      ),
                    ]),
            )),
      ),
    );
  }
}
