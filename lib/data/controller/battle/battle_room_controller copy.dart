import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter_prime/data/model/quiz/quiz_list_model.dart';
import 'package:get/get.dart';

import '../../../core/helper/battle_room_helper.dart';
import '../../model/battle/battleRoom.dart';
import '../../model/battle/battle_room_exeption.dart';

enum RoomCreateState {
  none,
  creatingRoom,
  joiningRoom,
  roomFound,
  roomNotFound,
}

enum JoinRoomState {
  none,
  joining,
  joined,
  failed,
}

class BattleRoomController extends GetxController {
  StreamSubscription<DocumentSnapshot>? _battleRoomStreamSubscription;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Rx<RoomCreateState> roomCreateState = RoomCreateState.none.obs;
  Rx<JoinRoomState> roinRoomState = JoinRoomState.none.obs;

  final Random _rnd = Random.secure();
  final isBattleRoomCreated = false.obs;
  final isBattleRoomJoined = false.obs;

  Rx<BattleRoom?> battleRoomData = Rx<BattleRoom?>(null);
  var questionsData =
      quizListModelFromJson(jsonEncode(BattleRoomHelper.demoQuestionList));

  // Other methods from your BattleRoomCubit class...

  String generateRoomCode(int length) => String.fromCharCodes(Iterable.generate(
      length,
      (_) => BattleRoomHelper.roomCodeGenerateCharacters.codeUnitAt(
          _rnd.nextInt(BattleRoomHelper.roomCodeGenerateCharacters.length))));

  toogleBattleCreatedData(bool value) {
    isBattleRoomCreated.value = value;
    update();
  }

  toogleBattleJoinedeData(bool value) {
    isBattleRoomJoined.value = value;
    update();
  }

  void createRoom(
      {required String categoryId,
      String? name,
      String? profileUrl,
      String? uid,
      int? entryFee,
      String? questionLanguageId,
      required bool shouldGenerateRoomCode}) async {
    try {
      print("Frrom Craete Rooom");
      String roomCode = "";
      if (shouldGenerateRoomCode) {
        roomCode = generateRoomCode(6);
      }
      print("Room Code $roomCode");
      final DocumentSnapshot documentSnapshot = await createBattleRoomFirebase(
        categoryId: categoryId,
        name: name!,
        profileUrl: profileUrl!,
        uid: uid!,
        roomCode: roomCode,
        roomType: "public",
        entryFee: entryFee,
        questionLanguageId: questionLanguageId!,
      );

      // print("documentSnapshot $documentSnapshot");
      BattleRoom.fromDocumentSnapshot(documentSnapshot);

      subscribeToBattleRoom(
          documentSnapshot.id, questionsData.data.questions, false);
      // isBattleRoomCreated.value = true;
      update();
    } catch (e) {}
  }

  //subscribe battle room
  void subscribeToBattleRoom(String battleRoomDocumentId,
      List<Question> questions, bool forMultiUser) {
    //for realtimeness
    _battleRoomStreamSubscription =
        subscribeToBattleRoomFirebase(battleRoomDocumentId, forMultiUser)
            .listen((event) {
      print(event);

      if (event.exists) {
        //emit new state
        BattleRoom battleRoom = BattleRoom.fromDocumentSnapshot(event);

        bool? userNotFound = battleRoom.user2?.uid.isEmpty;
        print(userNotFound);

        //if opponent userId is empty menas we have not found any user
        if (userNotFound == true) {
          print("USer Not Found");
          //if currentRoute is not battleRoomOpponent and battle room created then we
          //have to delete the room so other user can not join the room

          //If roomCode is empty means room is created for playing random battle
          //else room is created for play with friend battle
          // if (Routes.currentRoute != Routes.battleRoomFindOpponent &&
          //     battleRoom.roomCode!.isEmWpty) {
          //   deleteBattleRoom(false);
          // }
          isBattleRoomCreated.value = true;
          battleRoomData.value = battleRoom;

          update();
          //if user not found yet
          // emit(BattleRoomCreated(battleRoom));
        } else {
          isBattleRoomJoined.value = true;
          battleRoomData.value = battleRoom;
          update();
          print("User Found");
          // emit(BattleRoomUserFound(
          //   battleRoom: battleRoom,
          //   isRoomExist: true,
          //   questions: questions,
          //   hasLeft: false,
          // ));
        }
      } else {
        // if (state is BattleRoomUserFound) {
        //   print("One of the user left the room");

        //   //if one of the user has left the game while playing
        //   emit(
        //     BattleRoomUserFound(
        //         battleRoom: (state as BattleRoomUserFound).battleRoom,
        //         hasLeft: true,
        //         isRoomExist: false,
        //         questions: (state as BattleRoomUserFound).questions),
        //   );
        // }
      }
    }, onError: (e) {
      // emit(BattleRoomFailure(defaultErrorMessageCode));
    }, cancelOnError: true);
  }

//to join battle room
  void joinRoom(
      {String? name,
      String? profileUrl,
      String? uid,
      String? roomCode,
      required String currentCoin}) async {
    try {
      final result = await joinBattleRoomFrd(
        name: name,
        profileUrl: profileUrl,
        roomCode: roomCode,
        uid: uid,
        currentCoin: int.parse(currentCoin),
      );

      subscribeToBattleRoom(
        result['roomId'],
        result['questions'],
        false,
      );
    } catch (e) {
      print("BattleFailureError${e.toString()}");
      // emit(BattleRoomFailure(e.toString()));
    }
  }

//join multi user battle room
  Future<Map<String, dynamic>> joinBattleRoomFrd(
      {String? name,
      String? profileUrl,
      String? uid,
      String? roomCode,
      int? currentCoin}) async {
    try {
      //verify roomCode is valid or not
      QuerySnapshot querySnapshot =
          await getMultiUserBattleRoomFirebase(roomCode, "battle");

      //invalid room code
      if (querySnapshot.docs.isEmpty) {
        throw BattleRoomException(
            errorMessageCode: "roomCodeInvalidCode"); //invalid roomcode
      }

      //game started code
      if ((querySnapshot.docs.first.data()
          as Map<String, dynamic>)['readyToPlay']) {
        throw BattleRoomException(errorMessageCode: "gameStartedCode");
      }

      //not enough coins
      if ((querySnapshot.docs.first.data()
              as Map<String, dynamic>)['entryFee'] >
          currentCoin) {
        throw BattleRoomException(errorMessageCode: "notEnoughCoinsCode");
      }

      print("GetSomeData ${questionsData}");

      //get roomRef
      DocumentReference documentReference = querySnapshot.docs.first.reference;
      //using transaction so we get latest document before updating roomDocument
      return FirebaseFirestore.instance.runTransaction((transaction) async {
        //get latest document
        DocumentSnapshot documentSnapshot = await documentReference.get();
        Map user2Details =
            Map.from(documentSnapshot.data() as Map<String, dynamic>)['user2'];

        if (user2Details['uid'].toString().isEmpty) {
          //join as user2
          transaction.update(documentReference, {
            "user2.name": name,
            "user2.uid": uid,
            "user2.profileUrl": profileUrl,
          });
        } else {
          //room is full
          throw BattleRoomException(errorMessageCode: "roomIsFullCode");
        }
        return {"roomId": documentSnapshot.id, "questions": questionsData};
      });
    } catch (e) {
      throw BattleRoomException(errorMessageCode: e.toString());
    }
  }

//Firebase Part

