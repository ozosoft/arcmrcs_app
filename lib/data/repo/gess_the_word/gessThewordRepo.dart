import 'dart:developer';

import 'package:flutter_prime/core/utils/method.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/core/utils/url_container.dart';
import 'package:flutter_prime/data/model/global/response_model/response_model.dart';
import 'package:flutter_prime/data/services/api_service.dart';
import 'package:get/get.dart';

class GuessTheWordRepo {
  ApiClient apiClient;
  GuessTheWordRepo({required this.apiClient});
  // get questionlist
  Future<dynamic> getwordcategoryList() async {
    try {
      String url = '${UrlContainer.baseUrl}${UrlContainer.guessTheword}${UrlContainer.categoryList}';
      ResponseModel responseModel = await apiClient.request(url, Method.getMethod, null, passHeader: true);
      return responseModel;
    } catch (e) {
      return ResponseModel(false, MyStrings.somethingWentWrong.tr, 300, '');
    }
  }

  Future<dynamic> getwordSubCatagroiList(String id) async {
    try {
      String url = '${UrlContainer.baseUrl}${UrlContainer.guessTheword}${UrlContainer.subCategoryList}$id';
      ResponseModel responseModel = await apiClient.request(url, Method.getMethod, null, passHeader: true);
      return responseModel;
    } catch (e) {
      return ResponseModel(false, MyStrings.somethingWentWrong.tr, 300, '');
    }
  }

  Future<dynamic> getwordQuestionList(String id) async {
    try {
      String url = '${UrlContainer.baseUrl}${UrlContainer.guessTheword}${UrlContainer.questionList}$id';
      ResponseModel responseModel = await apiClient.request(url, Method.getMethod, null, passHeader: true);
      return responseModel;
    } catch (e) {
      return ResponseModel(false, MyStrings.somethingWentWrong.tr, 300, '');
    }
  }

  Future<dynamic> submitAnswar(Map<String, dynamic> map) async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.guessTheword}${UrlContainer.gesswordSubmit}';
    log(url, name: 'submit ans');
    ResponseModel model = await apiClient.request(url, Method.postMethod, map, passHeader: true);
    return model;
  }
}
