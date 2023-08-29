// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_prime/data/repo/gess_the_word/gessThewordRepo.dart';
import 'package:get/get.dart';

import '../../model/guess_the_word/guess_question_model.dart';

class GuessThewordReviewResultController extends GetxController {
  GuessTheWordRepo gessTheWordRepo;
  GuessThewordReviewResultController({required this.gessTheWordRepo});

  PageController reviewPageController = PageController(initialPage: 0);

  var getQuestionsArguments = Get.arguments[0] as List<GuessQuestion>;
  List<GuessQuestion> guessThewordQuestionList = [];

  //Methods
  setGuessThewordQuestionList() {
    guessThewordQuestionList = getQuestionsArguments;
    update();
  }
}
