import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_prime/core/helper/shared_preference_helper.dart';
import 'package:flutter_prime/core/utils/method.dart';
import 'package:flutter_prime/core/utils/url_container.dart';
import 'package:flutter_prime/data/model/auth/sign_up_model/sign_up_model.dart';
import 'package:flutter_prime/data/model/global/response_model/response_model.dart';
import 'package:flutter_prime/data/services/api_service.dart';

class RegistrationRepo {
  ApiClient apiClient;

  RegistrationRepo({required this.apiClient});

  Future<ResponseModel> registerUser(SignUpModel model) async {
    final map = modelToMap(model);
    String url = '${UrlContainer.baseUrl}${UrlContainer.registrationEndPoint}';
    ResponseModel responseModel = await apiClient.request(url, Method.postMethod, map, passHeader: true, isOnlyAcceptType: true);

    return responseModel;
  }

  Map<String, dynamic> modelToMap(SignUpModel model) {
    Map<String, dynamic> bodyFields = {
      
       'username': model.username.toString(),
      
      'password': model.password.toString(),
      'password_confirmation': model.password.toString(),
     'email': model.email.toString(),
    };

    print("++++++++++++++++++hey========================="+model.email);

    return bodyFields;
  }

  // Future<dynamic> getCountryList() async {
  //   String url = '${UrlContainer.baseUrl}${UrlContainer.countryEndPoint}';
  //   ResponseModel model = await apiClient.request(url, Method.getMethod, null);
  //   return model;
  // }

  Future<bool> sendUserToken() async {
    String deviceToken;
    if (apiClient.sharedPreferences.containsKey(SharedPreferenceHelper.fcmDeviceKey)) {
      deviceToken = apiClient.sharedPreferences.getString(SharedPreferenceHelper.fcmDeviceKey) ?? '';
    } else {
      deviceToken = '';
    }

    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    bool success = false;
    if (deviceToken.isEmpty) {
      firebaseMessaging.getToken().then((fcmDeviceToken) async {
        success = await sendUpdatedToken(fcmDeviceToken ?? '');
      });
    } else {
      firebaseMessaging.onTokenRefresh.listen((fcmDeviceToken) async {
        if (deviceToken == fcmDeviceToken) {
          success = true;
        } else {
          apiClient.sharedPreferences.setString(SharedPreferenceHelper.fcmDeviceKey, fcmDeviceToken);
          success = await sendUpdatedToken(fcmDeviceToken);
        }
      });
    }
    return success;
  }

  Future<bool> sendUpdatedToken(String deviceToken) async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.deviceTokenEndPoint}';
    Map<String, String> map = deviceTokenMap(deviceToken);

    await apiClient.request(url, Method.postMethod, map, passHeader: true);
    return true;
  }

  Map<String, String> deviceTokenMap(String deviceToken) {
    Map<String, String> map = {'token': deviceToken.toString()};
    return map;
  }
}
