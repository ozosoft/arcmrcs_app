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
   

  Future<ResponseModel> getFunAndLearnSubCategories(String subcategoryId) async {
    String url = "${UrlContainer.baseUrl}${UrlContainer.funNLearnsubCategoryUrl+subcategoryId}";
    print('all categories=====>: ${subcategoryId}');
    ResponseModel model =
        await apiClient.request(url, Method.getMethod, null, passHeader: true);

    return model;
  }

  Future<ResponseModel> getFunAndLearnDescription(String subcategoryId) async {
    String url = "${UrlContainer.baseUrl}${UrlContainer.funNLearnDescriptionUrl+subcategoryId}";
    print('all categories=====>: ${subcategoryId}');
    ResponseModel model =
        await apiClient.request(url, Method.getMethod, null, passHeader: true);

    return model;
  }

   Future<ResponseModel> getFunNlearnQuestions(String id) async {
    String url = "${UrlContainer.baseUrl}${UrlContainer.funNlearnQuestionsUrl + id.toString()}";
    print('come here: ${url}');
    ResponseModel model = await apiClient.request(url, Method.getMethod, null, passHeader: true);

    return model;
  }
     Future<ResponseModel> submitAnswer(Map<String, dynamic> map) async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.funNlearnsubmitAnswerUrl}';
    print(url.toString());

    ResponseModel model = await apiClient.request(url, Method.postMethod, map, passHeader: true);

    print(model.responseJson.toLowerCase());
    print(model.statusCode);

    return model;
  }
}
