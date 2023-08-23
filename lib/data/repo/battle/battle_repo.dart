import 'package:flutter_prime/core/utils/method.dart';
import 'package:flutter_prime/core/utils/url_container.dart';
import 'package:flutter_prime/data/model/global/response_model/response_model.dart';
import 'package:flutter_prime/data/services/api_service.dart';

class BattleRepo {
  ApiClient apiClient;
  BattleRepo({required this.apiClient});

  Future<ResponseModel> getData() async {
    String url = "${UrlContainer.baseUrl}${UrlContainer.dashBoardUrl}";
    print('come here: ${url}');
    ResponseModel model = await apiClient.request(url, Method.getMethod, null, passHeader: true);

    return model;
  }

  Future<ResponseModel> getBatttleQuestion(int id) async {
    String url = "${UrlContainer.baseUrl}${UrlContainer.quizQuestionsUrl + id.toString()}";
    print('come here: ${url}');
    ResponseModel model = await apiClient.request(url, Method.getMethod, null, passHeader: true);

    return model;
  }
}
