import 'dart:convert';
import 'package:flutter_prime/core/route/route.dart';
import 'package:flutter_prime/data/model/auth/logout/logout_model.dart';

import 'package:flutter_prime/data/repo/auth/logout/logout_repo.dart';

import 'package:get/get.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/data/model/global/response_model/response_model.dart';
import 'package:flutter_prime/view/components/snack_bar/show_custom_snackbar.dart';

class LogoutController extends GetxController {
  LogoutRepo logoutRepo;

  LogoutController({required this.logoutRepo});

  bool loader = true;

  void logout() async {
    loader = true;
    update();

    // getsavedData();

    ResponseModel logout = await logoutRepo.logout();

    if (logout.statusCode == 200) {
      LogoutModel plan = LogoutModel.fromJson(jsonDecode(logout.responseJson));
      if (plan.status.toString().toLowerCase() == MyStrings.ok.toLowerCase()) {
        Get.offAllNamed(RouteHelper.loginScreen);
        print("this is logout");
        update();
      } else {
        CustomSnackBar.error(errorList: [plan.status ?? ""]);
      }
    } else {
      CustomSnackBar.error(errorList: [logout.message]);
    }

    loader = false;
    update();
  }
}
