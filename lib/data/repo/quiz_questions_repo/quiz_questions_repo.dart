import 'package:flutter_prime/core/utils/method.dart';
import 'package:flutter_prime/core/utils/url_container.dart';
import 'package:flutter_prime/data/model/global/response_model/response_model.dart';
import 'package:flutter_prime/data/services/api_service.dart';

class QuizquestionsRepo {
  ApiClient apiClient;
  QuizquestionsRepo({required this.apiClient});

  Future<ResponseModel> getData(int id) async {
    String url = "${UrlContainer.baseUrl}${UrlContainer.quizQuestionsUrl + id.toString()}";
    print('come here: ${url}');
    ResponseModel model = await apiClient.request(url, Method.getMethod, null, passHeader: true);

    return model;
  }

  Future<ResponseModel> submitAnswer(Map<String, dynamic> map) async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.submitAnswerUrl}';
    print(url.toString());

    ResponseModel model = await apiClient.request(url, Method.postMethod, map, passHeader: true);

    print(model.responseJson.toLowerCase());
    print(model.statusCode);

    return model;
  }
}
