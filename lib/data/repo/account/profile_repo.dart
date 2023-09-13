import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:quiz_lab/core/utils/method.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/core/utils/url_container.dart';
import 'package:quiz_lab/data/model/authorization/authorization_response_model.dart';
import 'package:quiz_lab/data/model/global/response_model/response_model.dart';
import 'package:quiz_lab/data/model/user_post_model/user_post_model.dart';
import 'package:quiz_lab/data/services/api_service.dart';
import 'package:quiz_lab/view/components/snack_bar/show_custom_snackbar.dart';

class ProfileRepo {
  ApiClient apiClient;

  ProfileRepo({required this.apiClient});

  Future<bool> updateProfile(UserPostModel m, bool isProfile) async {
    try {
      apiClient.initToken();

      String url = '${UrlContainer.baseUrl}${isProfile ? UrlContainer.updateProfileEndPoint : UrlContainer.profileCompleteEndPoint}';

      var request = http.MultipartRequest('POST', Uri.parse(url));
      Map<String, String> finalMap = {
        'firstname': m.firstname!,
        'lastname': m.lastName!,
        'address': m.address ?? '',
        'zip': m.zip ?? '',
        'state': m.state ?? "",
        'city': m.city ?? '',
      };

      request.headers.addAll(<String, String>{'Authorization': 'Bearer ${apiClient.token}'});

      if (m.avatar != null) {
        request.files.add(http.MultipartFile('avatar', m.avatar!.readAsBytes().asStream(), m.avatar!.lengthSync(), filename: m.avatar!.path.split('/').last));
      }
      request.fields.addAll(finalMap);

      http.StreamedResponse response = await request.send();

      String jsonResponse = await response.stream.bytesToString();
      AuthorizationResponseModel model = AuthorizationResponseModel.fromJson(jsonDecode(jsonResponse));

      if (model.status?.toLowerCase() == MyStrings.success.toLowerCase()) {
        CustomSnackBar.success(successList: model.message?.success ?? [MyStrings.success.tr]);
        return true;
      } else {
        CustomSnackBar.error(errorList: model.message?.error ?? [MyStrings.requestFail.tr]);
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<ResponseModel> loadProfileInfo() async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.getProfileEndPoint}';
    ResponseModel responseModel = await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return responseModel;
  }

  Future<bool> updateProfilePicture(File profilePic) async {
    try {
      apiClient.initToken();

      String url = '${UrlContainer.baseUrl}${UrlContainer.updateProfileAvatarEndPoint}';

      var request = http.MultipartRequest('POST', Uri.parse(url));

      request.files.add(http.MultipartFile('avatar', profilePic.readAsBytes().asStream(), profilePic.lengthSync(), filename: profilePic.path.split('/').last));
    
      http.StreamedResponse response = await request.send();

      String jsonResponse = await response.stream.bytesToString();
      AuthorizationResponseModel model = AuthorizationResponseModel.fromJson(jsonDecode(jsonResponse));

      if (model.status?.toLowerCase() == MyStrings.success.toLowerCase()) {
        CustomSnackBar.success(successList: model.message?.success ?? [MyStrings.success.tr]);
        return true;
      } else {
        CustomSnackBar.error(errorList: model.message?.error ?? [MyStrings.requestFail.tr]);
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
