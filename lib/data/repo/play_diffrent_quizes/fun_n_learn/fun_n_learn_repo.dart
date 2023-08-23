import 'package:flutter_prime/core/utils/method.dart';
import 'package:flutter_prime/core/utils/url_container.dart';
import 'package:flutter_prime/data/model/global/response_model/response_model.dart';
import 'package:flutter_prime/data/services/api_service.dart';

class FunNLearnRepo {
  ApiClient apiClient;
  FunNLearnRepo({required this.apiClient});

  Future<ResponseModel> getFunAndLearnCategories() async {
    String url = "${UrlContainer.baseUrl}${UrlContainer.funNLearnallCategoryUrl}";
    print('all categories=====>: ${url}');
    ResponseModel model =
        await apiClient.request(url, Method.getMethod, null, passHeader: true);

    return model;
  }
}