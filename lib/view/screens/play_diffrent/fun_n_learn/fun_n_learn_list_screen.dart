import 'package:flutter/material.dart';
import 'package:flutter_prime/core/route/route.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/data/controller/play_diffrent_quizes/fun_n_learn/fun_n_learn_description.dart';
import 'package:flutter_prime/data/repo/play_diffrent_quizes/fun_n_learn/fun_n_learn_repo.dart';
import 'package:flutter_prime/data/services/api_service.dart';
import 'package:flutter_prime/view/components/app-bar/custom_category_appBar.dart';
import 'package:flutter_prime/view/components/category-card/categories_card.dart';
import 'package:flutter_prime/view/components/custom_loader/custom_loader.dart';
import 'package:get/get.dart';

class FunNlearnListScreen extends StatefulWidget {
  final String title;
  const FunNlearnListScreen({super.key, required this.title});

  @override
  State<FunNlearnListScreen> createState() => _FunNlearnListScreenState();
}

class _FunNlearnListScreenState extends State<FunNlearnListScreen> {
  String title = "";
  String subCategoryId = "";

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(FunNLearnRepo(apiClient: Get.find()));
    Get.put(FunNLearnListController(
      funNLearnRepo: Get.find(),
    ));
    FunNLearnListController controller = Get.put(FunNLearnListController(funNLearnRepo: Get.find()));

    title = Get.arguments[0] as String;
    subCategoryId = Get.arguments[1];

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getFunAndLearnDescriprion(subCategoryId);
    });
  }

  bool iscardexpand = false;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FunNLearnListController>(
      builder: (controller) => Scaffold(
        appBar: CustomCategoryAppBar(
          title: title,
        ),
        body: controller.loader
            ? CustomLoader()
            : SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.only(top: Dimensions.space25),
                        shrinkWrap: true,
                        itemCount: controller.fun_N_Learn_descriptionList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              Get.toNamed(RouteHelper.funNlearnDescriptionScreen,arguments: [controller.fun_N_Learn_descriptionList[index].title.toString(),controller.fun_N_Learn_descriptionList[index].id.toString(),controller.fun_N_Learn_descriptionList[index].description.toString()]);
                              controller.changeExpandIndex(index);
                            },
                            child: CategoriesCard(
                              index: index,
                              // image: UrlContainer.subCategoriesImage +
                              //     controller.fun_N_Learn_descriptionList[index].image
                              //         .toString(),
                              title: controller.fun_N_Learn_descriptionList[index].title.toString(),
                              questions: controller.fun_N_Learn_descriptionList[index].questionsCount.toString(),
                              expansionVisible: false,
                              fromViewAll: false,
                              isExpand: index == controller.expandIndex,
                              // levels: controller.itemCount.toString(),
                            ),
                          );
                        }),
                  ],
                ),
              ),
      ),
    );
  }
}