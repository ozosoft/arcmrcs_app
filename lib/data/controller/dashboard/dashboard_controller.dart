import 'dart:convert';
import 'package:flutter_prime/data/model/dashboard/dashboard_model.dart';
import 'package:flutter_prime/data/repo/dashboard/dashboard_repo.dart';
import 'package:get/get.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/data/model/global/response_model/response_model.dart';
import 'package:flutter_prime/view/components/snack_bar/show_custom_snackbar.dart';

class DashBoardController extends GetxController {
  DashBoardRepo dashRepo;

  DashBoardController({required this.dashRepo});

  String rank = "";
  String coins = "";
  String score = "";
  List<Category> categorylist = [];
  List<Contest> contestlist = [];
  List<Exams> examZonelist = [];
  List<QuizType> quizlist = [];

  bool loader = true;

  bool isActive = false;

  void getdata() async {
    loader = true;
    update();

    ResponseModel model = await dashRepo.getData();

    if (model.statusCode == 200) {
      categorylist.clear();
      contestlist.clear();
      quizlist.clear();
      contestlist.clear();
      DashBoardModel dashBoard = DashBoardModel.fromJson(jsonDecode(model.responseJson));

      if (dashBoard.status.toString().toLowerCase() == MyStrings.success.toLowerCase()) {
        rank = dashBoard.data?.rank?.userRank ?? "";
        coins = dashBoard.data?.user?.coins ?? "";
        score = dashBoard.data?.user?.score ?? "";

        List<Category>? categories = dashBoard.data?.categories;

        if (categories != null && categories.isNotEmpty) {
          categorylist.addAll(categories);
        }

        List<Contest>? contest = dashBoard.data?.contest;

        if (contest != null && contest.isNotEmpty) {
          contestlist.addAll(contest);
        }

        List<Exams>? exams = dashBoard.data?.exams;

        if (exams != null && exams.isNotEmpty) {
          examZonelist.addAll(exams);
        }

        List<QuizType>? quizType = dashBoard.data?.quizType;

        if (quizType != null && quizType.isNotEmpty) {
          quizlist.addAll(quizType);
        }
      } else {
        CustomSnackBar.error(errorList: [dashBoard.status ?? ""]);
      }
    } else {
      CustomSnackBar.error(errorList: [model.message]);
    }

    print('---------------------${model.statusCode}');

    loader = false;
    update();
  }

  changeactivestatus() {
    isActive = !isActive;
    update();
  }
}
