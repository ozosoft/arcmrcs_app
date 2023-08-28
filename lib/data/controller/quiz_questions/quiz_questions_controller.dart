import 'dart:convert';
import 'dart:math';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_prime/data/model/quiz_questions_model/quiz_questions_model.dart';
import 'package:flutter_prime/data/model/submit_answer/submit_answer_model.dart';
import 'package:flutter_prime/data/repo/quiz_questions_repo/quiz_questions_repo.dart';
import 'package:get/get.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/data/model/global/response_model/response_model.dart';
import 'package:flutter_prime/view/components/snack_bar/show_custom_snackbar.dart';

class QuizQuestionsController extends GetxController {
  QuizquestionsRepo quizquestionsRepo;

  QuizQuestionsController({required this.quizquestionsRepo});

  bool showQuestions = false;
  bool audienceVote = false;
  bool tapAnswer = false;
  bool flipQuistions = false;
  bool restartTimer = false;

  String flipQuistion = "0";
  String fifty_fifty = "0";
  String audiencevotes = "0";
  String reset_timer = "0";

  int rightAnswerIndex = 0;
  int selectedAnswerIndex = -1;
  int timerDuration = 20;

  int currentQuestionIndex = 0;

  bool loading = true;

  int? quizInfoID;
  late int questionsIndex;
  List<Question> questionsList = [];
  List<Option> optionsList = [];

  List selectedQuestionsId = [];
  List selectedAnswerId = [];

  CountDownController countDownController = CountDownController();
  PageController pageController = PageController();
  int currentPage = 0;

  changePage(int page) {
    currentPage = page;
    update();
  }

  String successmessage = "";

  void getdata(String subcategoryId) async {
    loading = true;
    audienceVote = false;
    showQuestions = false;
    update();

    ResponseModel model = await quizquestionsRepo.getData(quizInfoID!);

    print("object" + quizInfoID.toString());

    if (model.statusCode == 200) {
      questionsList.clear();

      QuizquestionsModel quizquestions = QuizquestionsModel.fromJson(jsonDecode(model.responseJson));

      if (quizquestions.status.toString().toLowerCase() == MyStrings.success.toLowerCase()) {
        List<Question>? subcategorylist = quizquestions.data?.questions;

        if (subcategorylist != null && subcategorylist.isNotEmpty) {
          questionsList.addAll(subcategorylist);
        }

        timerDuration = int.parse(quizquestions.data!.perQuestionAnswerDuration.toString());
        update();

        successmessage = quizquestions.message!.success.toString()??"";

        List<Option>? optionslist = quizquestions.data!.questions![0].options;

        if (optionslist != null && optionslist.isNotEmpty) {
          optionsList.addAll(optionslist);
        }
        print(optionslist);
      } else {
        CustomSnackBar.error(errorList: [quizquestions.status ?? ""]);
      }
    } else {
      CustomSnackBar.error(errorList: [model.message]);
    }

    print('---------------------${model.statusCode}');

    loading = false;
    update();
  }

  showQuestion() {
    showQuestions = !showQuestions;
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
    questionsList[questionIndex].setSelectedOptionId(optionId);

    print('done');

    update();
  }

  String questionId = "";
  String thisQuestionId = "";
  isValidAnswer(int index, int optionIndex) {
    questionId = questionsList[index].selectedOptionId.toString();
    thisQuestionId = optionsList[optionIndex].id.toString();

    print('selectedQuestionId: ${questionId} ----this questionId ${thisQuestionId}');

    print('questionId=========================================================================: ${questionId}');

    if (thisQuestionId == questionId && optionsList[optionIndex].isAnswer == '1') {
      return true;
    } else {
      return false;
    }
  }

  int audienceVoteIndex = -1;
  audienceVotes(int questionIndex) {
    audienceVoteIndex = questionIndex;
    audienceVote = !audienceVote;
    update();
  }

