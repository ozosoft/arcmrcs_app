import 'package:flutter_prime/core/utils/method.dart';
import 'package:flutter_prime/core/utils/url_container.dart';
import 'package:flutter_prime/data/model/global/response_model/response_model.dart';
import 'package:flutter_prime/data/services/api_service.dart';

class LeaderBoardRepo {
  ApiClient apiClient;
  LeaderBoardRepo({required this.apiClient});

  Future<ResponseModel> getLeaderBoardData() async {
    String url = "${UrlContainer.baseUrl}${UrlContainer.leaderBoardUrl}";
    print('come here: ${url}');
    ResponseModel model =
        await apiClient.request(url, Method.getMethod, null, passHeader: true);

    return model;
  }
}
