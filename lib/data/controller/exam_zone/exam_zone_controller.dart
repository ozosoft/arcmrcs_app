import 'dart:convert';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_prime/data/model/exam_zone/exam_zone_model.dart';

import 'package:flutter_prime/data/repo/exam_zone/exam_zone_repo.dart';
import 'package:get/get.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/data/model/global/response_model/response_model.dart';
import 'package:flutter_prime/view/components/snack_bar/show_custom_snackbar.dart';

import '../../../core/route/route.dart';
import '../../model/exam_zone/exam_zone_question_list_model.dart';

class ExamZoneController extends GetxController with GetSingleTickerProviderStateMixin {
  ExamZoneRepo examZoneRepo;

  ExamZoneController({
    required this.examZoneRepo,
  });

  int rightAnswerIndex = 0;
  int selectedAnswerIndex = -1;

  int currentQuestionIndex = 0;

  bool loading = true;

  String? quizInfoID;
  late int questionsIndex;
  List<Exam> examcategoryList = [];
  List<Question> examQuestionsList = [];
  List<Option> optionsList = [];

  List selectedQuestionsId = [];
  List selectedAnswerId = [];

  late TabController tabController;
  int selectedIndex = 1;

  CountDownController countDownController = CountDownController();
  PageController pageController = PageController();
  int currentPage = 0;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(vsync: this, length: 2);

    selectedIndex = tabController.index;
  }

  changePage(int page) {
    currentPage = page;
    update();
  }

  void examZoneListData({bool fromLoad = false}) async {
    if (fromLoad == true) {
      loading = true;
    } else {
      loading = false;
    }

    update();

    ResponseModel model = await examZoneRepo.examZoneData();

    print("object" + quizInfoID.toString());

    if (model.statusCode == 200) {
      examcategoryList.clear();

      ExamZoneModel examZoneModel = ExamZoneModel.fromJson(jsonDecode(model.responseJson));

      if (examZoneModel.status.toString().toLowerCase() == MyStrings.success.toLowerCase()) {
        List<Exam>? examList = examZoneModel.data?.exams;

        if (examList != null && examList.isNotEmpty) {
          examcategoryList.addAll(examList);
        }

        print("this is exam list" + examList![0].id.toString());
      } else {
        CustomSnackBar.error(errorList: [examZoneModel.status ?? ""]);
      }
    } else {
      CustomSnackBar.error(errorList: [model.message]);
    }

    print('---------------------${model.statusCode}');

    loading = false;
    update();
  }

  String enterExamKey = "";
  String quizInfoId = "";

  bool submitLoading = false;

  enterExamZone(String quizInfoId, enterExamKey) async {
    submitLoading = true;
    update();

    //GET EXAM DETAILS
    ResponseModel getQuestionsModel = await examZoneRepo.getExamDetails(quizInfoId.toString());

    if (getQuestionsModel.statusCode == 200) {
      examQuestionsList.clear();
      ExamZoneQuestionsModel modelData = ExamZoneQuestionsModel.fromJson(jsonDecode(getQuestionsModel.responseJson));
      if (modelData.status?.toLowerCase() == MyStrings.success.toLowerCase()) {
        if (modelData.message!.success!.first.contains("already finished")) {
          Get.back();
          CustomSnackBar.success(successList: modelData.message!.success!);
        } else {
          Get.toNamed(RouteHelper.examZoneQuestionScreen, arguments: [quizInfoId, enterExamKey]);
        }
      } else {
        CustomSnackBar.error(errorList: modelData.message?.success ?? [MyStrings.somethingWentWrong.tr]);

        //need to cheak error msg
      }
    } else {
      CustomSnackBar.error(errorList: [getQuestionsModel.message]);
    }

    submitLoading = false;
    update();
  }

  int selectedOptionIndex = -1;
  selectAnswer(
    int optionIndex,
    int questionIndex,
  ) {
    selectedOptionIndex = optionIndex;
    print('work here');

    print('not work here');
    // questionsList[questionIndex].setSelectedOptionId(optionId);

    print('done');

    update();
  }

  selectTab() {
    selectedIndex = tabController.index;
    update();
  }

  String questionId = "";
  String thisQuestionId = "";
  isValidAnswer(int index, int optionIndex) {
    // questionId = questionsList[index].selectedOptionId.toString();
    thisQuestionId = optionsList[optionIndex].id.toString();

    print('selectedQuestionId: ${questionId} ----this questionId ${thisQuestionId}');

    print('questionId=========================================================================: ${questionId}');

    if (thisQuestionId == questionId && optionsList[optionIndex].isAnswer == '1') {
      return true;
    } else {
      return false;
    }
  }
}
