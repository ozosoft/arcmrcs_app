// class BattleRoomQuizController

import 'dart:async';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../core/helper/battle_room_helper.dart';
import '../../model/battle/battleRoom.dart';
import '../../model/quiz/quiz_list_model.dart';
import 'battle_room_controller.dart';

class BattleRoomQuizController extends GetxController {
  final BattleRoomController battleRoomController;
  BattleRoomQuizController(this.battleRoomController);
  StreamSubscription<DocumentSnapshot>? battleRoomStreamSubscription;
  final int duration = 60;
  final CountDownController countDownController = CountDownController();
  final RxList<Question> questionsList = <Question>[].obs;

  // Map to track selected options for each question
  final Map<int, Option?> selectedOptions = <int, Option?>{};

  int currentQuestionIndex = 0;

  void selectOptionForQuestion(int questionId, Option option) {
    if (!selectedOptions.containsKey(questionId)) {
      selectedOptions[questionId] = option;
    }
    update();
  }

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
    setupBattleRoomSubmitListener();
    if (currentQuestionIndex >= 0 &&
        currentQuestionIndex < questionsList.length) {
      return questionsList[currentQuestionIndex];
    }

    // Return a placeholder question if index is out of bounds
    return Question(
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

  bool hasSubmittedAnswerForQuestion(int questionId) {
    return selectedOptions.containsKey(questionId);
  }

  // Firebase

  Stream<DocumentSnapshot> listenToBattleRoomDocument(
      String battleRoomDocumentId) {
    return battleRoomController.firebaseFirestore
        .collection(BattleRoomHelper.battleroomCollection)
        .doc(battleRoomDocumentId)
        .snapshots();
  }

  void setupBattleRoomSubmitListener() {
    //  battleRoomStreamSubscription = listenToBattleRoomDocument(
    //     battleRoomController.battleRoomData.value!.roomId!).listen((event) { });

    // battleRoomController.battleRoomStreamSubscription.
    // battleRoomStream.listen((e) {
    //   print("From LIsten");
    //   checkAnswersAndProceed(battleRoomController.battleRoomData.value!,
    //       battleRoomController.questionsData.data.questions);
    // });
    print("From Quiz Stream");
    battleRoomStreamSubscription = listenToBattleRoomDocument(
            battleRoomController.battleRoomData.value!.roomId!)
        .listen((event) {
      if (event.exists) {
        // checkAnswersAndProceed(battleRoomController.battleRoomData.value!,
        //     battleRoomController.questionsData.data.questions);
        checkUserAnswer(battleRoomController.battleRoomData.value!);
      }
    });
  }

  void checkAnswersAndProceed(BattleRoom battleRoom, List<Question> qList) {
    print("From checkAnswersAndProceed");
    List user1Answers = battleRoom.user1!.answers;
    List user2Answers = battleRoom.user2!.answers;
    List<Question> questionsList = qList;

    // Check if both users have submitted answers for all questions
    bool user1HasSubmittedAllAnswers =
        user1Answers.length == questionsList.length;
    bool user2HasSubmittedAllAnswers =
        user2Answers.length == questionsList.length;

    if (user1HasSubmittedAllAnswers && user2HasSubmittedAllAnswers) {
      // Both users have submitted answers for all questions
      // Implement your logic here, like moving to the next question
      // You can call the appropriate function from your controller
    }
  }

  // void checkUserAnswer(BattleRoom battleRoom) {
  //   print("From checkUserAnswer neew");
  //   List user1Answers = battleRoom.user1!.answers;
  //   List user2Answers = battleRoom.user2!.answers;

  //   Set<String> answeredQuestionIds =
  //       Set<String>.from(user1Answers.map((answer) => answer["qid"].toString()))
  //         ..addAll(user2Answers.map((answer) => answer["qid"].toString()));
  //   for (String questionId in answeredQuestionIds) {
  //     bool user1Answered =
  //         user1Answers.any((answer) => answer["qid"].toString() == questionId);
  //     bool user2Answered =
  //         user2Answers.any((answer) => answer["qid"].toString() == questionId);
  //     print(
  //         "$answeredQuestionIds -- ${questionsList[currentQuestionIndex].id}");

  //     if (answeredQuestionIds
  //         .contains(questionsList[currentQuestionIndex].id.toString())) {
  //       print("foundx");
  //       // if (countDownController.isRestarted) {

  //       if (user1Answered && user2Answered) {
  //         goToNextQuestion();
  //       }

  //       // }
  //     }
  //   }
  // }
  void checkUserAnswer(BattleRoom battleRoom) {
    List user1Answers = battleRoom.user1!.answers;
    List user2Answers = battleRoom.user2!.answers;

    String currentQuestionId =
        questionsList[currentQuestionIndex].id.toString();
    String nextQuestionId = (currentQuestionIndex + 1 < questionsList.length)
        ? questionsList[currentQuestionIndex + 1].id.toString()
        : "";

    bool user1AnsweredCurrent = user1Answers
        .any((answer) => answer["qid"].toString() == currentQuestionId);
    bool user2AnsweredCurrent = user2Answers
        .any((answer) => answer["qid"].toString() == currentQuestionId);

    if (user1AnsweredCurrent && user2AnsweredCurrent) {
      print(
          "Both users have answered the current and next questions, and timer completed");
      // goToNextQuestion();

      print("From Counter Next Querstion");
      if (hasMoreQuestions()) {
        goToNextQuestion();
      } else {
        // Both users have answered all questions correctly
        String winnerUserId;

        int user1CorrectAnswers =
            user1Answers.where((answer) => answer["ans"] == "1").length;
        int user2CorrectAnswers =
            user2Answers.where((answer) => answer["ans"] == "1").length;

        if (user1CorrectAnswers > user2CorrectAnswers) {
          winnerUserId = battleRoom.user1!.uid;
        } else if (user2CorrectAnswers > user1CorrectAnswers) {
          winnerUserId = battleRoom.user2!.uid;
        } else {
          // It's a tie
          winnerUserId = "TIE";
        }

        print("Winner User ID: $winnerUserId");
      }
    }
  }

  void selectOptionForQuestion2(int questionId, Option option) {
    // Check if user1 has already submitted an answer for this question
    bool user1HasSubmittedAnswer = battleRoomController
        .battleRoomData.value!.user1!.answers
        .any((answer) => answer.qid == questionId);

    // Check if user2 has already submitted an answer for this question
    bool user2HasSubmittedAnswer = battleRoomController
        .battleRoomData.value!.user2!.answers
        .any((answer) => answer.qid == questionId);

    if (!selectedOptions.containsKey(questionId) &&
        !user1HasSubmittedAnswer &&
        !user2HasSubmittedAnswer) {
      // Only allow selecting an option and submitting if neither user has submitted for this question
      selectedOptions[questionId] = option;

      // Check if all necessary conditions are met to proceed to the next question
      if (user1HasSubmittedAllAnswers() &&
          user2HasSubmittedAllAnswers() &&
          !hasSubmittedAnswerForQuestion(questionId)) {
        goToNextQuestion();
      }
    }
    update();
  }

  bool user1HasSubmittedAllAnswers() {
    BattleRoom battleRoom = battleRoomController.battleRoomData.value!;
    List<Question> questionsList =
        battleRoomController.questionsData.data.questions;

    List<String> user1AnsweredQuestionIds = battleRoom.user1!.answers
        .map((answer) => answer.qid.toString())
        .toList();

    return user1AnsweredQuestionIds.length == questionsList.length;
  }

  bool user2HasSubmittedAllAnswers() {
    BattleRoom battleRoom = battleRoomController.battleRoomData.value!;
    List<Question> questionsList =
        battleRoomController.questionsData.data.questions;

    List<String> user2AnsweredQuestionIds = battleRoom.user2!.answers
        .map((answer) => answer.qid.toString())
        .toList();

    return user2AnsweredQuestionIds.length == questionsList.length;
  }

  @override
  void onClose() {
    battleRoomStreamSubscription!.cancel();
    super.onClose();
  }
}
