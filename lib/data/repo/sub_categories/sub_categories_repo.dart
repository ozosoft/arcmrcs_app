import 'package:flutter_prime/core/utils/method.dart';
import 'package:flutter_prime/core/utils/url_container.dart';
import 'package:flutter_prime/data/model/global/response_model/response_model.dart';
import 'package:flutter_prime/data/services/api_service.dart';

class SubCategoriesRepo {
  ApiClient apiClient;
  SubCategoriesRepo({required this.apiClient});

  Future<ResponseModel> getData(String subcategoryId) async {
    String url = "${UrlContainer.baseUrl}${UrlContainer.subcategoriesUrl+subcategoryId}";
    print('all categories=====>: ${subcategoryId}');
    ResponseModel model =
        await apiClient.request(url, Method.getMethod, null, passHeader: true);

    return model;
  }
}
