import 'package:flutter/material.dart';
import 'package:flutter_prime/core/route/route.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/data/controller/quiz_contest/quiz_contest_list_controller.dart';
import 'package:flutter_prime/data/repo/quiz_contest/quiz_contest_repo.dart';
import 'package:flutter_prime/data/services/api_service.dart';
import 'package:flutter_prime/view/components/app-bar/custom_category_appBar.dart';
import 'package:flutter_prime/view/components/category-card/categories_card.dart';
import 'package:get/get.dart';

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
    Size size = MediaQuery.of(context).size;
    return GetBuilder<QuizQuestionsListController>(
      builder: (controller) => Scaffold(
        appBar:const CustomCategoryAppBar(
          title: MyStrings.quizContest,
        ),
        body: SingleChildScrollView(
          child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: controller.examcategoryList.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    Get.toNamed(RouteHelper.quizContestQuestionscreen,arguments: [controller.examcategoryList[index].id.toString(),controller.examcategoryList[index].title.toString()]);
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
        ),
      ),
    );
  }
}
