import 'package:flutter_prime/data/repo/battle/battle_repo.dart';
import 'package:get/get.dart';

import '../../model/battle/battleRoom.dart';
import '../../model/battle/battle_result_submit_model.dart';

class BattleResultController extends GetxController {
  final BattleRepo battleRepo;
  BattleResultController(this.battleRepo);

  // Variables

  final argumentsResult = Get.arguments[0] as BattleAnswerSubmitModel;
  List get messageStatus => argumentsResult.message["success"];
  String get totalQuestion => argumentsResult.data["totalQuestion"].toString();
  String get correctAnswer => argumentsResult.data["correctAnswer"].toString();
  String get wrongAnswer => argumentsResult.data["wrongAnswer"].toString();

  final battleRoomOldData = Get.arguments[1] as BattleRoom;

  //Methods
  @override
  void onInit() {
    super.onInit();
  }

  // if (gameResult.status == 'success' && gameResult.message['success']?.contains('Congratulations') == true)
  //           Text('Congratulations! You won!'),
  //         if (gameResult.status == 'success' && gameResult.message['success']?.contains('Failed') == true)
  //           Text('Oops! You lost.'),
  //         Text('Total Questions: ${gameResult.data['totalQuestion']}'),
  //         Text('Correct Answers: ${gameResult.data['correctAnswer']}'),
  //         Text('Wrong Answers: ${gameResult.data['wrongAnswer']}'),
  //         Text('Your Score: ${gameResult.data['winingScore']}'),
  //         if (gameResult.data.containsKey('winning_coin'))
  //           Text('Winning Coins: ${gameResult.data['winning_coin']}'),
  //         if (gameResult.data.containsKey('loosing_coin'))
  //           Text('Losing Coins: ${gameResult.data['loosing_coin']}

  //My Methotds
}
