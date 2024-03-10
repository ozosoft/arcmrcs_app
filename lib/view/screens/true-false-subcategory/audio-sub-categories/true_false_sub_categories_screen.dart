import 'package:flutter/material.dart';
import 'package:quiz_lab/core/helper/ads/admob_helper.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';
import 'package:quiz_lab/core/utils/my_color.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/core/utils/url_container.dart';
import 'package:quiz_lab/data/controller/all_audio_sub_category/all_audio_sub_category_conntroller.dart';
import 'package:quiz_lab/data/controller/sub_categories/sub_categories_controller.dart';
import 'package:quiz_lab/data/controller/true_false_sub_category/true_false_sub_category_controller.dart';
import 'package:quiz_lab/data/repo/audio_sub_category/audio_sub_category.dart';
import 'package:quiz_lab/data/repo/sub_categories/sub_categories_repo.dart';
import 'package:quiz_lab/data/repo/true-false-category/true_false_category_repo.dart';
import 'package:quiz_lab/data/repo/true-false-subcategory/true_false_subcategory_repo.dart';
import 'package:quiz_lab/data/services/api_client.dart';
import 'package:quiz_lab/view/components/app-bar/custom_category_appBar.dart';
import 'package:quiz_lab/view/components/custom_loader/custom_loader.dart';
import 'package:get/get.dart';
import 'package:quiz_lab/view/components/no_data.dart';
import 'widgets/true_false_questions_sub_category_list_card_widget.dart';

class TrueFalseQuestionsSubCategoriesScreen extends StatefulWidget {
  final String title;
  const TrueFalseQuestionsSubCategoriesScreen({super.key, required this.title});

  @override
  State<TrueFalseQuestionsSubCategoriesScreen> createState() => _TrueFalseQuestionsSubCategoriesScreenState();
}

class _TrueFalseQuestionsSubCategoriesScreenState extends State<TrueFalseQuestionsSubCategoriesScreen> {
  String title = "";
  String subCategoryId = "";
  AdmobHelper admobHelper = AdmobHelper();
  @override
  void initState() {
    super.initState();
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(TrueFalseSubCategoriesRepo(apiClient: Get.find()));
    Get.put(TrueFalseSubcategory(trueFalseSubCategoriesRepo: Get.find()));
    TrueFalseSubcategory controller = Get.put(TrueFalseSubcategory(trueFalseSubCategoriesRepo: Get.find()));

    title = Get.arguments[0] as String;
    subCategoryId = Get.arguments[1];
    print("audio quizes==================$subCategoryId");

    admobHelper.createInterstitialAd();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getdata(subCategoryId);
    });
  }

  bool isCardExpand = false;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TrueFalseSubcategory>(
      builder: (controller) => Scaffold(
        appBar: CustomCategoryAppBar(
          title: title,
        ),
        body: controller.loader
            ? const CustomLoader()
            : controller.subCategoriesList.isEmpty
                ? NoDataWidget(
                    messages: MyStrings.noSubCategoryFound.tr,
                  )
                : RefreshIndicator(
                    color: MyColor.primaryColor,
                    onRefresh: () async {
                      controller.getdata(subCategoryId);
                    },
                    child: ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                        padding: const EdgeInsetsDirectional.only(top: Dimensions.space25),
                        itemCount: controller.subCategoriesList.length,
                        itemBuilder: (BuildContext context, int index) {
                          var categoryItem = controller.subCategoriesList[index];
                          return TrueFalseQuestionsSubCategoryListTileCardWidget(
                            controller: controller,
                            categoryData: categoryItem,
                            onTap: () {
                              admobHelper.showInterstitialAd();
                              controller.changeExpandIndex(index);
                            },
                            title: categoryItem.name.toString(),
                            image: UrlContainer.subCategoriesImage + categoryItem.image.toString(),
                            fromViewAll: true,
                            subCategoryId: subCategoryId,
                            isExpand: index == controller.expandIndex,
                            index: index,
                          );
                        }),
                  ),
      ),
    );
  }
}
