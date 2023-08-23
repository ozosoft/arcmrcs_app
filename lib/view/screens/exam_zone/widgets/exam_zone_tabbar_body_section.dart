import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_images.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/core/utils/style.dart';
import 'package:flutter_prime/core/utils/url_container.dart';
import 'package:flutter_prime/data/controller/exam_zone/exam_zone_controller.dart';
import 'package:flutter_prime/data/repo/exam_zone/exam_zone_repo.dart';
import 'package:flutter_prime/data/services/api_service.dart';
import 'package:flutter_prime/view/components/bottom-sheet/custom_bottom_sheet.dart';
import 'package:flutter_prime/view/components/category-card/categories_card.dart';
import 'package:get/get.dart';

import 'enter_exam_room_bottom_sheet.dart';

class ExamZoneTabBarBodySection extends StatefulWidget {
  const ExamZoneTabBarBodySection({super.key});

  @override
  State<ExamZoneTabBarBodySection> createState() => _ExamZoneTabBarBodySectionState();
}

class _ExamZoneTabBarBodySectionState extends State<ExamZoneTabBarBodySection> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(ExamZoneRepo(apiClient: Get.find()));

    ExamZoneController controller = Get.put(ExamZoneController(
      examZoneRepo: Get.find(),
    ));

    

    
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.examZonegetdata();
    });

    controller.tabController = TabController(vsync: this, length: 2);

    controller.selectedIndex = controller.tabController.index;
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
                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.space20, vertical: Dimensions.space30),
                  child: TabBar(
                      controller: controller.tabController,
                      unselectedLabelColor: MyColor.textColor,
                      labelStyle: regularMediumLarge,
                      indicatorPadding: EdgeInsets.zero,
                      indicator: const ShapeDecoration(color: MyColor.primaryColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(Dimensions.space25)))),
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
              body: TabBarView(controller:controller. tabController, children: [
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.examcategoryList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                            CustomBottomSheet(child: EnterRoomBottomSheetWidget()).customBottomSheet(context);
                        },
                        child: CategoriesCard(
                          index: index,
                          marks: MyStrings.marks,
                          date: MyStrings.dates,
                          minute: MyStrings.minutes,
                          fromExam: true,
                          title: controller.examcategoryList[index].title.toString(),
                          // questions: MyStrings().allCategoryies[index]["questions"].toString(),
                          // image: UrlContainer.examZoneImage+  controller.examcategoryList[index].image.toString(),
                          expansionVisible: false,
                          fromViewAll: false,
                          // levels: MyStrings().allCategoryies[index]["level"].toString(),
                        ),
                      );
                    }),
                Text("data"),
              ]),
            )),
      ),
    );
  }
}
