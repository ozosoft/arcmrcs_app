import 'package:flutter/material.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';
import 'package:quiz_lab/core/utils/url_container.dart';
import 'package:quiz_lab/data/controller/sub_categories/sub_categories_controller.dart';
import 'package:quiz_lab/data/repo/sub_categories/sub_categories_repo.dart';
import 'package:quiz_lab/data/services/api_service.dart';
import 'package:quiz_lab/view/components/custom_loader/custom_loader.dart';
import 'package:get/get.dart';
import '../../../../core/helper/ads/admob_helper.dart';
import '../../../components/app-bar/custom_category_appbar.dart';
import 'widgets/sub_category_list_card_widget.dart';

class SubCategoriesCardScreen extends StatefulWidget {
  final String title;
  const SubCategoriesCardScreen({super.key, required this.title});

  @override
  State<SubCategoriesCardScreen> createState() => _SubCategoriesCardScreenState();
}

class _SubCategoriesCardScreenState extends State<SubCategoriesCardScreen> {
  String title = "";
  String subCategoryId = "";
  AdmobHelper admobHelper = AdmobHelper();
  @override
  void initState() {
    super.initState();
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(SubCategoriesRepo(apiClient: Get.find()));
    Get.put(SubCategoriesController(subCategoriesRepo: Get.find()));
    SubCategoriesController controller = Get.put(SubCategoriesController(subCategoriesRepo: Get.find()));

    title = Get.arguments[0] as String;
    subCategoryId = Get.arguments[1];

    admobHelper.createInterstitialAd();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getdata(subCategoryId);
    });
  }

  bool iscardexpand = false;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SubCategoriesController>(
      builder: (controller) => Scaffold(
        appBar: CustomCategoryAppBar(
          title: title,
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
                        padding: const EdgeInsetsDirectional.only(top: Dimensions.space25),
                        shrinkWrap: true,
                        itemCount: controller.subCategoriesList.length,
                        itemBuilder: (BuildContext context, int index) {
                          var categoryItem = controller.subCategoriesList[index];
                          return SubCategoryListTileCardWidget(
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
                  ],
                ),
              ),
      ),
    );
  }
}
