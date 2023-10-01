import 'package:flutter/material.dart';
import 'package:quiz_lab/core/helper/date_converter.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';
import 'package:quiz_lab/core/utils/my_color.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/core/utils/style.dart';
import 'package:quiz_lab/data/controller/coin_history/coin_history_controller.dart';
import 'package:quiz_lab/data/repo/coin_history/coin_history_repo.dart';
import 'package:quiz_lab/data/services/api_client.dart';
import 'package:quiz_lab/view/components/app-bar/custom_category_appbar.dart';
import 'package:get/get.dart';

import '../../components/custom_loader/custom_loader.dart';
import '../../components/no_data.dart';

class CoinHistoryScreen extends StatefulWidget {
  const CoinHistoryScreen({super.key});

  @override
  State<CoinHistoryScreen> createState() => _CoinHistoryScreenState();
}

class _CoinHistoryScreenState extends State<CoinHistoryScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(CoinHistoryRepo(apiClient: Get.find()));

    CoinHistoryController controller = Get.put(CoinHistoryController(coinHistoryRepo: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getdata();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CoinHistoryController>(
      builder: (controller) => Scaffold(
        appBar: CustomCategoryAppBar(
          title: MyStrings.coinHistory.tr,
        ),
        body: controller.loader == true
            ? const CustomLoader()
            : controller.coinHistoryList.isEmpty
                ? NoDataWidget(
                    messages: MyStrings.noCoinHistoryFound.tr,
                  )
                : ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsetsDirectional.only(top: Dimensions.space25),
                    // shrinkWrap: true,
                    itemCount: controller.coinHistoryList.length,
                    itemBuilder: (BuildContext context, int index) {
                      final coinHistoryItem = controller.coinHistoryList[index];

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: Dimensions.space15, vertical: Dimensions.space5),
                        child: Card(
                          elevation: 0.2,
                          child: Padding(
                            padding: const EdgeInsets.all(Dimensions.space6),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(
                                    Dimensions.space10,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                        width: Dimensions.space10,
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(coinHistoryItem.coinPlan!.title.toString().tr, style: semiBoldMediumLarge),
                                          const SizedBox(
                                            height: Dimensions.space8,
                                          ),
                                          Text(
                                            DateConverter.isoStringToLocalFormattedDateAndTimeOnly(controller.coinHistoryList[index].createdAt!.toIso8601String()).tr,
                                            style: regularLarge.copyWith(color: MyColor.textColor),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: Dimensions.space10,
                                ),
                                const Spacer(),
                                SizedBox(
                                    child: Text(MyStrings.dollarSign.tr + controller.coinHistoryList[index].coinPlan!.price.toString() + MyStrings.usd.tr,
                                        style: semiBoldLarge.copyWith(
                                            color: coinHistoryItem.status == "+"
                                                ? MyColor.colorGreen
                                                : coinHistoryItem.status == "-"
                                                    ? MyColor.colorRed
                                                    : Colors.black))),
                                const SizedBox(
                                  width: Dimensions.space10,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
      ),
    );
  }
}
