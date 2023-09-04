import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/core/utils/style.dart';
import 'package:flutter_prime/data/controller/exam_zone/exam_zone_controller.dart';
import 'package:flutter_prime/data/repo/exam_zone/exam_zone_repo.dart';
import 'package:flutter_prime/data/services/api_service.dart';
import 'package:flutter_prime/view/components/bottom-sheet/custom_bottom_sheet.dart';
import 'package:flutter_prime/view/components/category-card/categories_card.dart';
import 'package:flutter_prime/view/components/custom_loader/custom_loader.dart';
import 'package:get/get.dart';

import '../../../../core/helper/date_converter.dart';
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
                      tabs: const [
                        Tab(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(MyStrings.today),
                          ),
                        ),
                        Tab(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(MyStrings.completed),
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
                        child: ListView.builder(
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
                                minute: "${item.examDuration.toString()} ${MyStrings.min}",
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

class RoundedTabIndicator extends Decoration {
  RoundedTabIndicator({
    Color color = Colors.red,
    double radius = 2.0,
    double width = 20.0,
    double height = 4.0,
    double bottomMargin = 10.0,
  }) : _painter = _RoundedRectanglePainter(
          color,
          width,
          height,
          radius,
          bottomMargin,
        );

  final BoxPainter _painter;

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _painter;
  }
}

class _RoundedRectanglePainter extends BoxPainter {
  _RoundedRectanglePainter(
    Color color,
    this.width,
    this.height,
    this.radius,
    this.bottomMargin,
  ) : _paint = Paint()
          ..color = color
          ..isAntiAlias = true;

  final Paint _paint;
  final double radius;
  final double width;
  final double height;
  final double bottomMargin;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    final centerX = (cfg.size?.width ?? 0) / 2 + offset.dx;
    final bottom = (cfg.size?.height) ?? 0 - bottomMargin;
    final halfWidth = width / 2;
    canvas.drawRRect(
      RRect.fromLTRBR(
        centerX - halfWidth,
        bottom - height,
        centerX + halfWidth,
        bottom,
        Radius.circular(radius),
      ),
      _paint,
    );
  }
}
