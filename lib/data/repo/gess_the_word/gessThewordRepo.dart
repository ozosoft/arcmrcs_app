import 'dart:developer';

import 'package:flutter_prime/core/utils/method.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/core/utils/url_container.dart';
import 'package:flutter_prime/data/model/global/response_model/response_model.dart';
import 'package:flutter_prime/data/services/api_service.dart';

class GessTheWordRepo {
  ApiClient apiClient;
  GessTheWordRepo({required this.apiClient});
  // get questionlist
  Future<dynamic> getwordcatagroiList() async {
    try {
      String url = '${UrlContainer.baseUrl}${UrlContainer.gessTheword}${UrlContainer.catagoriList}';
      ResponseModel responseModel = await apiClient.request(url, Method.getMethod, null, passHeader: true);
      return responseModel;
    } catch (e) {
      return ResponseModel(false, MyStrings.somethingWentWrong, 300, '');
    }
  }

  Future<dynamic> getwordSubCatagroiList(String id) async {
    try {
      String url = '${UrlContainer.baseUrl}${UrlContainer.gessTheword}${UrlContainer.subCatagoriList}$id';
      ResponseModel responseModel = await apiClient.request(url, Method.getMethod, null, passHeader: true);
      return responseModel;
    } catch (e) {
      return ResponseModel(false, MyStrings.somethingWentWrong, 300, '');
    }
  }

  Future<dynamic> getwordQuestionList(String id) async {
    try {
      String url = '${UrlContainer.baseUrl}${UrlContainer.gessTheword}${UrlContainer.questionList}$id';
      ResponseModel responseModel = await apiClient.request(url, Method.getMethod, null, passHeader: true);
      return responseModel;
    } catch (e) {
      return ResponseModel(false, MyStrings.somethingWentWrong, 300, '');
    }
  }
}