  //to create room to play quiz
  Future<DocumentSnapshot> createBattleRoomFirebase({
    required String categoryId,
    required String name,
    required String profileUrl,
    required String uid,
    String? roomCode,
    String? roomType,
    int? entryFee,
    required String questionLanguageId,
  }) async {
    try {
      //hasLeft,categoryId
      DocumentReference documentReference = await _firebaseFirestore
          .collection(BattleRoomHelper.battleroomCollection)
          .add({
        "createdBy": uid,
        "categoryId": categoryId,
        "languageId": questionLanguageId,
        "roomCode": roomCode ?? "",
        "entryFee": entryFee ?? 0,
        "readyToPlay": false,
        "user1": {
          "name": name,
          "points": 0,
          "answers": [],
          "uid": uid,
          "profileUrl": profileUrl
        },
        "user2": {
          "name": "",
          "points": 0,
          "answers": [],
          "uid": "",
          "profileUrl": ""
        },
        "createdAt": Timestamp.now(),
      });
      return await documentReference.get();
    } on SocketException catch (_) {
      throw BattleRoomException(errorMessageCode: _.toString());
    } on PlatformException catch (_) {
      throw BattleRoomException(errorMessageCode: _.toString());
    } catch (_) {
      throw BattleRoomException(errorMessageCode: _.toString());
    }
  }

  //subscribe to battle room
  Stream<DocumentSnapshot> subscribeToBattleRoomFirebase(
      String? battleRoomDocumentId, bool forMultiUser) {
    if (forMultiUser) {
      return _firebaseFirestore
          .collection(BattleRoomHelper.battleroomCollectionMulti)
          .doc(battleRoomDocumentId)
          .snapshots();
    }
    return _firebaseFirestore
        .collection(BattleRoomHelper.battleroomCollection)
        .doc(battleRoomDocumentId)
        .snapshots();
  }

  Future<void> removeOpponentFromBattleRoomFirebase(String roomId) async {
    try {
      await _firebaseFirestore
          .collection(BattleRoomHelper.battleroomCollectionMulti)
          .doc(roomId)
          .update({
        "user2": {
          "name": "",
          "correctAnswers": 0,
          "answers": [],
          "uid": "",
          "profileUrl": ""
        },
      });
    } on SocketException catch (_) {
      throw BattleRoomException(errorMessageCode: _.toString());
    } on PlatformException catch (_) {
      throw BattleRoomException(errorMessageCode: _.toString());
    } catch (_) {
      throw BattleRoomException(errorMessageCode: _.toString());
    }
  }

  //get room by roomCode (multiUserBattleRoom)
  Future<QuerySnapshot> getMultiUserBattleRoomFirebase(
      String? roomCode, String? type) async {
    try {
      QuerySnapshot querySnapshot = await _firebaseFirestore
          .collection(type == "battle"
              ? BattleRoomHelper.battleroomCollection
              : BattleRoomHelper.battleroomCollectionMulti)
          .where("roomCode", isEqualTo: roomCode)
          .get();
      return querySnapshot;
    } on SocketException catch (_) {
      throw BattleRoomException(errorMessageCode: _.toString());
    } on PlatformException catch (_) {
      throw BattleRoomException(errorMessageCode: _.toString());
    } catch (_) {
      throw BattleRoomException(errorMessageCode: _.toString());
    }
  }

  @override
  void onClose() {
    _battleRoomStreamSubscription?.cancel();
    super.onClose();
  }
}
