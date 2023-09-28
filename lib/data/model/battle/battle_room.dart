import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz_lab/data/model/battle/user_battle_room_details_model.dart';

class BattleRoom {
  final String? roomId;
  final String? categoryId;
  final String? createdBy;
  final String? languageId;

  final UserBattleRoomDetailsModel? user1;
  final UserBattleRoomDetailsModel? user2;
  final UserBattleRoomDetailsModel? user3;
  final UserBattleRoomDetailsModel? user4;
  final int? entryFee;
  final String? roomCode;
  final bool? readyToPlay;
  final String? questions_list;

  BattleRoom({this.roomId, this.categoryId, this.user1, this.user2, this.createdBy, this.readyToPlay, this.roomCode, this.user3, this.user4, this.entryFee, this.languageId, this.questions_list});

  static BattleRoom fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    final data = documentSnapshot.data() as Map<String, dynamic>;
    return BattleRoom(
        languageId: data['languageId'] ?? "",
        categoryId: data['categoryId'] ?? "",
        createdBy: data['createdBy'],
        roomId: documentSnapshot.id,
        readyToPlay: data['readyToPlay'] ?? false,
        entryFee: data['entryFee'] ?? 0,
        roomCode: data['roomCode'] ?? "",
        user1: UserBattleRoomDetailsModel.fromJson(Map.from(data['user1'])),
        user2: UserBattleRoomDetailsModel.fromJson(Map.from(data['user2'])),
        user3: UserBattleRoomDetailsModel.fromJson(Map.from(data['user3'] ?? {})),
        user4: UserBattleRoomDetailsModel.fromJson(Map.from(data['user4'] ?? {})),
        questions_list: data["questions_list"]);
  }

  BattleRoom copyWih({String? categoryId}) {
    return BattleRoom(
      categoryId: categoryId ?? this.categoryId,
      roomId: roomId,
      createdBy: createdBy,
      user1: user1,
      user2: user2,
      languageId: languageId,
      questions_list: questions_list,
    );
  }
}
