import 'package:flutter/material.dart';
import 'package:flutter_prime/core/route/route.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/core/utils/url_container.dart';
import 'package:flutter_prime/data/controller/play_different_quizes/fun_n_learn/fun_n_learn_controller.dart';
import 'package:flutter_prime/data/repo/play_different_quizes/fun_n_learn/fun_n_learn_repo.dart';
import 'package:flutter_prime/data/services/api_service.dart';
import 'package:flutter_prime/view/components/app-bar/custom_category_appBar.dart';
import 'package:get/get.dart';
import '../../../../core/helper/ads/admob_helper.dart';
import '../../../../data/model/play_different_quizes/fun_n_learn/fun_n_learn_category_model.dart';
import '../../../components/category-card/categories_card.dart';
import '../../../components/custom_loader/custom_loader.dart';

class FunNLearnScreen extends StatefulWidget {
  const FunNLearnScreen({super.key});

  @override
  State<FunNLearnScreen> createState() => _FunNLearnScreenState();
}

class _FunNLearnScreenState extends State<FunNLearnScreen> {
  AdmobHelper admobHelper = AdmobHelper();

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(FunNLearnRepo(apiClient: Get.find()));

    FunNLearnCategoriesController controller = Get.put(FunNLearnCategoriesController(funNLearnRepo: Get.find()));

    super.initState();
    admobHelper.createInterstitialAd();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getFunNLearndata();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomCategoryAppBar(title: MyStrings.funAndLearn.tr),
      body: GetBuilder<FunNLearnCategoriesController>(
        builder: (controller) => (controller.loader != false)
            ? const Center(child: CustomLoader())
            : SingleChildScrollView(
                physics: const ScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsetsDirectional.only(top: Dimensions.space25),
                        shrinkWrap: true,
                        itemCount: controller.allCategoriesList.length,
                        itemBuilder: (BuildContext context, int index) {
                          List<Category>? levelList = controller.allCategoriesList;
                          String subCategoryId = levelList.isNotEmpty && levelList[0].subcategoriesCount.toString() != 'null' ? levelList[0].subcategoriesCount.toString() : '-1';
                          String title = controller.allCategoriesList[index].name.toString();
                          return CategoriesCard(
                              title: title,
                              questions: controller.allCategoriesList[index].quizInfosCount.toString(),
                              image: UrlContainer.funNLearnsubCategoryImage + controller.allCategoriesList[index].image.toString(),
                              imageMainPath: controller.allCategoriesList[index].image.toString(),
                              expansionVisible: false,
                              fromViewAll: false,
                              showLevel: false,
                              subCategoryId: subCategoryId,
                              fromFunNlearn: true,
                              index: index,
                              onTap: () {
                                if (controller.allCategoriesList[index].subcategoriesCount.toString() == "0") {
                                  Get.toNamed(RouteHelper.funNlearnListScreen, arguments: [controller.allCategoriesList[index].name.toString(), controller.allCategoriesList[index].id.toString(), "null"]);
                                } else {
                                  admobHelper.showInterstitialAd();
                                  Get.toNamed(RouteHelper.funNlearnSubCategoryScreenScreen, arguments: [title, controller.allCategoriesList[index].id.toString()]);
                                }
                              });
                        }),
                  ],
                ),
              ),
      ),
    );
  }
}
