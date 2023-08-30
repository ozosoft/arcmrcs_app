import 'dart:convert';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_prime/data/model/quiz_contest/quiz_contest_questions_model.dart';
import 'package:flutter_prime/data/repo/quiz_contest/quiz_contest_repo.dart';
import 'package:get/get.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/data/model/global/response_model/response_model.dart';
import 'package:flutter_prime/view/components/snack_bar/show_custom_snackbar.dart';



class QuizContestResultController extends GetxController {
  QuizContestRepo quizContestRepo;

  QuizContestResultController({
    required this.quizContestRepo,
  });



  int rightAnswerIndex = 0;
  int selectedAnswerIndex = -1;

  int currentQuestionIndex = 0;

  bool loading = true;

  String? quizInfoID;
  late int questionsIndex;
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

  String enterExamKey = "";
  String quizInfoId = "";

  TextEditingController enterExamKeys = TextEditingController();

  getExamZoneQuestions(String quizInfoId) async {
    loading = true;
    update();

    print("submiteeddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd" + selectedQuestionsId.toString());

    ResponseModel getQuestionsModel = await quizContestRepo.getExamQuestionList(quizInfoId);

    if (getQuestionsModel.statusCode == 200) {
      examQuestionsList.clear();
      QuizContestQuestionsModel model = QuizContestQuestionsModel.fromJson(jsonDecode(getQuestionsModel.responseJson));
      if (model.status?.toLowerCase() == MyStrings.success.toLowerCase()) {
        print("get answer done");
        // print(model.data);
        List<Question>? examQuestion = model.data!.questions! as List<Question>?;

        print(examQuestion);

        if (examQuestion != null && examQuestion.isNotEmpty) {
          examQuestionsList.addAll(examQuestion);
        }

        //   List<Option>? optionslist = model.data!.questions![1].options;

        // if (optionslist != null && optionslist.isNotEmpty) {
        //   optionsList.addAll(optionslist);
        // }

        

        CustomSnackBar.success(successList: model.message?.success ?? [MyStrings.success.tr]);
      } else {
        CustomSnackBar.error(errorList: model.message?.success ?? [MyStrings.somethingWentWrong.tr]);

        //need to cheak error msg
      }
    } else {
      CustomSnackBar.error(errorList: [getQuestionsModel.message]);
    }
    print("this is " + getQuestionsModel.message);

    loading = false;
    update();
  }

 


  int selectedOptionIndex = -1;
   selectAnswer(
    int optionIndex,
    int questionIndex,
  ) {
    selectedOptionIndex = optionIndex;
    print('work here');
    String optionId = optionsList[optionIndex].id.toString();

    print('not work here');
    examQuestionsList[questionIndex].setSelectedOptionId(optionId);

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
    questionId = examQuestionsList[index].selectedOptionId.toString();
    thisQuestionId = optionsList[optionIndex].id.toString();

    print('selectedQuestionId: ${questionId} ----this questionId ${thisQuestionId}');

    print('questionId=========================================================================: ${questionId}');

    if (thisQuestionId == questionId && optionsList[optionIndex].isAnswer == '1') {
      return true;
    } else {
      return false;
    }
  }

 


  




  void setCurrentOption(int questionsIndex) {
    // optionsList.clear();

    if (examQuestionsList[questionsIndex].options != null) {
      optionsList = examQuestionsList[questionsIndex].options!;
    }
  }


 
}