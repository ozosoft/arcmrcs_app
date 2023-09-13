import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../model/quiz_questions_model/quiz_questions_model.dart';
import '../../repo/battle/battle_repo.dart';
import 'battle_room_controller.dart';

class FindOpponentsController extends GetxController with GetTickerProviderStateMixin {
  BattleRepo battleRepo;

  BattleRoomController battleRoomController;

  FindOpponentsController(this.battleRoomController, this.battleRepo);
  //Variables
  late AnimationController _imageScrollController;
  AnimationController get imageScrollController => _imageScrollController;
  late Timer _startTimer;
  final countdownSeconds = 10.obs;
  // get countdownSeconds => _countdownSeconds.value;
  Timer get startTimer => _startTimer;

  var getQuestionList = <Question>[];
  var getCategoryID = Get.arguments[0] as int;
  var getEntryCoin = Get.arguments[1] as String;

  @override
  void onInit() {
    super.onInit();

    runImageScrolling(startOrStop: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      randomSearch(getQuestionList, getCategoryID: getCategoryID, entryCoin: getEntryCoin);
    });
    // Listen for changes in user found state
    ever<UserFoundState>(
      battleRoomController.userFoundState,
      (state) {
        if (state == UserFoundState.found) {
          _startTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
            // Start the 5-second timer here
            if (countdownSeconds.value > 0) {
              if (countdownSeconds.value == 0) {
                countdownSeconds.value = 0;
              } else {
                countdownSeconds.value--;
              }

              update();
            } else {
              _startTimer.cancel();
              print("Form 1 cancle");
              battleRoomController.startBattleQuiz(battleRoomController.battleRoomData.value!.roomId, "battle", readyToPlay: true);

              // Start Game
            }
          });
        } else {
          if (_startTimer.isActive) {
            print("Form 2 cancle 2");
            _startTimer.cancel(); // Cancel the
            countdownSeconds.value = 10;
            update();
          }
        }

        // if (state == UserFoundState.found) {
        //   _startTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        //     // Start the 5-second timer here
        //     if (_countdownSeconds.value > 0) {
        //       _countdownSeconds.value--;
        //     } else {
        //       _startTimer.cancel();
        //       //Start Game
        //       battleRoomController.startBattleQuiz(battleRoomController.battleRoomData.value!.roomId, "battle", readyToPlay: true);
        //     }
        //   });
        // } else {
        //   _countdownSeconds.value = 10;
        //   _startTimer.cancel(); // Cancel the timer if user found state changes
        // }
      },
    );
  }

  @override
  void onClose() {
    debugPrint("FindOpponentsController Closed");
    _imageScrollController.dispose();
    super.onClose();
  }

  // Lottie Start
  runImageScrolling({bool startOrStop = true}) {
    if (startOrStop == true) {
      _imageScrollController = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 10), // Adjust the duration as needed
      )..repeat();
    } else {
      _imageScrollController = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 10), // Adjust the duration as needed
      )..stop();
    }
  }

  //Search Random Users
  randomSearch(List<Question> questionList, {int? getCategoryID, required String entryCoin}) {
    battleRoomController.randomSearchRoom(entryCoin: entryCoin, categoryId: getCategoryID.toString(), name: battleRepo.apiClient.getUserFullName(), profileUrl: battleRepo.apiClient.getUserImagePath(), uid: battleRepo.apiClient.getUserID(), questionList: questionList);
  }
}
