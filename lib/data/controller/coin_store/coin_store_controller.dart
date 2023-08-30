import 'dart:convert';
import 'package:flutter_prime/data/model/coin_store/coin_store_model.dart';
import 'package:flutter_prime/data/repo/coin_store/coin_store_repo.dart';
import 'package:get/get.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/data/model/global/response_model/response_model.dart';
import 'package:flutter_prime/view/components/snack_bar/show_custom_snackbar.dart';

class CoinStoreController extends GetxController {
  CoinStoreRepo coinStoreRepo;

  CoinStoreController({required this.coinStoreRepo});

  String rank = "";

  List<CoinPlan> coinPlanList = [];

  bool loader = false;

  bool isActive = false;

  void getdata() async {
    loader = true;
    update();

    ResponseModel model = await coinStoreRepo.coinStoreData();

    if (model.statusCode == 200) {
      CoinStoreModel coinPlanModel = CoinStoreModel.fromJson(jsonDecode(model.responseJson));

      if (coinPlanModel.status.toString().toLowerCase() == MyStrings.success.toLowerCase()) {
        List<CoinPlan>? coinplan = coinPlanModel.data?.coinPlans;

        if (coinplan != null && coinplan.isNotEmpty) {
          coinPlanList.addAll(coinplan);
        }

        loader = false;
        update();
      } else {
        CustomSnackBar.error(errorList: [coinPlanModel.status ?? ""]);
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
