import 'package:flutter/material.dart';
import 'package:flutter_prime/core/route/route.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/core/utils/url_container.dart';
import 'package:flutter_prime/data/controller/all_categories/all_categories_controller.dart';
import 'package:flutter_prime/data/model/all_cartegories/all_categories_model.dart';
import 'package:flutter_prime/data/repo/allcategories/all_categories_repo.dart';
import 'package:flutter_prime/data/services/api_service.dart';
import 'package:flutter_prime/view/components/app-bar/custom_category_appBar.dart';
import 'package:flutter_prime/view/screens/categories/all-categories/widgets/category_card_widget.dart';
import 'package:get/get.dart';
import '../../../components/category-card/categories_card.dart';

class AllCategoriesScreen extends StatefulWidget {
  const AllCategoriesScreen({super.key});

  @override
  State<AllCategoriesScreen> createState() => _AllCategoriesScreenState();
}

class _AllCategoriesScreenState extends State<AllCategoriesScreen> {
  @override
  void initState() {

    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(AllCategoriesRepo(apiClient: Get.find()));
    AllCategoriesController controller = Get.put(AllCategoriesController(allCategoriesRepo: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomCategoryAppBar(title: MyStrings.allCategory),
      body: GetBuilder<AllCategoriesController>(
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

                    List<QuizInfo>? levelList = controller.allCategoriesList[index].quizInfos;
                    String subCategoryId = levelList != null && levelList.isNotEmpty && levelList[0].subCategoryId.toString() != 'null' ?
                    levelList[0].subCategoryId.toString() : '-1';

                    String title = controller.allCategoriesList[index].name.toString();

                    return InkWell(
                      onTap: () {
                        if (subCategoryId != "") {
                          Get.toNamed(RouteHelper.subCategories, arguments: [title, controller.allCategoriesList[index].id.toString()]);
                        }
                        controller.changeExpandIndex(index);
                      },
                      child: AllCategoriesListItem(
                        title: title,
                        questions: controller.allCategoriesList[index].questionsCount.toString(),
                        image: UrlContainer.allCategoriesImage + controller.allCategoriesList[index].image.toString(),
                        subCategoryId: subCategoryId,
                        isExpand: subCategoryId == "" ? index == controller.expandIndex : false,
                        index: index,
                        levelList: controller.allCategoriesList[index].quizInfos ?? [],
                        fromAllCategory: true,
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
