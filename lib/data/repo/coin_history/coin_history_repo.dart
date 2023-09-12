import 'package:flutter/widgets.dart';
import 'package:flutter_prime/core/utils/method.dart';
import 'package:flutter_prime/core/utils/url_container.dart';
import 'package:flutter_prime/data/model/global/response_model/response_model.dart';
import 'package:flutter_prime/data/services/api_service.dart';

class CoinHistoryRepo {
  ApiClient apiClient;
  CoinHistoryRepo({required this.apiClient});

  Future<ResponseModel> coinHistoryData() async {
    String url = "${UrlContainer.baseUrl}${UrlContainer.coinHistory}";
    debugPrint('come here: $url');
    ResponseModel model = await apiClient.request(url, Method.getMethod, null, passHeader: true);

    return model;
  }


}
