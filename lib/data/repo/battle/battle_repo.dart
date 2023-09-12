import 'package:flutter/widgets.dart';
import 'package:flutter_prime/core/utils/method.dart';
import 'package:flutter_prime/core/utils/url_container.dart';
import 'package:flutter_prime/data/model/global/response_model/response_model.dart';
import 'package:flutter_prime/data/services/api_service.dart';

class BattleRepo {
  ApiClient apiClient;
  BattleRepo({required this.apiClient});

  Future<ResponseModel> getCategoryListData() async {
    String url = "${UrlContainer.baseUrl}${UrlContainer.battleCategoryLIst}";
    debugPrint('come here: $url');
    ResponseModel model = await apiClient.request(url, Method.getMethod, null, passHeader: true);

    return model;
  }

  Future<ResponseModel> getBatttleQuestion(int id, int user1ID, int user2ID) async {
    String url = "${UrlContainer.baseUrl}${UrlContainer.battleQuestionList}/${user1ID.toString()}/${user2ID.toString()}/${id.toString()}";
    debugPrint('come here: $url');
    ResponseModel model = await apiClient.request(url, Method.getMethod, null, passHeader: true);

    return model;
  }

  Future<ResponseModel> finishBattleAndSubmitAnswer(Map<String, dynamic> map) async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.battleAnswerSubmit}';
    debugPrint(url);

    ResponseModel model = await apiClient.request(url, Method.postMethod, map, passHeader: true);

    return model;
  }
}
