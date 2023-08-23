// class BattleRoomQuizController

import 'dart:async';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/helper/battle_room_helper.dart';
import '../../model/battle/battleRoom.dart';
import '../../model/quiz/quiz_list_model.dart';
import '../../repo/battle/battle_repo.dart';
import 'battle_room_controller.dart';
import '../../model/quiz_questions_model/quiz_questions_model.dart';
class BattleRoomQuizController extends GetxController with GetTickerProviderStateMixin {
  BattleRepo battleRepo;
  final BattleRoomController battleRoomController;

  BattleRoomQuizController(this.battleRoomController, this.battleRepo);
  StreamSubscription<DocumentSnapshot>? battleRoomStreamSubscription;
  final int duration = 60;
  final CountDownController countDownController = CountDownController();
  final RxList<Question> questionsList = <Question>[].obs;
  late AnimationController _listAnimationController;
  AnimationController get listAnimationController => _listAnimationController;

  // Map to track selected options for each question
  final Map<int, Option?> selectedOptions = <int, Option?>{};

  int currentQuestionIndex = 0;
  final opponentLeftTheGame = false.obs;
  final showLeftPopupValue = false.obs;
  final meLeftTheGame = false.obs;

  GlobalKey<AnimatedListState> animatedListKey = GlobalKey<AnimatedListState>();
  int previousQuestionId = -1; // Initialize with a value that won't match any valid question id

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _listAnimationController = AnimationController(
      vsync: this,
      // Adjust duration as needed
    );

    setupBattleRoomSubmitListener();
  }

  showLeftPopupUpdate(bool value) {
    showLeftPopupValue(value);
    update();
  }

  void selectOptionForQuestion(int questionId, Option option) {
    if (!selectedOptions.containsKey(questionId)) {
      selectedOptions[questionId] = option;
    }
    update();
  }

  bool isOptionSelectedForQuestion(int questionId, Option option) {
    return selectedOptions.containsKey(questionId) && selectedOptions[questionId] == option;
  }

