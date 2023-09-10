import 'package:flutter/material.dart';
import 'package:flutter_prime/core/route/route.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/url_container.dart';
import 'package:flutter_prime/data/controller/play_different_quizes/fun_n_learn/fun_n_learn_sub_categories_controller.dart';
import 'package:flutter_prime/data/repo/play_different_quizes/fun_n_learn/fun_n_learn_repo.dart';
import 'package:flutter_prime/data/services/api_service.dart';
import 'package:flutter_prime/view/components/app-bar/custom_category_appBar.dart';
import 'package:flutter_prime/view/components/category-card/categories_card.dart';
import 'package:flutter_prime/view/components/custom_loader/custom_loader.dart';
import 'package:get/get.dart';

class FunNLearnSubCategoriesCardScreen extends StatefulWidget {
  final String title;
  const FunNLearnSubCategoriesCardScreen({super.key, required this.title});

  @override
  State<FunNLearnSubCategoriesCardScreen> createState() => _FunNLearnSubCategoriesCardScreenState();
}

class _FunNLearnSubCategoriesCardScreenState extends State<FunNLearnSubCategoriesCardScreen> {
  String title = "";
  String subCategoryId = "";

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(FunNLearnRepo(apiClient: Get.find()));
    Get.put(FunNLearnSubCategoriesController(
      funNLearnRepo: Get.find(),
    ));
    FunNLearnSubCategoriesController controller = Get.put(FunNLearnSubCategoriesController(funNLearnRepo: Get.find()));

    title = Get.arguments[0] as String;
    subCategoryId = Get.arguments[1];

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getdata(subCategoryId);
    });
  }

  bool iscardexpand = false;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FunNLearnSubCategoriesController>(
      builder: (controller) => Scaffold(
        appBar: CustomCategoryAppBar(
          title: title.tr,
        ),
        body: controller.loader
            ? const CustomLoader()
            : SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.only(top: Dimensions.space25),
                        shrinkWrap: true,
                        itemCount: controller.subCategoriesList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return CategoriesCard(
                            index: index,
                            image: UrlContainer.subCategoriesImage + controller.subCategoriesList[index].image.toString(),
                            title: controller.subCategoriesList[index].name.toString(),
                            questions: controller.subCategoriesList[index].quizInfosCount.toString(),
                            expansionVisible: false,
                            fromViewAll: false,
                            isExpand: false,
                            showLevel: false,
                            levels: controller.itemCount.toString(),
                            fromFunNlearn: true,
                            onTap: () {
                              String title = controller.subCategoriesList[index].name.toString();
                              controller.showExpandedSection = true;
                              controller.changeExpandIndex(index);

                              Get.toNamed(RouteHelper.funNlearnListScreen, arguments: [controller.subCategoriesList[index].name.toString(), controller.subCategoriesList[index].id.toString(), controller.subCategoriesList[index].categoryId.toString()]);
                            },
                          );
                        }),
                  ],
                ),
              ),
      ),
    );
  }
}
