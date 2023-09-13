import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:quiz_lab/data/model/coin_history/coin_history_model.dart';
import 'package:quiz_lab/data/repo/coin_history/coin_history_repo.dart';
import 'package:get/get.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/data/model/global/response_model/response_model.dart';
import 'package:quiz_lab/view/components/snack_bar/show_custom_snackbar.dart';

class CoinHistoryController extends GetxController {
  CoinHistoryRepo coinHistoryRepo;

  CoinHistoryController({required this.coinHistoryRepo});

  String rank = "";

  List<CoinLog> coinHistoryList = [];

  bool loader = true;

  bool isActive = false;

  void getdata() async {
    loader = true;
    update();


    ResponseModel model = await coinHistoryRepo.coinHistoryData();

    if (model.statusCode == 200) {
     coinHistoryList.clear();
      CoinHistoryModel coinPlanModel = CoinHistoryModel.fromJson(jsonDecode(model.responseJson));

      if (coinPlanModel.status.toString().toLowerCase() == MyStrings.success.toLowerCase()) {
      


        List<CoinLog>? coinhistory = coinPlanModel.data?.coinLogs;

        if (coinhistory != null && coinhistory.isNotEmpty) {
          coinHistoryList.addAll(coinhistory);
        }

        
      } else {
        CustomSnackBar.error(errorList: [coinPlanModel.status ?? ""]);
      }
    } else {
      CustomSnackBar.error(errorList: [model.message]);
    }

    debugPrint('---------------------${model.statusCode}');

    loader = false;
    update();
  }

  changeactivestatus() {
    isActive = !isActive;
    update();
  }
}
