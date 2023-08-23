import 'package:flutter_prime/core/utils/method.dart';
import 'package:flutter_prime/core/utils/url_container.dart';
import 'package:flutter_prime/data/model/global/response_model/response_model.dart';
import 'package:flutter_prime/data/services/api_service.dart';

class ExamZoneRepo {
  ApiClient apiClient;
  ExamZoneRepo({required this.apiClient});

  Future<ResponseModel> examZoneData() async {
    String url = "${UrlContainer.baseUrl}${UrlContainer.examZone}";
    print('come here: ${url}');
    ResponseModel model = await apiClient.request(url, Method.getMethod, null, passHeader: true);

    return model;
  }

   Future<ResponseModel> getExamQuestionList(String quizInfo_ID,exam_key) async {

    final map = {'quizInfo_id': quizInfo_ID,'exam_key': exam_key};

    String url = '${UrlContainer.baseUrl}${UrlContainer.examZoneQuestionsUrl}';
    ResponseModel responseModel = await apiClient.request(url, Method.postMethod, map, passHeader: true);

    return responseModel;
  }


   Future<ResponseModel> submitAnswer(Map<String, dynamic> map) async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.examsubmitAnswerUrl}';
    print(url.toString());

    ResponseModel model = await apiClient.request(url, Method.postMethod, map, passHeader: true);

    print(model.responseJson.toLowerCase());
    print(model.statusCode);

    return model;
  }
}
