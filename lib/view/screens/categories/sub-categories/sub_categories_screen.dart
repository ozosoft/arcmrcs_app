import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/url_container.dart';
import 'package:flutter_prime/data/controller/sub_categories/sub_categories_controller.dart';
import 'package:flutter_prime/data/repo/sub_categories/sub_categories_repo.dart';
import 'package:flutter_prime/data/services/api_service.dart';
import 'package:flutter_prime/view/components/custom_loader/custom_loader.dart';
import 'package:flutter_prime/view/screens/categories/sub-categories/sub_catergory_card_widget.dart';
import 'package:get/get.dart';
import '../../../components/app-bar/custom_category_appBar.dart';

class SubCategoriesScreen extends StatefulWidget {
  final String title;
  const SubCategoriesScreen({super.key, required this.title});

  @override
  State<SubCategoriesScreen> createState() =>
      _SubCategoriesScreenState();
}

class _SubCategoriesScreenState extends State<SubCategoriesScreen> {

  String subCategoryId = "";

  @override
  void initState() {

    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(SubCategoriesRepo(apiClient: Get.find()));
    Get.put(SubCategoriesController(subCategoriesRepo: Get.find()));
    SubCategoriesController controller = Get.put(SubCategoriesController(subCategoriesRepo: Get.find()));

    String title = Get.arguments[0] as String;
    subCategoryId = Get.arguments[1];

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getData(subCategoryId,title);
    });
  }


  @override
  Widget build(BuildContext context) {
    return GetBuilder<SubCategoriesController>(
      builder: (controller) => Scaffold(
              appBar: CustomCategoryAppBar(
                title: controller.title,
              ),
              body: controller.isLoading
          ? const CustomLoader()
          :  SingleChildScrollView(
           
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
                          return InkWell(
                            onTap: () {
                              controller.changeExpandIndex(index);
                            },
                            child: SubCategoriesListItem(
                              title: controller.title,
                              questions: controller.subCategoriesList[index].questionsCount.toString(),
                              image: UrlContainer.subCategoriesImage + controller.subCategoriesList[index].image.toString(),
                              subCategoryId: subCategoryId,
                              isExpand:  index == controller.expandIndex ,
                              index: index,
                              levelList: controller.subCategoriesList[index].quizInfos ?? [],

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
