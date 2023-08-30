import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_images.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/core/utils/style.dart';
import 'package:flutter_prime/data/controller/coin_store/coin_store_controller.dart';
import 'package:flutter_prime/data/repo/coin_store/coin_store_repo.dart';
import 'package:flutter_prime/data/services/api_service.dart';
import 'package:flutter_prime/view/components/app-bar/custom_category_appBar.dart';
import 'package:flutter_prime/view/components/custom_loader/custom_loader.dart';
import 'package:flutter_prime/view/components/divider/custom_vertical_divider.dart';
import 'package:flutter_prime/view/components/no_data.dart';
import 'package:flutter_prime/view/screens/coin_store/deposit_widget/deposit_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../core/utils/dimensions.dart';

class CoinStoreScreen extends StatefulWidget {
  const CoinStoreScreen({super.key});

  @override
  State<CoinStoreScreen> createState() => _CoinStoreScreenState();
}

class _CoinStoreScreenState extends State<CoinStoreScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(CoinStoreRepo(apiClient: Get.find()));

    CoinStoreController controller = Get.put(CoinStoreController(coinStoreRepo: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getdata();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomCategoryAppBar(title: MyStrings.coins),
      body: GetBuilder<CoinStoreController>(
        builder: (controller) => controller.loader == true
            ? const CustomLoader()
            : controller.coinPlanList.isNotEmpty
                ? const NoDataWidget()
                : ListView.builder(
                    padding: const EdgeInsets.only(top: Dimensions.space25),
                    shrinkWrap: true,
                    itemCount: controller.coinPlanList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: Dimensions.space15, vertical: Dimensions.space5),
                        child: InkWell(
                          onTap: () {
                            // CustomBottomSheet(child: const PaymentBottomSheetScreen())
                            //     .customBottomSheet(context);

                            Get.to(() => NewDepositScreen(
                                  price: controller.coinPlanList[index].price.toString(),
                                  id: controller.coinPlanList[index].id.toString(),
                                ));
                          },
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
                                        SvgPicture.asset(
                                          MyImages.coin,
                                          fit: BoxFit.cover,
                                          height: Dimensions.space30,
                                        ),
                                        const SizedBox(
                                          width: Dimensions.space10,
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              controller.coinPlanList[index].title.toString(),
                                              style: regularLarge.copyWith(color: MyColor.textColor),
                                            ),
                                            const SizedBox(
                                              height: Dimensions.space5,
                                            ),
                                            Text(
                                              controller.coinPlanList[index].coinsAmount.toString(),
                                              style: semiBoldMediumLarge.copyWith(fontWeight: FontWeight.w500),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: Dimensions.space10,
                                  ),
                                  const CustomVerticalDivider(
                                    height: Dimensions.space30,
                                  ),
                                  const SizedBox(
                                    width: Dimensions.space20,
                                  ),
                                  SizedBox(child: Text(MyStrings.dollarSign + controller.coinPlanList[index].price.toString() + MyStrings.usd, style: semiBoldExtraLarge))
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
      ),
    );
  }
}
