import 'dart:convert';
import 'package:flutter_prime/data/model/play_different_quizes/fun_n_learn/fun_n_learn_category_model.dart';
import 'package:flutter_prime/data/repo/play_different_quizes/fun_n_learn/fun_n_learn_repo.dart';
import 'package:get/get.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/data/model/global/response_model/response_model.dart';
import 'package:flutter_prime/view/components/snack_bar/show_custom_snackbar.dart';

class FunNLearnCategoriesController extends GetxController {
  FunNLearnRepo funNLearnRepo;

  FunNLearnCategoriesController({required this.funNLearnRepo});

  List<Category> allCategoriesList = [];

  bool loader = true;

  bool isActive = false;
  bool viewMore = false;

  void getFunNLearndata() async {
    loader = true;
    update();

    ResponseModel model = await funNLearnRepo.getFunAndLearnCategories();

    if (model.statusCode == 200) {

      allCategoriesList.clear();

      FunNLearncategoryModel allcategories =
          FunNLearncategoryModel.fromJson(jsonDecode(model.responseJson));

      if (allcategories.status.toString().toLowerCase() ==
          MyStrings.success.toLowerCase()) {
        List<Category>? categories = allcategories.data?.categories;

        if (categories != null && categories.isNotEmpty) {
          allCategoriesList.addAll(categories);
        }
      } else {
        CustomSnackBar.error(errorList: [allcategories.status ?? ""]);
      }
    } else {
      CustomSnackBar.error(errorList: [model.message]);
    }

    print('---------------------${model.statusCode}');

    loader = false;
    update();
    int expandIndex = -1;
  void changeExpandIndex(int index) {
    if (expandIndex == index) {
      expandIndex = -1;
      update();
      return;
    }
    expandIndex = index;
    update();
  }
  }


  

  changeactivestatus() {
    isActive = !isActive;
    update();
  }
}
