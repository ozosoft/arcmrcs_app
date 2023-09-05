import 'package:flutter/material.dart';
import 'package:flutter_prime/core/helper/string_format_helper.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_images.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/core/utils/style.dart';
import 'package:flutter_prime/data/controller/coin_store/coin_store_controller.dart';
import 'package:flutter_prime/data/services/api_service.dart';
import 'package:flutter_prime/view/components/app-bar/custom_category_appBar.dart';
import 'package:flutter_prime/view/components/custom_loader/custom_loader.dart';
import 'package:flutter_prime/view/components/divider/custom_vertical_divider.dart';
import 'package:flutter_prime/view/components/no_data.dart';
import 'package:flutter_prime/view/screens/coin_store/deposit_widget/deposit_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../core/utils/dimensions.dart';
import '../../../data/repo/coin_store/coin_store_repo.dart';

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
      controller.getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomCategoryAppBar(title: MyStrings.coinStore),
      body: GetBuilder<CoinStoreController>(
        builder: (controller) => controller.isLoading == true
            ? const CustomLoader()
            : controller.coinPlanList.isEmpty
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
                                  Expanded(
                                    flex: 3,
                                    child: Container(
                                    padding: const EdgeInsets.all(
                                      Dimensions.space10,
                                    ),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          MyImages.coin,
                                          fit: BoxFit.cover,
                                          height: Dimensions.space30,
                                        ),
                                        const SizedBox(
                                          width: Dimensions.space10,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                               controller.coinPlanList[index].title?.tr ?? '',
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: regularLarge.copyWith(color: MyColor.textColor),
                                              ),
                                              const SizedBox(
                                                height: Dimensions.space5,
                                              ),
                                              Text(
                                               Converter.roundDoubleAndRemoveTrailingZero( controller.coinPlanList[index].coinsAmount??'0'),
                                                style: semiBoldMediumLarge.copyWith(fontWeight: FontWeight.w500),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                                 Expanded(
                                   flex: 4,
                                    child: Row(
                                   children: [
                                     const SizedBox(
                                       width: Dimensions.space10,
                                     ),
                                     const CustomVerticalDivider(
                                       height: Dimensions.space30,
                                     ),
                                     const SizedBox(
                                       width: Dimensions.space20,
                                     ),
                                     SizedBox(child: Text( "${Converter.formatNumber(controller.coinPlanList[index].price ?? '00')} ${controller.currency}", style: semiBoldExtraLarge))
                                   ],
                                 ))
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
