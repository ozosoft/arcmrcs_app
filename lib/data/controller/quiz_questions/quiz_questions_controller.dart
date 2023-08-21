import 'dart:convert';
import 'package:flutter_prime/data/model/quiz_questions_model/quiz_questions_model.dart';
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

  int rightAnswerIndex = 0;
  int selectedAnswerIndex = -1;

  int currentQuestionIndex = 0;

  bool loader = true;

  int? quizInfoID;
  late int questionsIndex ;
  List<Question> questionsList = [];
  List<Option> optionsList = [];

  void getdata(String subcategoryId) async {
    loader = true;
    update();

    ResponseModel model = await quizquestionsRepo.getData(quizInfoID!);

    print("object" + quizInfoID.toString());

    if (model.statusCode == 200) {
      questionsList.clear();
      optionsList.clear();

      QuizquestionsModel quizquestions =
          QuizquestionsModel.fromJson(jsonDecode(model.responseJson));

      if (quizquestions.status.toString().toLowerCase() ==
          MyStrings.success.toLowerCase()) {

            
        List<Question>? subcategorylist = quizquestions.data?.questions;

        if (subcategorylist != null && subcategorylist.isNotEmpty) {
          questionsList.addAll(subcategorylist);
        }

        List<Option>? optionslist = quizquestions.data!.questions![0].options;

        if (optionslist != null && optionslist.isNotEmpty) {
          optionsList.addAll(optionslist);
        }
        print("_____this is question List" +
            questionsList[0].question.toString());
        print("_____this is option List " + optionsList[0].option.toString());
      } else {
        CustomSnackBar.error(errorList: [quizquestions.status ?? ""]);
      }
    } else {
      CustomSnackBar.error(errorList: [model.message]);
    }

    update();

    print('---------------------${model.statusCode}');

    loader = false;
    update();
  }

  showQuestion() {
    showQuestions = !showQuestions;
  }

  audienceVotes() {
    audienceVote = !audienceVote;
  }
}
