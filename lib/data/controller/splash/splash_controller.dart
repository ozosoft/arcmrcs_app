import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:quiz_lab/core/utils/messages.dart';
import 'package:quiz_lab/data/controller/localization/localization_controller.dart';
import 'package:get/get.dart';
import 'package:quiz_lab/core/helper/shared_preference_helper.dart';
import 'package:quiz_lab/core/route/route.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/data/model/general_setting/general_setting_response_model.dart';
import 'package:quiz_lab/data/model/global/response_model/response_model.dart';
import 'package:quiz_lab/data/repo/auth/general_setting_repo.dart';
import 'package:quiz_lab/view/components/snack_bar/show_custom_snackbar.dart';

class SplashController extends GetxController {
  GeneralSettingRepo repo;
  LocalizationController localizationController;
  SplashController({required this.repo, required this.localizationController});

  bool isLoading = true;
  gotoNextPage() async {
    await loadLanguage();
    bool isRemember = repo.apiClient.sharedPreferences.getBool(SharedPreferenceHelper.rememberMeKey) ?? false;
    bool isOnBoard = repo.apiClient.sharedPreferences.getBool(SharedPreferenceHelper.onboardKey) ?? false;
    debugPrint("from onboard check ------ $isOnBoard");
    noInternet = false;
    update();

    initSharedData();
    getGSData(isRemember, isOnBoard);
  }

  bool noInternet = false;
  void getGSData(bool isRemember, bool isOnBoard) async {
    ResponseModel response = await repo.getGeneralSetting();
   
    if (response.statusCode == 200) {
      GeneralSettingResponseModel model = GeneralSettingResponseModel.fromJson(jsonDecode(response.responseJson));
      if (model.status?.toLowerCase() == MyStrings.success) {
        repo.apiClient.storeGeneralSetting(model);
         print("this is general settings responses ${model.data}");
      } else {
        List<String> message = [MyStrings.somethingWentWrong.tr];
        CustomSnackBar.error(errorList: model.message?.error ?? message);
      }
    } else {
      if (response.statusCode == 503) {
        noInternet = true;
        update();
      }
      CustomSnackBar.error(errorList: [response.message]);
    }

    isLoading = false;
    update();

    if (isOnBoard == false) {
      Future.delayed(const Duration(seconds: 1), () {
        Get.offAndToNamed(RouteHelper.onboardScreen);
      });
    } else {
      if (isRemember) {
        Future.delayed(const Duration(seconds: 1), () {
          Get.offAndToNamed(RouteHelper.bottomNavBarScreen);
        });
      } else {
        Future.delayed(const Duration(seconds: 1), () {
          Get.offAndToNamed(RouteHelper.loginScreen);
        });
      }
    }
  }

  Future<bool> initSharedData() {
    if (!repo.apiClient.sharedPreferences.containsKey(SharedPreferenceHelper.countryCode)) {
      return repo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.countryCode, localizationController.myLanguages[0].countryCode);
    }
    if (!repo.apiClient.sharedPreferences.containsKey(SharedPreferenceHelper.languageCode)) {
      return repo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.languageCode, localizationController.myLanguages[0].languageCode);
    }
    return Future.value(true);
  }

  Future<void> loadLanguage() async {
    localizationController.loadCurrentLanguage();
    String languageCode = localizationController.locale.languageCode;

    ResponseModel response = await repo.getLanguage(languageCode);
    if (response.statusCode == 200) {
      try {
        Map<String, Map<String, String>> language = {};
        var resJson = jsonDecode(response.responseJson);
        saveLanguageList(response.responseJson);
        var value = resJson['data']['language_data'] == [] ? {} : resJson['data']['language_data'];
        Map<String, String> json = {};
        value.forEach((key, value) {
          json[key] = value.toString();
        });
        language['${localizationController.locale.languageCode}_${localizationController.locale.countryCode}'] = json;
        Get.addTranslations(Messages(languages: language).keys);
      } catch (e) {
        CustomSnackBar.error(errorList: [e.toString()]);
      }
    } else {
      CustomSnackBar.error(errorList: [response.message]);
    }
  }

  void saveLanguageList(String languageJson) async {
    await repo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.languageListKey, languageJson);
    return;
  }
}
