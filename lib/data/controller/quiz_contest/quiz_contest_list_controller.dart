import 'dart:convert';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_prime/data/model/quiz_contest/quiz_contest_list_model.dart';
import 'package:flutter_prime/data/repo/quiz_contest/quiz_contest_repo.dart';
import 'package:get/get.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/data/model/global/response_model/response_model.dart';
import 'package:flutter_prime/view/components/snack_bar/show_custom_snackbar.dart';

import '../../model/exam_zone/exam_zone_question_list_model.dart';

class QuizQuestionsListController extends GetxController {
  QuizContestRepo quizContestRepo;

  QuizQuestionsListController({
    required this.quizContestRepo,
  });

  int rightAnswerIndex = 0;
  int selectedAnswerIndex = -1;

  int currentQuestionIndex = 0;

  bool loading = true;

  String? quizInfoID;
  late int questionsIndex;
  List<Contest> examcategoryList = [];
  List<Question> examQuestionsList = [];
  List<Option> optionsList = [];

  List selectedQuestionsId = [];
  List selectedAnswerId = [];

  late final TabController tabController;
  int selectedIndex = 1;

  TextEditingController _textEditingController = TextEditingController();
  String _inputText = "";

  CountDownController countDownController = CountDownController();
  PageController pageController = PageController();
  int currentPage = 0;

  changePage(int page) {
    currentPage = page;
    update();
  }

  void getQuizcontestList() async {
    loading = true;

    update();

    ResponseModel model = await quizContestRepo.quizListData();

    print("object" + quizInfoID.toString());

    if (model.statusCode == 200) {
      examcategoryList.clear();

      QuizContestListModel examZoneModel = QuizContestListModel.fromJson(jsonDecode(model.responseJson));

      if (examZoneModel.status.toString().toLowerCase() == MyStrings.success.toLowerCase()) {
        List<Contest>? examList = examZoneModel.data?.contests;

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

  int selectedOptionIndex = -1;
  selectAnswer(
    int optionIndex,
    int questionIndex,
  ) {
    selectedOptionIndex = optionIndex;
    print('work here');
    String optionId = optionsList[optionIndex].id.toString();

    print('not work here');
    // questionsList[questionIndex].setSelectedOptionId(optionId);

    print('done');

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
