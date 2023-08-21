import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter_prime/data/model/quiz/quiz_list_model.dart';
import 'package:flutter_prime/view/components/snack_bar/show_custom_snackbar.dart';
import 'package:get/get.dart';

import '../../../core/helper/battle_room_helper.dart';
import '../../../core/route/route.dart';
import '../../../core/utils/internet_connectivity.dart';
import '../../model/battle/battleRoom.dart';
import '../../model/battle/battle_room_exeption.dart';
import '../../model/battle/userBattleRoomDetails.dart';

enum RoomCreateState {
  none,
  creatingRoom,
  roomCreated,
  failed,
  roomFound,
  roomNotFound,
}

enum JoinRoomState {
  none,
  joining,
  joined,
  aleadyJoined,
  failed,
  full,
}

enum UserFoundState {
  none,
  found,
  notFound,
  left,
}

enum BattleGameState {
  notStartede,
  started,
  end,
  error,
}

class BattleRoomController extends GetxController {
  StreamSubscription<DocumentSnapshot>? _battleRoomStreamSubscription;
  StreamSubscription<DocumentSnapshot>? get battleRoomStreamSubscription =>
      _battleRoomStreamSubscription;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  get firebaseFirestore => _firebaseFirestore;
  Rx<RoomCreateState> roomCreateState = RoomCreateState.none.obs;
  Rx<JoinRoomState> joinRoomState = JoinRoomState.none.obs;
  Rx<UserFoundState> userFoundState = UserFoundState.none.obs;

  final Random _rnd = Random.secure();

  Rx<BattleRoom?> battleRoomData = Rx<BattleRoom?>(null);

  var questionsData =
      quizListModelFromJson(jsonEncode(BattleRoomHelper.demoQuestionList));

// Random Room COde
  String generateRoomCode(int length) => String.fromCharCodes(Iterable.generate(
      length,
      (_) => BattleRoomHelper.roomCodeGenerateCharacters.codeUnitAt(
          _rnd.nextInt(BattleRoomHelper.roomCodeGenerateCharacters.length))));

  toogleBattleCreatedState(RoomCreateState value) {
    roomCreateState.value = value;
    update();
  }

  toogleBattleJoinedeState(JoinRoomState value) {
    joinRoomState.value = value;
    update();
  }

  toogleUserFoundState(UserFoundState value) {
    userFoundState.value = value;
    update();
  }

// Craete A Room
  void createNewRoom(
      {required String categoryId,
      String? name,
      String? profileUrl,
      String? uid,
      int? entryFee,
      required bool shouldGenerateRoomCode}) async {
    try {
      toogleBattleCreatedState(RoomCreateState.creatingRoom);
      print("From Create Room");

      String roomCode = "";
      if (shouldGenerateRoomCode) {
        roomCode = generateRoomCode(6);
      }
      print("Room Code $roomCode");

      final DocumentSnapshot craeteNewRoomSnapshot =
          await createBattleRoomFirebase(
        categoryId: categoryId,
        name: name!,
        profileUrl: profileUrl!,
        uid: uid!,
        roomCode: roomCode,
        roomType: "public",
        entryFee: entryFee,
      );

      BattleRoom.fromDocumentSnapshot(craeteNewRoomSnapshot);

      subscribeToBattleRoom(
          craeteNewRoomSnapshot.id, questionsData.data.questions, false);
    } catch (e) {
      toogleBattleCreatedState(RoomCreateState.failed);
      print(e.toString());
      throw BattleRoomException(errorMessageCode: e.toString());
    }
  }

