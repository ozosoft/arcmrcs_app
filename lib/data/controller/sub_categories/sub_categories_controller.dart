import 'dart:convert';
import 'package:flutter_prime/data/model/sub_categories/sub_categories_model.dart';
import 'package:flutter_prime/data/repo/sub_categories/sub_categories_repo.dart';
import 'package:get/get.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/data/model/global/response_model/response_model.dart';
import 'package:flutter_prime/view/components/snack_bar/show_custom_snackbar.dart';

class SubCategoriesController extends GetxController {
  SubCategoriesRepo subCategoriesRepo;

  SubCategoriesController({required this.subCategoriesRepo});

  String id = "";
  List<Subcategory> subCategoriesList = [];
  List<Category> quizIinfosList = [];

  int itemCount = 0;

  bool loader = true;

  bool isActive = false;
  bool viewMore  = false;

  void getdata(String subcategoryId) async {
    loader = true;
    update();

    ResponseModel model = await subCategoriesRepo.getData(subcategoryId);

    if (model.statusCode == 200) {
      subCategoriesList.clear();

      SubcategoriesModel subcategories =
          SubcategoriesModel.fromJson(jsonDecode(model.responseJson));

      if (subcategories.status.toString().toLowerCase() ==
          MyStrings.success.toLowerCase()) {
        // id =subcategories.data.subcategories.

        List<Subcategory>? subcategorylist = subcategories.data?.subcategories;

        if (subcategorylist != null && subcategorylist.isNotEmpty) {
          subCategoriesList.addAll(subcategorylist);
        }

        itemCount = subcategorylist?.length ?? 0;
      } else {
        CustomSnackBar.error(errorList: [subcategories.status ?? ""]);
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
