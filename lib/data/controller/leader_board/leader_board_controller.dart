import 'dart:convert';
import 'package:flutter_prime/data/model/leaderBoard/leaderBoard_model.dart';
import 'package:flutter_prime/data/repo/leaderBoard/leaderBoard_repo.dart';
import 'package:get/get.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/data/model/global/response_model/response_model.dart';
import 'package:flutter_prime/view/components/snack_bar/show_custom_snackbar.dart';

class LeaderBoardController extends GetxController {
  LeaderBoardRepo leaderBoardRepo;

  LeaderBoardController({required this.leaderBoardRepo});

  List<User> leaderBoardlist = [];

  String rank1PlayerName = "";
  String rank2PlayerName = "";
  String rank3PlayerName = "";
  String rank1PlayerScore = "";
  String rank2PlayerScore = "";
  String rank3PlayerScore = "";
  String rank1PlayerAvatar = "";
  String rank2PlayerAvatar = "";
  String rank3PlayerAvatar = "";

  bool loader = true;

  bool isActive = false;

  void getdata() async {
    loader = true;
    update();

    ResponseModel model = await leaderBoardRepo.getLeaderBoardData();

    if (model.statusCode == 200) {
      leaderBoardlist.clear();

      LeaderBoardModel leaderBoardModel = LeaderBoardModel.fromJson(jsonDecode(model.responseJson));

      if (leaderBoardModel.status.toString().toLowerCase() == MyStrings.success.toLowerCase()) {
        List<User>? leaderBoardList = leaderBoardModel.data?.user;

        if (leaderBoardList != null && leaderBoardList.isNotEmpty) {
          leaderBoardlist.addAll(leaderBoardList);
        }
        rank1PlayerName = leaderBoardModel.data!.user![0].username!;
        rank2PlayerName = leaderBoardModel.data!.user![1].username!;
        rank3PlayerName = leaderBoardModel.data!.user![2].username!;
        rank1PlayerScore = leaderBoardModel.data!.user![0].score!;
        rank2PlayerScore = leaderBoardModel.data!.user![1].score!;
        rank3PlayerScore = leaderBoardModel.data!.user![2].score!;
        rank1PlayerAvatar = leaderBoardModel.data!.user![0].avatar!;
        rank2PlayerAvatar = leaderBoardModel.data!.user![1].avatar!??"";
        rank2PlayerAvatar = leaderBoardModel.data!.user![2].avatar!;
      } else {
        CustomSnackBar.error(errorList: [leaderBoardModel.status ?? ""]);
      }
    } else {
      CustomSnackBar.error(errorList: [model.message]);
    }

    print('---------------------${model.statusCode}');

    loader = false;
    update();
  }

  changeactivestatus() {
    isActive = !isActive;
    update();
  }
}
