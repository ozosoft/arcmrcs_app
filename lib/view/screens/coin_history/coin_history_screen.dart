import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quiz_lab/core/helper/date_converter.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';
import 'package:quiz_lab/core/utils/my_color.dart';
import 'package:quiz_lab/core/utils/my_images.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/core/utils/style.dart';
import 'package:quiz_lab/data/controller/coin_history/coin_history_controller.dart';
import 'package:quiz_lab/data/repo/coin_history/coin_history_repo.dart';
import 'package:quiz_lab/data/services/api_client.dart';
import 'package:quiz_lab/view/components/alert-dialog/custom_alert_dialog.dart';
import 'package:quiz_lab/view/components/app-bar/custom_category_appBar.dart';
import 'package:get/get.dart';
import 'package:quiz_lab/view/components/card/custom_card.dart';
import 'package:quiz_lab/view/components/text-form-field/custom_drop_down_text_field.dart';
import 'package:quiz_lab/view/screens/coin_history/widgets/filter_options.dart';

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
          children: const [
            FilterOptions()
          ],
        ),
        body: controller.loader == true
            ? const CustomLoader()
            : controller.coinHistoryList.isEmpty
                ? NoDataWidget(
                    messages: MyStrings.noCoinHistoryFound.tr,
                  )
                : Column(children: [
                  Visibility(
                    visible: controller.isFilterOn,
                    child:  Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: CustomCard(
                     width: double.infinity,
                                       child: Column(
                                     children: [
                                      
                     
                                    
                                       Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 16),
                      child: CustomDropDownTextField(
                        labelText: MyStrings.chooseAnOption,
                        selectedValue: controller.filterOptionList.first,
                        onChanged: (newValue) {
                          controller.selectedFilteredValue = newValue;
                          controller.filterdList();
                        },
                        items: controller.filterOptionList
                            .map<DropdownMenuItem<String>>(
                              (option) => DropdownMenuItem<String>(
                                value: option.toString(),
                                child: Text(option),
                              ),
                            )
                            .toList(),
                      ),
                                       )
                                     ],
                                   )),
                   ),
          
                )  ,
                  Expanded(
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsetsDirectional.only(top: Dimensions.space25),
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
                                           Text(coinHistoryItem.coinPlan != null ? coinHistoryItem.coinPlan!.title.toString().tr : '', style: semiBoldMediumLarge),
                  
                                            const SizedBox(
                                              height: Dimensions.space8,
                                            ),
                                            Text(
                                              DateConverter.formatDateTime(controller.coinHistoryList[index].createdAt.toString(), 'd MMM, yyyy h:mm a').tr,
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
                                      child: Text(
                    MyStrings.dollarSign.tr + (coinHistoryItem.coinPlan?.price ?? '').toString() + MyStrings.usd.tr,
                    style: semiBoldLarge.copyWith(
                      color: coinHistoryItem.status == "+" ? MyColor.colorGreen : coinHistoryItem.status == "-" ? MyColor.colorRed : Colors.black,
                    ),
                  ),
                  ),
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
     ],) ),
    );
  }
}
