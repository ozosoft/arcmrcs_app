// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:math';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_prime/core/route/route.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/data/model/gesstheword/gess_catagroi_model.dart';
import 'package:flutter_prime/data/model/gesstheword/gess_question_model.dart';
import 'package:flutter_prime/data/model/gesstheword/gess_subcatagori_model.dart';
import 'package:flutter_prime/data/model/gesstheword/gess_submit_response.dart';
import 'package:flutter_prime/data/model/global/response_model/response_model.dart';
import 'package:flutter_prime/data/repo/gess_the_word/gessThewordRepo.dart';
import 'package:flutter_prime/view/components/snack_bar/show_custom_snackbar.dart';
import 'package:get/get.dart';

class GessThewordController extends GetxController {
  GessTheWordRepo gessTheWordRepo;
  GessThewordController({required this.gessTheWordRepo});
  //
  PageController pageController = PageController(initialPage: 0);
  CountDownController countDownController = CountDownController();
  //
  String? imgPath = "";
  String? questionImgPath = "";
  String? subImgPath = "";
  int currentPage = 0;
  bool isLoading = false;
  int ansDuration = 30;
  String? quizInfoId;
  // result
  String totalQuestion = '';
  String correctAnswer = '';
  String wrongAnswer = '';
  String totalScore = '';

  void initiaValue() async {
    imgPath = "";
    currentPage = 0;
    await getAllcataroy();
  }

  // page controlling
  void nextPage() {
    if (pageController.initialPage < gessThewordQuesstionList.length) {
      clearAllData();
      pageController.nextPage(duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
    } else {}
  }

  // asn
  List<String> tempAns = [];

  void addAns(int questionIndex, String answer) {
    gessThewordQuesstionList[questionIndex].setSelectedAnswer(answer);
  }

//final submit
  void submit() async {
    isLoading = true;
    update();

    Map<String, dynamic> params = {};
    params['quizInfo_id'] = quizInfoId;
    //
    for (int i = 0; i < gessThewordQuesstionList.length; i++) {
      String questionId = gessThewordQuesstionList[i].id.toString();
      // String optionId = gessThewordQuesstionList[i].options![0].id.toString();
      String selectedOptionId = gessThewordQuesstionList[i].selectedAnswer.toString();
      dev.log(selectedOptionId, name: " map answar");
      params['question_id[]'] = questionId.toString();
      params['option_$questionId'] = selectedOptionId.toString();
    }
    //
    ResponseModel response = await gessTheWordRepo.submitAnswar(params);
    if (response.statusCode == 200) {
      GesswordQuestionSubmitResponse model = GesswordQuestionSubmitResponse.fromJson(jsonDecode(response.responseJson));
      if (model.status.toString().toLowerCase() == MyStrings.success.toLowerCase()) {
        totalQuestion = model.data?.totalQuestion.toString() ?? '';
        correctAnswer = model.data?.correctAnswer.toString() ?? '';
        wrongAnswer = model.data?.wrongAnswer.toString() ?? '';
        totalScore = model.data?.totalScore.toString() ?? '';
        Get.toNamed(RouteHelper.gessThewordResult);
      } else {
        Get.toNamed(RouteHelper.gessThewordResult);

        dev.log('wrong');
      }
    } else {
      CustomSnackBar.error(errorList: [response.message]);
      Get.toNamed(RouteHelper.gessThewordCatagori);
    }

    isLoading = false;
    update();
  }

  // selected index of value list
  int selectedIndex = 0;
  void clearIndex() {
    selectedIndex = 0;
    update();
  }

  void selectIndex(int index) {
    if (selectedIndex <= tempAns.length) {
      selectedIndex = index;
      update();
    }
  }

  void removeVAlue() {
    if (selectedIndex != tempAns.length) {
      tempAns.removeAt(selectedIndex);
      tempAns.insert(selectedIndex, "-1");
      selectedIndex = selectedIndex != 0 ? selectedIndex - 1 : selectedIndex;
      update();
    }
  }

  void replace(String val) {
    if (selectedIndex != tempAns.length) {
      tempAns.removeAt(selectedIndex);
      tempAns.insert(selectedIndex, val);
      selectedIndex = selectedIndex != tempAns.length ? selectedIndex + 1 : selectedIndex;

      update();
    }
  }

//
  List<GessQuestion> gessThewordQuesstionList = [];
  List<GeusCatagories> catagoriList = [];
  List<GessSubcategory> subCatagories = [];

  Future<void> getAllcataroy() async {
    isLoading = true;
    update();
    ResponseModel response = await gessTheWordRepo.getwordcatagroiList();

    if (response.statusCode == 200) {
      GesswordCatagorisResponse model = GesswordCatagorisResponse.fromJson(jsonDecode(response.responseJson));

      if (model.status.toString().toLowerCase() == MyStrings.success.toLowerCase()) {
        List<GeusCatagories>? tempcatagroilist = model.data?.categories;
        if (tempcatagroilist != null) {
          catagoriList.clear();
          imgPath = model.data?.categoryImagePath;
          catagoriList.addAll(tempcatagroilist);
        }
      } else {
        CustomSnackBar.error(errorList: model.message?.error ?? [MyStrings.somethingWentWrong]);
      }
    } else {
      CustomSnackBar.error(errorList: [response.message]);
    }
    isLoading = false;
    update();
  }

  Future<void> getAllsubcatagories(String id) async {
    isLoading = true;
    update();
    ResponseModel response = await gessTheWordRepo.getwordSubCatagroiList(id);

    if (response.statusCode == 200) {
      GesswordSubCatagoriResponse model = GesswordSubCatagoriResponse.fromJson(jsonDecode(response.responseJson));

      if (model.status.toString().toLowerCase() == MyStrings.success.toLowerCase()) {
        List<GessSubcategory>? tempList = model.data?.subcategories;
        if (tempList != null) {
          subCatagories.clear();
          subCatagories.addAll(tempList);
          subImgPath = model.data?.imgPath;
        }
      } else {
        CustomSnackBar.error(errorList: model.message?.error ?? [MyStrings.somethingWentWrong]);
      }
    } else {
      CustomSnackBar.error(errorList: [response.message]);
    }
    isLoading = false;
    update();
  }

  Future<void> getQuestion(String id) async {
    quizInfoId = '';
    isLoading = true;
    update();
    ResponseModel response = await gessTheWordRepo.getwordQuestionList(id);

    if (response.statusCode == 200) {
      GesswordQuestionResponse model = GesswordQuestionResponse.fromJson(jsonDecode(response.responseJson));

      if (model.status.toString().toLowerCase() == MyStrings.success.toLowerCase()) {
        List<GessQuestion>? templist = model.data?.questions;
        if (templist != null) {
          gessThewordQuesstionList.clear();
          questionImgPath = model.data?.questionImagePath;
          ansDuration = int.parse(model.data?.perQuestionAnswerDuration.toString() ?? "30");
          quizInfoId = id;
          gessThewordQuesstionList.addAll(templist);
          dev.log(gessThewordQuesstionList.length.toString());
        }
      } else {
        CustomSnackBar.error(errorList: model.message?.error ?? [MyStrings.somethingWentWrong]);
      }
    } else {
      CustomSnackBar.error(errorList: [response.message]);
    }
    isLoading = false;
    update();
  }

  void clearAllData() {
    tempAns.clear();
    selectedIndex = 0;
    update();
  }
}
