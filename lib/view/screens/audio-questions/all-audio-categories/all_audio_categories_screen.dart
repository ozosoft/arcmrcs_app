import 'package:flutter/material.dart';
import 'package:quiz_lab/core/helper/ads/admob_helper.dart';
import 'package:quiz_lab/core/route/route.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';
import 'package:quiz_lab/core/utils/my_color.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/core/utils/url_container.dart';
import 'package:quiz_lab/core/utils/util.dart';
import 'package:quiz_lab/data/controller/all_audio_categories/all_audio_categories_controller.dart';
import 'package:quiz_lab/data/controller/all_categories/all_categories_controller.dart';
import 'package:quiz_lab/data/model/all_cartegories/all_categories_model.dart';
import 'package:quiz_lab/data/repo/allcategories/all_categories_repo.dart';
import 'package:quiz_lab/data/services/api_client.dart';
import 'package:quiz_lab/view/components/app-bar/custom_category_appbar.dart';
import 'package:quiz_lab/view/components/custom_loader/custom_loader.dart';
import 'package:get/get.dart';
import 'package:quiz_lab/view/components/no_data.dart';

import 'widgets/all_audio_category_list_card_widget.dart';

class AllAudioCategoriesScreen extends StatefulWidget {
  const AllAudioCategoriesScreen({super.key});

  @override
  State<AllAudioCategoriesScreen> createState() => _AllAudioCategoriesScreenState();
}

class _AllAudioCategoriesScreenState extends State<AllAudioCategoriesScreen> {
  AdmobHelper admobHelper = AdmobHelper();
  @override
  void initState() {
    super.initState();
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(AllCategoriesRepo(apiClient: Get.find()));
    Get.put(AllAudioCategoriesController(
      allCategoriesRepo: Get.find(),
    ));
        print("audio quizes==================22");
    AllAudioCategoriesController controller = Get.put(AllAudioCategoriesController(allCategoriesRepo: Get.find()));
    admobHelper.createInterstitialAd();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      controller.getdata();
    });
  }

  @override
  void dispose() {
    MyUtils.allScreen();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomCategoryAppBar(
        title: MyStrings.allCategory.tr,
        // systemUiOverlayStyle: SystemUiOverlayStyle(statusBarColor: MyColor.colorWhite, statusBarIconBrightness: Brightness.dark, systemNavigationBarColor: MyColor.getPrimaryColor(), systemNavigationBarIconBrightness: Brightness.light),
      ),
      body: GetBuilder<AllAudioCategoriesController>(
        builder: (controller) => controller.loader
            ? const CustomLoader()
            : controller.allCategoriesList.isEmpty
                ? SingleChildScrollView(
                  child: NoDataWidget(
                      messages: MyStrings.noCategoryFound.tr,
                    ),
                )
                : RefreshIndicator(
                    color: MyColor.primaryColor,
                    onRefresh: () async {
                      controller.getdata();
                    },
                    child: ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                      padding: const EdgeInsetsDirectional.only(top: Dimensions.space25),
                      itemCount: controller.allCategoriesList.length,
                      itemBuilder: (BuildContext context, int index) {
                        var categoryItem = controller.allCategoriesList[index];

                        List<QuizInfo>? levelList = categoryItem.quizInfos;
                        String subCategoryId = levelList != null && levelList.isNotEmpty && levelList[0].subCategoryId.toString() != '0' ? levelList[0].subCategoryId.toString() : '-1';

                        return AllAudioCategoryListTileCardWidget(
                          controller: controller,
                          categoryData: categoryItem,
                          onTap: () {
                            admobHelper.showInterstitialAd();
                            if (categoryItem.subcategoriesCount != '0') {
                              Get.toNamed(RouteHelper.audioQuestionSubCategoryScreen, arguments: [categoryItem.name, categoryItem.id.toString()]);
                            }
                            controller.changeExpandIndex(index);
                          },
                          title: categoryItem.name.toString(),
                          image: UrlContainer.allCategoriesImage + categoryItem.image.toString(),
                          fromViewAll: true,
                          subCategoryId: subCategoryId,
                          isExpand: subCategoryId == "" ? index == controller.expandIndex : false,
                          index: index,
                        );
                      }),
                  ),
      ),
    );
  }
}
