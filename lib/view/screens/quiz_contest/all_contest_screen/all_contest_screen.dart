import 'package:flutter/material.dart';
import 'package:quiz_lab/core/route/route.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/data/controller/quiz_contest/quiz_contest_list_controller.dart';
import 'package:quiz_lab/data/repo/quiz_contest/quiz_contest_repo.dart';
import 'package:quiz_lab/data/services/api_service.dart';
import 'package:quiz_lab/view/components/app-bar/custom_category_appBar.dart';
import 'package:quiz_lab/view/components/custom_loader/custom_loader.dart';
import 'package:get/get.dart';
import '../../../components/no_data.dart';
import 'widget/contest_title_card_widget.dart';

class AllContestScreen extends StatefulWidget {
  const AllContestScreen({super.key});

  @override
  State<AllContestScreen> createState() => _AllContestScreenState();
}

class _AllContestScreenState extends State<AllContestScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(QuizContestRepo(apiClient: Get.find()));

    QuizQuestionsListController controller = Get.put(QuizQuestionsListController(
      quizContestRepo: Get.find(),
    ));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getQuizcontestList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuizQuestionsListController>(
      builder: (controller) => Scaffold(
        appBar: CustomCategoryAppBar(
          title: MyStrings.quizContest.tr,
        ),
        body: controller.loading == true
            ? const CustomLoader()
            : controller.examcategoryList.isEmpty
                ? NoDataWidget(
                    messages: MyStrings.noContestFound.tr,
                  )
                : SingleChildScrollView(
                    child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controller.examcategoryList.length,
                        itemBuilder: (BuildContext context, int index) {
                          var contestItem = controller.examcategoryList[index];
                          return ContestListTileCard(
                            onTap: () {
                              Get.toNamed(RouteHelper.quizContestQuestionscreen, arguments: [controller.examcategoryList[index].id.toString(), controller.examcategoryList[index].title.toString()])!.whenComplete(() {});
                            },
                            contest: contestItem,
                            index: index,
                            image: contestItem.image.toString(),
                          );
                        }),
                  ),
      ),
    );
  }
}
