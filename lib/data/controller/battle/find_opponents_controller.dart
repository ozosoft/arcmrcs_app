import 'dart:async';

import 'package:flutter/animation.dart';
import 'package:get/get.dart';

import '../auth/signin/signin_controller.dart';
import 'battle_room_controller.dart';

class FindOpponentsController extends GetxController with GetTickerProviderStateMixin {
  SignInController signInController;
  BattleRoomController battleRoomController;

  FindOpponentsController(this.signInController, this.battleRoomController);
  late final AnimationController _imageScrollController;
  AnimationController get imageScrollController => _imageScrollController;
  late Timer _startTimer;
  final _countdownSeconds = 5.obs;
  get countdownSeconds => _countdownSeconds.value;
  Timer get startTimer => _startTimer;
  @override
  void onInit() {
    super.onInit();
    _imageScrollController = AnimationController(vsync: this);

    Future.delayed(const Duration(milliseconds: 1000), () {
      //search for battle room after initial animation completed
      randomSearch();
      runImageScrolling(startOrStop: false);
    });

    // Listen for changes in user found state
    ever<UserFoundState>(
      battleRoomController.userFoundState,
      (state) {
        if (state == UserFoundState.found) {
          _startTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
            // Start the 5-second timer here
            if (_countdownSeconds.value > 0) {
              _countdownSeconds.value--;
            } else {
              _startTimer.cancel();
              //Start Game
              battleRoomController.startBattleQuiz(battleRoomController.battleRoomData.value!.roomId, "battle", readyToPlay: true);
            }
          });
        } else {
          _countdownSeconds.value = 3;
          _startTimer.cancel(); // Cancel the timer if user found state changes
        }
      },
    );
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    print("FindOpponentsController Closed");
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
  randomSearch() {
    var userData = signInController.user;

    battleRoomController.randomSearchRoom(
      categoryId: "5",
      name: userData.value!.email == "arman.khan.dev@gmail.com"
          ? "Arman Khan"
          : userData.value!.email == "arman.khan.dev2@gmail.com"
              ? "Imran Khan"
              : "Salman Khan",
      profileUrl: "",
      uid: userData.value!.uid,
    );
  }
}
