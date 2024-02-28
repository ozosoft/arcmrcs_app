import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quiz_lab/data/model/coin_history/coin_history_model.dart';
import 'package:quiz_lab/data/repo/coin_history/coin_history_repo.dart';
import 'package:get/get.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/data/model/global/response_model/response_model.dart';
import 'package:quiz_lab/view/components/alert-dialog/custom_alert_dialog.dart';
import 'package:quiz_lab/view/components/snack_bar/show_custom_snackbar.dart';

class CoinHistoryController extends GetxController {
  CoinHistoryRepo coinHistoryRepo;

  CoinHistoryController({required this.coinHistoryRepo});

  String rank = "";

  List<CoinLog> coinHistoryList = [];
  List<CoinLog> originalCoinHistoryList = [];
  List filterOptionList = [];

  bool loader = true;

  String selectedFilteredValue = "";

  bool isActive = false;

  getdata() async {
    loader = true;
    filterOptionList.clear();
    update();

    filterOptionList.addAll(["All", "+", "-"]);
    print("this is filter options $filterOptionList");

    ResponseModel model = await coinHistoryRepo.coinHistoryData();

    if (model.statusCode == 200) {
      coinHistoryList.clear();
      CoinHistoryModel coinPlanModel = CoinHistoryModel.fromJson(jsonDecode(model.responseJson));

      if (coinPlanModel.status.toString().toLowerCase() == MyStrings.success.toLowerCase()) {
        List<CoinLog>? coinHistory = coinPlanModel.data?.coinLogs;

        if (coinHistory != null && coinHistory.isNotEmpty) {
          coinHistoryList.addAll(coinHistory);
          originalCoinHistoryList = List.from(coinHistoryList);
        }
      } else {
        CustomSnackBar.error(errorList: [...coinPlanModel.message!.error!]);
      }
    } else {
      CustomSnackBar.error(errorList: [model.message]);
    }

    debugPrint('---------------------${model.statusCode}');

    loader = false;
    update();
  }

  filterdList() {
    if (selectedFilteredValue == "+") {
      coinHistoryList = coinHistoryList.where((item) => item.status == "+").toList();
      Get.back();
      update();
      print("this is plus filter $coinHistoryList");
    } else if (selectedFilteredValue == "-") {
      coinHistoryList = coinHistoryList.where((item) => item.status == "-").toList();
      Get.back();
      update();
      print("this is minus filter $coinHistoryList");
    } else {
      coinHistoryList = List.from(originalCoinHistoryList);
      Get.back();
      update();
    }
  }

  changeactivestatus() {
    isActive = !isActive;
    update();
  }
}
