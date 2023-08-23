import 'dart:convert';
import 'package:flutter_prime/data/repo/battle/battle_repo.dart';
import 'package:get/get.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';

import '../../model/quiz_questions_model/quiz_questions_model.dart';

class OneVsOneController extends GetxController {
  final BattleRepo battleRepo;
  OneVsOneController(this.battleRepo);

  // Variables
  final questionsList = <Question>[].obs;
  final isLoadingQuestions = false.obs;

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
}