  int flipQuestionsIndex = -1;
  flipQuiston(int questionIndex) {
    flipQuestionsIndex = flipQuestionsIndex;
    flipQuistions = !flipQuistions;
    update();
    flipQuistions ? pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut) : null;
  }

  int countDownTimerIndex = -1;
  restartCountDownTimer(int questionIndex) {
    countDownTimerIndex = countDownTimerIndex;
    restartTimer = !restartTimer;
    update();
  }

  bool fiftyFifty = false;
  int fiftyFiftyIndex = -1;
  makeFiftyFifty(int index) {
    List<Option> allOptions = questionsList[index].options!;
    var random = Random();
    Option correctAnswers = allOptions!.firstWhere((element) => element.isAnswer == '1');
    allOptions.remove(correctAnswers);
    Option incorrectAnswer = allOptions[random.nextInt(allOptions.length)];
    List<Option> optionsToDisplay = [correctAnswers, incorrectAnswer]..shuffle(random);
    print('come here: ${optionsList.length}');
    print(optionsList.length);
    questionsList[index].options!.clear();
    questionsList[index].options!.addAll(optionsToDisplay);
    update();

    fiftyFiftyIndex = fiftyFiftyIndex;
    fiftyFifty = !fiftyFifty;
    update();
  }

  void setCurrentOption(int questionsIndex) {
    // optionsList.clear();
    if (questionsList[questionsIndex].options != null) {
      optionsList = questionsList[questionsIndex].options!;
    }
  }

  bool submitLoading = false;

  String totalQuestions = "";
  String correctAnswer = "";
  String wrongAnswer = "";
  String totalCoin = "";
  String winningCoin = "";
  String appreciation = "";

  String nextlevelQuizInfoTitle = "";
  int nextlevelQuizInfoId = 0;

  submitAnswer() async {
    submitLoading = true;
    update();

    print("submiteeddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd" + selectedQuestionsId.toString());

    Map<String, dynamic> params = {};

    for (int i = 0; i < questionsList.length; i++) {
      String quizeId = questionsList[i].id.toString();
      String selectedOptionId = questionsList[i].selectedOptionId.toString();
      params['question_id[${i}]'] = quizeId;
      print('quize id: ${quizeId}');
      params['option_$quizeId'] = selectedOptionId;
      print("option_$quizeId");
    }
    print(params['option_']);
    params['quizInfo_id'] = quizInfoID.toString();
    params['fifty_fifty'] = fifty_fifty;
    params['audience_poll'] = audiencevotes;
    params['time_reset'] = reset_timer;
    params['flip_question'] = flipQuistion;

    ResponseModel submitModel = await quizquestionsRepo.submitAnswer(params);

    if (submitModel.statusCode == 200) {
      SubmitAnswerModel model = SubmitAnswerModel.fromJson(jsonDecode(submitModel.responseJson));
      if (model.status?.toLowerCase() == MyStrings.success.toLowerCase()) {
        appreciation = model.message!.success.toString();
        totalQuestions = model.data!.totalQuestion.toString();
        correctAnswer = model.data!.correctAnswer.toString();
        wrongAnswer = model.data!.wrongAnswer.toString();
        totalCoin = model.data!.totalScore.toString();
        winningCoin = model.data!.winingScore.toString();

        if (model.data?.nextLevelQuizInfo != null) {
          nextlevelQuizInfoId = model.data!.nextLevelQuizInfo?.id! ?? 0;
          nextlevelQuizInfoTitle = model.data!.nextLevelQuizInfo!.title ?? "";
        } else {
          return;
        }

        // CustomSnackBar.success(successList: model.message?.success ?? [MyStrings.success.tr]);
      } else {
        CustomSnackBar.error(errorList: model.message?.success ?? [MyStrings.somethingWentWrong.tr]);

        //need to cheak error msg
      }
    } else {
      CustomSnackBar.error(errorList: [submitModel.message]);
    }
    print("this is " + submitModel.message);
    print("this is " + params.toString());
    submitLoading = false;
    update();
  }

  resetallLifelines() {
    showQuestions = false;
    audienceVote = false;
    tapAnswer = false;
    flipQuistions = false;
    update();
  }
}
