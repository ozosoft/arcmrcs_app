// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer' as dev;

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_prime/core/route/route.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/data/model/guess_the_word/guess_question_model.dart';
import 'package:flutter_prime/data/model/guess_the_word/guess_subcategory_model.dart';
import 'package:flutter_prime/data/model/guess_the_word/guess_submit_response.dart';
import 'package:flutter_prime/data/model/global/response_model/response_model.dart';
import 'package:flutter_prime/data/repo/gess_the_word/gessThewordRepo.dart';
import 'package:flutter_prime/view/components/snack_bar/show_custom_snackbar.dart';
import 'package:get/get.dart';

import '../../model/guess_the_word/guess_category_model.dart';

class GuessThewordController extends GetxController {
  GuessTheWordRepo gessTheWordRepo;
  GuessThewordController({required this.gessTheWordRepo});

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
    String modifiedString = answer.replaceAll('-1', '');
    gessThewordQuesstionList[questionIndex].setSelectedAnswer(modifiedString);
  }

//final submit Answers
  void submitGuessTheWordAnswers() async {
    isLoading = true;
    update();

    Map<String, dynamic> params = {};
    params['quizInfo_id'] = quizInfoId;
    for (int i = 0; i < gessThewordQuesstionList.length; i++) {
      dev.log(gessThewordQuesstionList[i].id.toString(), name: "submit");

      String questionId = gessThewordQuesstionList[i].id.toString();
      // String optionId = gessThewordQuesstionList[i].options![0].id.toString();
      String selectedOptionId = gessThewordQuesstionList[i].selectedAnswer.toString();
      params['question_id[]$questionId'] = questionId;
      params['option_$questionId'] = selectedOptionId.toString();
    }
    //
    ResponseModel response = await gessTheWordRepo.submitAnswar(params);
    if (response.statusCode == 200) {
      GuesswordQuestionSubmitResponse model = GuesswordQuestionSubmitResponse.fromJson(jsonDecode(response.responseJson));
      if (model.status.toString().toLowerCase() == MyStrings.success.toLowerCase()) {
        totalQuestion = model.data?.totalQuestion.toString() ?? '';
        correctAnswer = model.data?.correctAnswer.toString() ?? '';
        wrongAnswer = model.data?.wrongAnswer.toString() ?? '';
        totalScore = model.data?.totalScore.toString() ?? '';
        Get.offAndToNamed(
          RouteHelper.gessThewordResult,
        );
        CustomSnackBar.success(successList: model.message?.success ?? [MyStrings.success]);
      } else {
        CustomSnackBar.error(errorList: model.message?.error ?? [MyStrings.somethingWentWrong]);
        Get.offAndToNamed(RouteHelper.guessTheWordCategory);
      }
    } else {
      Get.toNamed(RouteHelper.guessTheWordCategory);
      CustomSnackBar.error(errorList: [response.message]);
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
  List<GuessQuestion> gessThewordQuesstionList = [];
  List<GuessCategories> categoryList = [];
  List<GuessSubCategory> subCategories = [];

  Future<void> getAllcataroy() async {
    isLoading = true;
    update();
    ResponseModel response = await gessTheWordRepo.getwordcategoryList();

    if (response.statusCode == 200) {
      GuesswordCategorysResponse model = GuesswordCategorysResponse.fromJson(jsonDecode(response.responseJson));

      if (model.status.toString().toLowerCase() == MyStrings.success.toLowerCase()) {
        List<GuessCategories>? tempcategorylist = model.data?.categories;
        if (tempcategorylist != null) {
          categoryList.clear();
          imgPath = model.data?.categoryImagePath;
          categoryList.addAll(tempcategorylist);
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

  Future<void> getAllsubcategories(String id) async {
    isLoading = true;
    update();
    ResponseModel response = await gessTheWordRepo.getwordSubCatagroiList(id);

    if (response.statusCode == 200) {
      GuesswordSubCategoryResponse model = GuesswordSubCategoryResponse.fromJson(jsonDecode(response.responseJson));

      if (model.status.toString().toLowerCase() == MyStrings.success.toLowerCase()) {
        List<GuessSubCategory>? tempList = model.data?.subcategories;
        if (tempList != null) {
          subCategories.clear();
          subCategories.addAll(tempList);
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
      GuesswordQuestionResponse model = GuesswordQuestionResponse.fromJson(jsonDecode(response.responseJson));

      if (model.status.toString().toLowerCase() == MyStrings.success.toLowerCase()) {
        List<GuessQuestion>? templist = model.data?.questions;
        if (templist != null) {
          gessThewordQuesstionList.clear();
          questionImgPath = model.data?.questionImagePath;
          ansDuration = int.parse(model.data?.perQuestionAnswerDuration.toString() ?? "30");
          quizInfoId = id;
          gessThewordQuesstionList.addAll(templist);
          dev.log(gessThewordQuesstionList.length.toString());
        }
      } else {
        // CustomSnackBar.error(errorList: model.message?.error ?? [MyStrings.somethingWentWrong]);
      }
    } else {
      // CustomSnackBar.error(errorList: [response.message]);
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
