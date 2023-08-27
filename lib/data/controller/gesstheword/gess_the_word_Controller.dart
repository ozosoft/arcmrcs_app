// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/data/model/gesstheword/gess_catagroi_model.dart';
import 'package:flutter_prime/data/model/gesstheword/gess_question_model.dart';
import 'package:flutter_prime/data/model/gesstheword/gess_subcatagori_model.dart';
import 'package:flutter_prime/data/model/global/response_model/response_model.dart';
import 'package:flutter_prime/data/repo/gess_the_word/gessThewordRepo.dart';
import 'package:flutter_prime/view/components/snack_bar/show_custom_snackbar.dart';
import 'package:get/get.dart';

class GessThewordController extends GetxController {
  GessTheWordRepo gessTheWordRepo;
  GessThewordController({required this.gessTheWordRepo});
  //
  PageController pageController = PageController();
  String? imgPath = "";
  String? questionImgPath = "";
  String? subImgPath = "";
  int currentPage = 0;
  bool isLoading = false;
  int ansDuration = 30;

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
    } else {
      log("Go submit data");
    }
  }

  // asn
  List<String> tempAns = [];
  List<Map<String, dynamic>> ans = [];

  void addAns(String questionID, String answar) {
    ans.add({"quizInfo_id": questionID, "option": answar});
    log(ans.toString());
  }

//final submit
  void submit() {
    log("final submit data");
    log(ans.toString());
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

  void removeVAlue(String val) {
    tempAns.remove(val);
    update();
  }

  void replace(String val) {
    if (selectedIndex != tempAns.length) {
      tempAns.removeAt(selectedIndex);
      tempAns.insert(selectedIndex, val);
      selectedIndex = selectedIndex != tempAns.length ? selectedIndex + 1 : selectedIndex;
      log(selectedIndex.toString(), name: "if part befor update");
      update();
      log(selectedIndex.toString(), name: "if part after update");
    } else {
      log(selectedIndex.toString(), name: "else part");
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
    log(id);
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
          gessThewordQuesstionList.addAll(templist);
          log(gessThewordQuesstionList.length.toString());
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
