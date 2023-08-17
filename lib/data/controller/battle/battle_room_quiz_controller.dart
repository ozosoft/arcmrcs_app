// class BattleRoomQuizController

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:get/get.dart';

import '../../model/quiz/quiz_list_model.dart';

class BattleRoomQuizController extends GetxController {
  final int duration = 60;
  final CountDownController countDownController = CountDownController();
  final RxList<Question> questionsList = <Question>[].obs;

  // Map to track selected options for each question
  final Map<int, Option?> selectedOptions = <int, Option?>{};

  int currentQuestionIndex = 0;

  void selectOptionForQuestion(int questionId, Option option) {
    if (!selectedOptions.containsKey(questionId)) {
      selectedOptions[questionId] = option;
      update();
    }
  }

// Method to check if an option is selected for a specific question
  bool isOptionSelectedForQuestion(int questionId, Option option) {
    return selectedOptions.containsKey(questionId) &&
        selectedOptions[questionId] == option;
  }

  void goToPreviousQuestion() {
    if (currentQuestionIndex > 0) {
      currentQuestionIndex--;
      countDownController.restart(duration: duration);
    }
    update();
  }

  void goToNextQuestion() {
    if (currentQuestionIndex < questionsList.length - 1) {
      currentQuestionIndex++;
      countDownController.restart(duration: duration);
    }
    update();
  }

  Question getCurrentQuestion() {
    if (currentQuestionIndex >= 0 &&
        currentQuestionIndex < questionsList.length) {
      return questionsList[currentQuestionIndex];
    }

    return Question(
      // Return a placeholder question if index is out of bounds
      id: -1,
      question: 'Question not found',
      image: null,
      code: '',
      status: '',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      pivot: Pivot(quizInfoId: '', questionId: ''),
      options: [],
    );
  }

  bool hasMoreQuestions() {
    return currentQuestionIndex < questionsList.length - 1;
  }
}
