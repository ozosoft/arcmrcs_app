import 'package:flutter/material.dart';
import 'package:flutter_prime/core/route/route.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/core/utils/url_container.dart';
import 'package:flutter_prime/data/controller/play_diffrent_quizes/fun_n_learn/fun_n_learn_controller.dart';
import 'package:flutter_prime/data/repo/play_diffrent_quizes/fun_n_learn/fun_n_learn_repo.dart';
import 'package:flutter_prime/data/services/api_service.dart';
import 'package:flutter_prime/view/components/app-bar/custom_category_appBar.dart';
import 'package:get/get.dart';
import '../../../../data/model/play_diffrent_quizes/fun_n_learn/fun_n_learn_category_model.dart';
import '../../../components/category-card/categories_card.dart';

class FunNLearnScreen extends StatefulWidget {
  const FunNLearnScreen({super.key});

  @override
  State<FunNLearnScreen> createState() => _FunNLearnScreenState();
}

class _FunNLearnScreenState extends State<FunNLearnScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(FunNLearnRepo(apiClient: Get.find()));
    
    FunNLearnCategoriesController controller =
        Get.put(FunNLearnCategoriesController(funNLearnRepo: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getFunNLearndata();

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomCategoryAppBar(title: MyStrings.funAndLearn),
      body: GetBuilder<FunNLearnCategoriesController>(
        builder: (controller) => SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(top: Dimensions.space25),
                  shrinkWrap: true,
                  itemCount: controller.allCategoriesList.length,
                  itemBuilder: (BuildContext context, int index) {
                    List<Category>? levelList = controller.allCategoriesList;
                    String subCategoryId = levelList != null &&
                            levelList.isNotEmpty &&
                            levelList[0].subcategoriesCount.toString() != 'null'
                        ? levelList[0].subcategoriesCount.toString()
                        : '-1';
                    String title =
                        controller.allCategoriesList[index].name.toString();
                    return InkWell(
                      onTap: () {
                        controller
                            .allCategoriesList[index].subcategoriesCount
                            .toString() == "0"
                            ? const SizedBox()
                            : Get.toNamed(RouteHelper.funNlearnSubCategoryScreenScreen,
                                arguments: [title,  controller
                            .allCategoriesList[index].id
                            .toString()]);
                      
                      },
                      child: CategoriesCard(
                       
                        title: title,
                        questions: controller
                            .allCategoriesList[index].quizInfosCount
                            .toString(),
                        image: UrlContainer.funNLearnsubCategoryImage +
                            controller.allCategoriesList[index].image
                                .toString(),
                        expansionVisible: false,
                        fromViewAll: true,
                        subCategoryId: subCategoryId,
                        index: index,
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
