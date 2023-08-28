import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_prime/data/model/battle/userBattleRoomDetails.dart';

class BattleRoom {
  final String? roomId;
  final String? categoryId;
  final String? createdBy;
  final String? languageId;

  final UserBattleRoomDetails? user1;
  //it will be in use for multiUserBattleRoom
  //user1 will be the creator of this room
  final UserBattleRoomDetails? user2; //it will be in use for multiUserBattleRoom
  final UserBattleRoomDetails? user3; //it will be in use for multiUserBattleRoom
  final UserBattleRoomDetails? user4; //it will be in use for multiUserBattleRoom
  final int? entryFee; //it will be in use for multiUserBattleRoom
  final String? roomCode; //it will be in use for multiUserBattleRoom
  final bool? readyToPlay; //it will be in use for multiUserBattleRoom
  final String? questions_list; //it will be in use for multiUserBattleRoom

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
        user1: UserBattleRoomDetails.fromJson(Map.from(data['user1'])),
        user2: UserBattleRoomDetails.fromJson(Map.from(data['user2'])),
        user3: UserBattleRoomDetails.fromJson(Map.from(data['user3'] ?? {})),
        user4: UserBattleRoomDetails.fromJson(Map.from(data['user4'] ?? {})),
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