  //subscribe battle room
  void subscribeToBattleRoom(String battleRoomDocumentId,
      List<Question> questions, bool forMultiUser) {
    //for realtimeness
    _battleRoomStreamSubscription =
        subscribeToBattleRoomFirebase(battleRoomDocumentId, forMultiUser)
            .listen((event) {
      if (event.exists) {
        //emit new state
        BattleRoom battleRoom = BattleRoom.fromDocumentSnapshot(event);

        bool? userNotFound = battleRoom.user2?.uid.isEmpty;

        print(battleRoom);

        //if opponent userId is empty menas we have not found any user
        if (userNotFound == true) {
          print("User Not Found ${userFoundState.value}");

          if (userFoundState.value == UserFoundState.found) {
            print("One of the user left the room");
          }
          //Room Created
          battleRoomData.value = battleRoom;
          if (roomCreateState.value != RoomCreateState.roomCreated) {
            toogleBattleCreatedState(RoomCreateState.roomCreated);
          }
        } else {
          battleRoomData.value = battleRoom;
          print("User Found ${joinRoomState.value}");

          if (joinRoomState.value != JoinRoomState.aleadyJoined) {
            if (joinRoomState.value != JoinRoomState.joined) {
              toogleBattleJoinedeState(JoinRoomState.joined);
              toogleUserFoundState(UserFoundState.found);
            }
          }
          if (joinRoomState.value != JoinRoomState.aleadyJoined &&
              battleRoom.readyToPlay == true) {
            print("called from here to quiz page");
            Get.back();
            Get.toNamed(
              RouteHelper.battleQuizQuestionsScreen,
              arguments: ["Quiz DEmo ${joinRoomState.value}", questions],
            );
            toogleBattleJoinedeState(JoinRoomState.aleadyJoined);
          }
        }
      } else {
        if (userFoundState.value != UserFoundState.found) {
          print("Creator of the user left the room");
          Get.back();
          print("Delete Room Close PopUp");
        }

        if (userFoundState.value == UserFoundState.found) {
          print("Delete Room Close PopUp");
          print("One of the user left the room");
          toogleUserFoundState(UserFoundState.left);
          Get.back();
        }
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
      toogleBattleCreatedState(RoomCreateState.failed);
      toogleBattleJoinedeState(JoinRoomState.failed);
      toogleUserFoundState(UserFoundState.none);
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
      print(roomCode);
      toogleBattleJoinedeState(JoinRoomState.joining);
      final result = await joinBattleRoomFrd(
        name: name,
        profileUrl: profileUrl,
        roomCode: roomCode,
        uid: uid,
        currentCoin: int.parse(currentCoin),
      );
      print(result['questions']);
      subscribeToBattleRoom(
        result['roomId'],
        result['questions'],
        false,
      );
    } catch (e) {
      print("Join BattleFailureError ${e.toString()}");
      // emit(BattleRoomFailure(e.toString()));
      toogleBattleJoinedeState(JoinRoomState.failed);
      if (e.toString() == "roomIsFullCode") {
        toogleBattleJoinedeState(JoinRoomState.full);
        CustomSnackBar.error(errorList: ["Sorry! Room Is Full"]);
      } else {
        CustomSnackBar.error(errorList: ["${e.toString()}"]);
      }
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
              as Map<String, dynamic>)['readyToPlay'] ==
          true) {
        throw BattleRoomException(errorMessageCode: "gameStartedCode");
      }

      //not enough coins
      if ((querySnapshot.docs.first.data()
              as Map<String, dynamic>)['entryFee'] >
          currentCoin) {
        throw BattleRoomException(errorMessageCode: "notEnoughCoinsCode");
      }

      // print("GetSomeData ${questionsData.data.toJson()}");

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
        return {
          "roomId": documentSnapshot.id,
          "questions": questionsData.data.questions
        };
      });
    } catch (e) {
      throw BattleRoomException(errorMessageCode: e.toString());
    }
  }

  Future<void> startBattleQuiz(String? battleRoomDocumentId, String battle,
      {bool readyToPlay = true}) async {
    try {
      updateMultiUserRoom(
          battleRoomDocumentId, {"readyToPlay": readyToPlay}, battle);
    } catch (e) {}
  }

