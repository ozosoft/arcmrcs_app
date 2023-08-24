import 'dart:convert';
import 'package:flutter_prime/data/repo/battle/battle_repo.dart';
import 'package:get/get.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';

import '../../model/battle/battle_category_list.dart';
import '../../model/quiz_questions_model/quiz_questions_model.dart';

class OneVsOneController extends GetxController {
  final BattleRepo battleRepo;
  OneVsOneController(this.battleRepo);

  // Variables
  final questionsList = <Question>[].obs;
  final isLoadingQuestions = false.obs;

  final categoryList = <BattleCategory>[].obs;
  final isLoadingCategory = false.obs;
  final slectedCategoryID = 0.obs;

  @override
  void onInit() {
    super.onInit();
    getRandomBattleCategoryList();
  }

  // Get battle Questions
  Future<void> getRandomBattleQuestions() async {
    isLoadingQuestions.value = true;
    update();

    final model = await battleRepo.getBatttleQuestion(87);

    if (model.statusCode == 200) {
      questionsList.clear();

      final quizquestions = QuizquestionsModel.fromJson(jsonDecode(model.responseJson));

      if (quizquestions.status!.toLowerCase() == MyStrings.success.toLowerCase()) {
        final questionList = quizquestions.data?.questions;

        if (questionList != null && questionList.isNotEmpty) {
          questionsList.addAll(questionList);
        }
      }

      print('---------------------${model.statusCode}');

      isLoadingQuestions.value = false;
      update();
    }
  }

  // Get battle Category
  Future<void> getRandomBattleCategoryList() async {
    isLoadingCategory.value = true;
    update();

    final model = await battleRepo.getCategoryListData();

    if (model.statusCode == 200) {
      categoryList.clear();

      final battleCategoryList = battleCategoryListFromJson(model.responseJson);

      if (battleCategoryList.status.toLowerCase() == MyStrings.success.toLowerCase()) {
        final categoryListData = battleCategoryList.data.categories;

        if (categoryListData.isNotEmpty) {
          categoryList.addAll(categoryListData);
        }
      }

      isLoadingCategory.value = false;
      update();
    }
  }

  //Select A Category
  slectACategory(int value) {
    slectedCategoryID.value = value;
    update();
  }
}