//Update LIst Animation
  void updateAnimatedListKeyIfNeeded(int newQuestionId) {
    if (newQuestionId != previousQuestionId) {
      animatedListKey = GlobalKey<AnimatedListState>();
      previousQuestionId = newQuestionId;
    }
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
    if (currentQuestionIndex >= 0 && currentQuestionIndex < questionsList.length) {
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

  Stream<DocumentSnapshot> listenToBattleRoomDocument(String battleRoomDocumentId) {
    return battleRoomController.firebaseFirestore.collection(BattleRoomHelper.battleroomCollection).doc(battleRoomDocumentId).snapshots();
  }

  void setupBattleRoomSubmitListener() {
    print("From Quiz Stream");
    battleRoomStreamSubscription = listenToBattleRoomDocument(battleRoomController.battleRoomData.value!.roomId!).listen((event) {
      if (event.exists) {
        checkUserAnswer(battleRoomController.battleRoomData.value!);
      } else {
        print("Room Deleted");
      }
    });
  }

  showLeftPopup({bool isUpdate = false}) {
    if (showLeftPopupValue.isFalse) {
      // print("Checking If User Left The match");
      var battleData = battleRoomController.battleRoomData.value!;

      // im am user 1
      if (battleRepo.apiClient.getUserID() == battleData.user1!.uid) {
        if (battleData.user2!.status == false) {
          print("${battleData.user2!.name} Left The game");
          opponentLeftTheGame.value = true;
          if (isUpdate) {
            update();
          }
        }
      }
      // im am user 2
      if (battleRepo.apiClient.getUserID() == battleData.user2!.uid) {
        if (battleData.user1!.status == false) {
          print("${battleData.user1!.name} Left The game");
          opponentLeftTheGame.value = true;
          if (isUpdate) {
            update();
          }
        }
      }
    }
  }

  // void checkUserAnswer(BattleRoom battleRoom) {
  //   List user1Answers = battleRoom.user1!.answers;
  //   List user2Answers = battleRoom.user2!.answers;

  //   String currentQuestionId = questionsList[currentQuestionIndex].id.toString();
  //   String nextQuestionId = (currentQuestionIndex + 1 < questionsList.length) ? questionsList[currentQuestionIndex + 1].id.toString() : "";

  //   bool user1AnsweredCurrent = user1Answers.any((answer) => answer["qid"].toString() == currentQuestionId);
  //   bool user2AnsweredCurrent = user2Answers.any((answer) => answer["qid"].toString() == currentQuestionId);

  //   if (user1AnsweredCurrent && user2AnsweredCurrent) {
  //     print("Both users have answered the current and next questions, and timer completed");
  //     // goToNextQuestion();

  //     print("From Counter Next Querstion");
  //     if (hasMoreQuestions()) {
  //       goToNextQuestion();
  //     } else {
  //       // Both users have answered all questions correctly
  //       String winnerUserId;
  //       String winnerUserName = "";

  //       int user1CorrectAnswers = user1Answers.where((answer) => answer["ans"] == "1").length;
  //       int user2CorrectAnswers = user2Answers.where((answer) => answer["ans"] == "1").length;

  //       if (user1CorrectAnswers > user2CorrectAnswers) {
  //         winnerUserId = battleRoom.user1!.uid;
  //         winnerUserName = battleRoom.user1!.name;
  //         Get.snackbar("Winner Is", " $winnerUserName ", backgroundColor: Colors.green);
  //       } else if (user2CorrectAnswers > user1CorrectAnswers) {
  //         winnerUserId = battleRoom.user2!.uid;
  //         winnerUserName = battleRoom.user2!.name;
  //         Get.snackbar("Winner Is", " $winnerUserName ");
  //       } else {
  //         // It's a tie
  //         winnerUserId = "TIE";
  //         Get.snackbar("Game Is", "Drawn!");
  //       }

  //       print("Winner User ID: $winnerUserId");
  //     }
  //   }
  // }

  void checkUserAnswer(BattleRoom battleRoom) {
    List user1Answers = battleRoom.user1!.answers;
    List user2Answers = battleRoom.user2!.answers;
    String currentQuestionId = questionsList[currentQuestionIndex].id.toString();
    if (user1Answers.isEmpty || user2Answers.isEmpty) {
      if (user1Answers.isNotEmpty && user2Answers.isEmpty) {
        print("User 2 hasn't answered yet, while User 1 has answered.");
      } else if (user1Answers.isEmpty && user2Answers.isNotEmpty) {
        print("User 1 hasn't answered yet, while User 2 has answered.");
      }
    } else {
      bool user1AnsweredCurrent = user1Answers.any((answer) => answer["qid"].toString() == currentQuestionId);
      bool user2AnsweredCurrent = user2Answers.any((answer) => answer["qid"].toString() == currentQuestionId);

      if (user1AnsweredCurrent && user2AnsweredCurrent) {
        print("Both users have answered the current and next questions, and timer completed");

        if (hasMoreQuestions()) {
          goToNextQuestion();
        } else {
          int user1CorrectAnswers = user1Answers.where((answer) => answer["ans"] == "1").length;
          int user2CorrectAnswers = user2Answers.where((answer) => answer["ans"] == "1").length;

          if (user1CorrectAnswers > user2CorrectAnswers) {
            Get.snackbar("Winner Is", " ${battleRoom.user1!.name} ", backgroundColor: Colors.green);
          } else if (user2CorrectAnswers > user1CorrectAnswers) {
            Get.snackbar("Winner Is", " ${battleRoom.user2!.name} ");
          } else {
            Get.snackbar("Game Is", "Drawn!");
          }
        }
      }
    }
  }




  @override
  void onClose() {
    battleRoomStreamSubscription!.cancel();
    super.onClose();
  }
}
