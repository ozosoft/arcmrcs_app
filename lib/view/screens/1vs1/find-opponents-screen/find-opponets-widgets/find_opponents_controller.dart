import 'package:flutter/animation.dart';
import 'package:get/get.dart';

import '../../../../../data/controller/auth/signin/signin_controller.dart';
import '../../../../../data/controller/battle/battle_room_controller.dart';

class FindOpponentsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  SignInController signInController;
  BattleRoomController battleRoomController;

  FindOpponentsController(this.signInController, this.battleRoomController);
  late final AnimationController _imageScrollController;
  AnimationController get imageScrollController => _imageScrollController;

  @override
  void onInit() {
    super.onInit();
    _imageScrollController = AnimationController(vsync: this);

    Future.delayed(const Duration(milliseconds: 1000), () {
      //search for battle room after initial animation completed
      randomSearch();
      runImageScrolling(startOrStop: false);
    });
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
          : "Imran Khan",
      profileUrl: "",
      uid: userData.value!.uid,
    );
  }
}
