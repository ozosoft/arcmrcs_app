import 'package:flutter/widgets.dart';
import 'package:quiz_lab/core/utils/method.dart';
import 'package:quiz_lab/core/utils/url_container.dart';
import 'package:quiz_lab/data/model/global/response_model/response_model.dart';
import 'package:quiz_lab/data/services/api_client.dart';

class TrueFalseSubCategoriesRepo {
  ApiClient apiClient;
  TrueFalseSubCategoriesRepo({required this.apiClient});

  Future<ResponseModel> getData(String subcategoryId) async {
    String url = "${UrlContainer.baseUrl}${UrlContainer.trueFaleSubcategoriesUrl+subcategoryId}";
    debugPrint('all audio categories=====>: $subcategoryId');
    ResponseModel model =
        await apiClient.request(url, Method.getMethod, null, passHeader: true);

    return model;
  }
}
