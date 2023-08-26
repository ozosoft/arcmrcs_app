import 'package:flutter_prime/data/repo/battle/battle_repo.dart';
import 'package:get/get.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';

import '../../model/battle/battle_category_list.dart';

class OneVsMutiController extends GetxController {
  final BattleRepo battleRepo;
  OneVsMutiController(this.battleRepo);

  // Variables

  final isLoadingQuestions = false.obs;

  final categoryList = <BattleCategory>[].obs;

  final isLoadingCategory = false.obs;
  final slectedCategoryID = 0.obs;
  final entryFeeRandomGame = "0".obs;

  @override
  void onInit() {
    super.onInit();
    getRandomBattleCategoryList();
  }

  // Get battle Category
  Future<void> getRandomBattleCategoryList() async {
    isLoadingCategory.value = true;
    update();

    final model = await battleRepo.getCategoryListData();

    if (model.statusCode == 200) {
      entryFeeRandomGame.value = "0";
      categoryList.clear();

      final battleCategoryList = battleCategoryListFromJson(model.responseJson);

      if (battleCategoryList.status.toLowerCase() == MyStrings.success.toLowerCase()) {
        final categoryListData = battleCategoryList.data.categories;

        entryFeeRandomGame.value = battleCategoryList.data.entryCoin;
        if (categoryListData.isNotEmpty) {
          categoryList.addAll(categoryListData);
          
        }
      }

      isLoadingCategory.value = false;
      update();
    }
  }

  //Select A Category
  slectACategory(int value) {
    slectedCategoryID.value = value;
    update();
  }
}
