import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_images.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/core/utils/style.dart';
import 'package:flutter_prime/view/components/bottom-sheet/custom_bottom_sheet.dart';
import 'package:flutter_prime/view/components/category-card/categories_card.dart';
import 'package:flutter_prime/view/screens/1vs1/play-with-friends-bottom-sheet/play_with_friends_bottom_sheet.dart';
import 'package:flutter_prime/view/screens/homepage/homepage-widgets/home-body-sections/sub-categories/sub_categories_card_screen.dart';

import 'enter_exam_room_bottom_sheet.dart';

class ExamZoneTabBarBodySection extends StatefulWidget {
  const ExamZoneTabBarBodySection({super.key});

  @override
  State<ExamZoneTabBarBodySection> createState() =>
      _ExamZoneTabBarBodySectionState();
}

class _ExamZoneTabBarBodySectionState extends State<ExamZoneTabBarBodySection>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;
  int selectedIndex = 1;

  TextEditingController _textEditingController = TextEditingController();
  String _inputText = "";
  void initState() {
    tabController = TabController(vsync: this, length: 2);
    setState(() {
      selectedIndex = tabController.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: double.maxFinite,
      child: DefaultTabController(
          length: 2,
          child: Scaffold(
            backgroundColor: MyColor.transparentColor,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(size.height * .4),
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.space20,
                    vertical: Dimensions.space30),
                child: TabBar(
                    controller: tabController,
                    unselectedLabelColor: MyColor.textColor,
                    labelStyle: regularMediumLarge,
                    indicatorPadding: EdgeInsets.zero,
                    indicator: const ShapeDecoration(
                        color: MyColor.primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(Dimensions.space25)))),
                    onTap: (value) {
                      setState(() {
                        selectedIndex = tabController.index;
                      });
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
            body: TabBarView(controller: tabController, children: [
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: MyStrings().allCategoryies.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      child: CategoriesCard(
                        index: index,
                        marks: MyStrings.marks,
                        date: MyStrings.dates,
                        minute: MyStrings.minutes,
                        fromExam: true,
                        title: MyStrings()
                            .subCategoryies[index]["title"]
                            .toString(),
                        questions: MyStrings()
                            .allCategoryies[index]["questions"]
                            .toString(),
                        image: MyImages().categoryImages[index],
                        expansionVisible: true,
                        fromViewAll: false,
                        levels: MyStrings()
                            .allCategoryies[index]["level"]
                            .toString(),
                      ),
                    );
                  }),
              Text("data"),
            ]),
          )),
    );
  }
}