// Start Main Search Random Battle room

  void randomSearchRoom({
    required String categoryId,
    required String name,
    required String profileUrl,
    required String uid,
  }) async {
    try {
      List<DocumentSnapshot> documents = await randomSearchBattleRoom(
        categoryId: categoryId,
        name: name,
        profileUrl: profileUrl,
        uid: uid,
      );

      if (documents.isNotEmpty) {
        //find any random room
        DocumentSnapshot room =
            documents[Random.secure().nextInt(documents.length)];
        // emit(BattleRoomJoining());

        // List<Question> questions = await _battleRoomRepository.getQuestions(
        //   categoryId: categoryId,
        //   matchId: room.id,
        //   forMultiUser: false,
        //   roomDocumentId: room.id,
        //   languageId: questionLanguageId,
        //   roomCreater: false,
        //   destroyBattleRoom: "0",
        // );

        final searchAgain = await randomJoinBattleRoom(
            battleRoomDocumentId: room.id,
            name: name,
            profileUrl: profileUrl,
            uid: uid);
        if (searchAgain) {
          //if user falis to join room then searchAgain
          randomSearchRoom(
            categoryId: categoryId,
            name: name,
            profileUrl: profileUrl,
            uid: uid,
          );
        } else {
          subscribeToBattleRoom(room.id, questionsData.data.questions, false);
        }
      } else {
        createNewRoom(
            categoryId: categoryId,
            entryFee: 5,
            name: name,
            profileUrl: profileUrl,
            shouldGenerateRoomCode: false,
            uid: uid);
      }
    } catch (e) {
      // emit(BattleRoomFailure(e.toString()));
    }
  }

  //to join battle room (one to one)
  Future<bool> randomJoinBattleRoom(
      {String? battleRoomDocumentId,
      String? name,
      String? profileUrl,
      String? uid}) async {
    try {
      return await joinBattleRoomFirebase(
        battleRoomDocumentId: battleRoomDocumentId,
        name: name,
        profileUrl: profileUrl,
        uid: uid,
      );
    } catch (e) {
      throw BattleRoomException(errorMessageCode: e.toString());
    }
  }

  //search battle room
  Future<List<DocumentSnapshot>> randomSearchBattleRoom({
    required String categoryId,
    required String name,
    required String profileUrl,
    required String uid,
  }) async {
    try {
      final documents = await searchBattleRoom(categoryId);

      //if room is created by user who is searching the room then delete room
      //so user will not join room that was created by him/her self
      int index = documents.indexWhere((element) =>
          (element.data() as Map<String, dynamic>)['createdBy'] == uid);
      if (index != -1) {
        deleteBattleRoom(documents[index].id, false);
        documents.removeAt(index);
      }
      return documents;
    } catch (e) {
      throw BattleRoomException(errorMessageCode: e.toString());
    }
  }

  UserBattleRoomDetails getOpponentUserDetails(String currentUserId) {
    if (userFoundState.value == UserFoundState.found) {
      if (currentUserId == battleRoomData.value!.user1?.uid) {
        print(battleRoomData.value!.user2!);
        return (battleRoomData.value!.user2!);
      } else {
        return (battleRoomData.value!.user1!);
      }
    }
    return UserBattleRoomDetails(
        points: 0,
        answers: [],
        correctAnswers: 0,
        name: "name",
        profileUrl: "profileUrl",
        uid: "uid");
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
  }) async {
    try {
      //hasLeft,categoryId
      DocumentReference documentReference = await _firebaseFirestore
          .collection(BattleRoomHelper.battleroomCollection)
          .add({
        "createdBy": uid,
        "categoryId": categoryId,
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

//to create room to play quiz
  Future<bool> joinBattleRoomFirebase(
      {String? name,
      String? profileUrl,
      String? uid,
      String? battleRoomDocumentId}) async {
    try {
      DocumentReference documentReference = (await _firebaseFirestore
              .collection(BattleRoomHelper.battleroomCollection)
              .doc(battleRoomDocumentId)
              .get())
          .reference;
      print("Join user here ");
      return FirebaseFirestore.instance.runTransaction((transaction) async {
        //get latest document
        DocumentSnapshot documentSnapshot = await documentReference.get();
        Map user2Details =
            Map.from(documentSnapshot.data() as Map<String, dynamic>)['user2'];
        print("User 2 : $user2Details");
        if (user2Details['uid'].toString().isEmpty) {
          //print("Join user");
          //join as user2
          transaction.update(documentReference, {
            "user2.name": name,
            "user2.uid": uid,
            "user2.profileUrl": profileUrl,
          });
          return false;
        }
        return true; //search for other room
      });
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
    } else {
      return _firebaseFirestore
          .collection(BattleRoomHelper.battleroomCollection)
          .doc(battleRoomDocumentId)
          .snapshots();
    }
  }

  //delete battle room
  Future<void> deleteBattleRoom(String? documentId, bool forMultiUser,
      {String? roomCode}) async {
    try {
      if (forMultiUser) {
        await _firebaseFirestore
            .collection(BattleRoomHelper.battleroomCollectionMulti)
            .doc(documentId)
            .delete();
      } else {
        await _firebaseFirestore
            .collection(BattleRoomHelper.battleroomCollection)
            .doc(documentId)
            .delete();
      }
    } on SocketException catch (_) {
      throw BattleRoomException(errorMessageCode: _.toString());
    } on PlatformException catch (_) {
      throw BattleRoomException(errorMessageCode: _.toString());
    } catch (_) {
      throw BattleRoomException(errorMessageCode: _.toString());
    }
  }

  //Search Room
  Future<List<DocumentSnapshot>> searchBattleRoom(String categoryId) async {
    try {
      QuerySnapshot querySnapshot;
      if (await InternetConnectivity.isUserOffline()) {
        throw SocketException("");
      }

      querySnapshot = await _firebaseFirestore
          .collection(BattleRoomHelper.battleroomCollection)
          .where("categoryId", isEqualTo: categoryId)
          .where("roomCode", isEqualTo: "")
          .where(
            "user2.uid",
            isEqualTo: "",
          )
          .get();

      return querySnapshot.docs;
    } on SocketException catch (_) {
      throw BattleRoomException(errorMessageCode: _.toString());
    } on PlatformException catch (_) {
      throw BattleRoomException(errorMessageCode: _.toString());
    } catch (_) {
      throw BattleRoomException(errorMessageCode: _.toString());
    }
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

  //delete user from multiple user room
  Future<void> updateMultiUserRoom(String? documentId,
      Map<String, dynamic> updatedData, String battle) async {
    try {
      _firebaseFirestore
          .collection(battle == "battle"
              ? BattleRoomHelper.battleroomCollection
              : BattleRoomHelper.battleroomCollectionMulti)
          .doc(documentId)
          .update(updatedData);
    } on SocketException catch (_) {
      throw BattleRoomException(errorMessageCode: _.toString());
    } on PlatformException catch (_) {
      throw BattleRoomException(errorMessageCode: _.toString());
    } catch (_) {
      throw BattleRoomException(errorMessageCode: _.toString());
    }
  }

//submit anser

  Future saveAnswer(String? currentUserId, Map submittedAnswer,
      bool isCorrectAnswer, int points,
      {List<Question>? questionsList}) async {
    BattleRoom battleRoom = battleRoomData.value!;
    List<Question>? questions = questionsList;

    //need to check submitting answer for user1 or user2
    if (currentUserId == battleRoom.user1!.uid) {
      if (battleRoom.user1!.answers.length != questions!.length) {
        submitAnswerHandle(
          battleRoomDocumentId: battleRoom.roomId,
          points: isCorrectAnswer
              ? (battleRoom.user1!.points + points)
              : battleRoom.user1!.points,
          forUser1: true,
          submittedAnswer: List.from(battleRoom.user1!.answers)
            ..add(submittedAnswer),
        );
      }
    } else {
      //submit answer for user2
      if (battleRoom.user2!.answers.length != questions!.length) {
        submitAnswerHandle(
          submittedAnswer: List.from(battleRoom.user2!.answers)
            ..add(submittedAnswer),
          battleRoomDocumentId: battleRoom.roomId,
          points: isCorrectAnswer
              ? (battleRoom.user2!.points + points)
              : battleRoom.user2!.points,
          forUser1: false,
        );
      }
    }
  }

  Future submitAnswer(String? currentUserId, String? submittedAnswer,
      bool isCorrectAnswer, int points,
      {List<Question>? questionsList}) async {
    BattleRoom battleRoom = battleRoomData.value!;
    List<Question>? questions = questionsList;

    //need to check submitting answer for user1 or user2
    if (currentUserId == battleRoom.user1!.uid) {
      if (battleRoom.user1!.answers.length != questions!.length) {
        submitAnswerHandle(
          battleRoomDocumentId: battleRoom.roomId,
          points: isCorrectAnswer
              ? (battleRoom.user1!.points + points)
              : battleRoom.user1!.points,
          forUser1: true,
          submittedAnswer: List.from(battleRoom.user1!.answers)
            ..add(submittedAnswer),
        );
      }
    } else {
      //submit answer for user2
      if (battleRoom.user2!.answers.length != questions!.length) {
        submitAnswerHandle(
          submittedAnswer: List.from(battleRoom.user2!.answers)
            ..add(submittedAnswer),
          battleRoomDocumentId: battleRoom.roomId,
          points: isCorrectAnswer
              ? (battleRoom.user2!.points + points)
              : battleRoom.user2!.points,
          forUser1: false,
        );
      }
    }
  }

//submit answer and update correct answer count and points
  Future<void> submitAnswerHandle(
      {required bool forUser1,
      List? submittedAnswer,
      String? battleRoomDocumentId,
      int? points}) async {
    try {
      Map<String, dynamic> submitAnswer = {};
      if (forUser1) {
        submitAnswer
            .addAll({"user1.answers": submittedAnswer, "user1.points": points});
      } else {
        submitAnswer
            .addAll({"user2.answers": submittedAnswer, "user2.points": points});
      }
      await submitAnswerToFirebase(
          battleRoomDocumentId: battleRoomDocumentId,
          submitAnswer: submitAnswer,
          forMultiUser: false);
    } catch (e) {}
  }

  Future<void> saveAnswerHandle(
      {required bool forUser1,
      List? submittedAnswer,
      String? battleRoomDocumentId,
      int? points}) async {
    try {
      Map<String, dynamic> submitAnswer = {};
      if (forUser1) {
        submitAnswer
            .addAll({"user1.answers": submittedAnswer, "user1.points": points});
      } else {
        submitAnswer
            .addAll({"user2.answers": submittedAnswer, "user2.points": points});
      }
      await submitAnswerToFirebase(
          battleRoomDocumentId: battleRoomDocumentId,
          submitAnswer: submitAnswer,
          forMultiUser: false);
    } catch (e) {}
  }

//submit answer
  Future<void> submitAnswerToFirebase(
      {required Map<String, dynamic> submitAnswer,
      String? battleRoomDocumentId,
      required bool forMultiUser}) async {
    try {
      if (forMultiUser) {
        await _firebaseFirestore
            .collection(BattleRoomHelper.battleroomCollectionMulti)
            .doc(battleRoomDocumentId)
            .update(submitAnswer);
      } else {
        await _firebaseFirestore
            .collection(BattleRoomHelper.battleroomCollection)
            .doc(battleRoomDocumentId)
            .update(submitAnswer);
      }
    } on SocketException catch (_) {
      throw BattleRoomException(errorMessageCode: _.toString());
    } on PlatformException catch (_) {
      throw BattleRoomException(errorMessageCode: _.toString());
    } catch (_) {
      throw BattleRoomException(errorMessageCode: _.toString());
    }

    @override
    void onClose() {
      _battleRoomStreamSubscription?.cancel();
      super.onClose();
    }
  }
}
