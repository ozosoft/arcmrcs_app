import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/style.dart';
import 'package:flutter_prime/data/controller/coin_store/deposit/add_new_deposit_controller.dart';
import 'package:flutter_prime/data/repo/coin_store/deposit/deposit_repo.dart';
import 'package:flutter_prime/view/components/app-bar/custom_category_appBar.dart';
import 'package:flutter_prime/view/components/buttons/rounded_button.dart';
import 'package:flutter_prime/view/components/buttons/rounded_loading_button.dart';
import 'package:flutter_prime/view/components/custom_loader/custom_loader.dart';
import 'package:flutter_prime/view/components/text-form-field/custom_amount_text_field.dart';
import 'package:flutter_prime/view/components/text-form-field/custom_drop_down_text_field.dart';
import 'package:get/get.dart';

import '../../../../../core/utils/dimensions.dart';
import '../../../../../core/utils/my_color.dart';
import '../../../../../core/utils/my_strings.dart';
import '../../../../../data/model/deposit/deposit_method_response_model.dart';

import '../../../../../data/services/api_service.dart';

import 'info_widget.dart';

class NewDepositScreen extends StatefulWidget {
  final String price, id;
  const NewDepositScreen({Key? key, required this.price, required this.id}) : super(key: key);

  @override
  State<NewDepositScreen> createState() => _NewDepositScreenState();
}

class _NewDepositScreenState extends State<NewDepositScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(DepositRepo(apiClient: Get.find()));
    final controller = Get.put(AddNewDepositController(
      depositRepo: Get.find(),
    ));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getDepositMethod(widget.price);
    });
  }

  @override
  void dispose() {
    Get.find<AddNewDepositController>().clearData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddNewDepositController>(
      builder: (controller) => SafeArea(
          child: Scaffold(
        backgroundColor: MyColor.getScreenBgColor(),
        appBar: const CustomCategoryAppBar(title: MyStrings.deposit),
        body: controller.isLoading
            ? const CustomLoader()
            : SingleChildScrollView(
                padding: Dimensions.screenPaddingHV,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: MyColor.getScreenBgColor(),
                    borderRadius: BorderRadius.circular(Dimensions.defaultRadius),
                  ),
                  child: Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomDropDownTextField(
                            labelText: MyStrings.paymentMethod.tr,
                            selectedValue: controller.paymentMethod,
                            onChanged: (newValue) {
                              controller.setPaymentMethod(newValue);
                            },
                            items: controller.methodList.map((Methods bank) {
                              return DropdownMenuItem<Methods>(
                                value: bank,
                                child: Text((bank.name ?? '').tr, style: regularDefault),
                              );
                            }).toList()),
                        const SizedBox(height: Dimensions.space15),
                        CustomAmountTextField(
                          labelText: MyStrings.amount.tr,
                          hintText: MyStrings.enterAmount.tr,
                          inputAction: TextInputAction.done,
                          currency: controller.currency,
                          readOnly: true,
                          controller: controller.amountController,
                          onChanged: (value) {
                            if (value.toString().isEmpty) {
                              controller.changeInfoWidgetValue(0);
                            } else {
                              double amount = double.tryParse(value.toString()) ?? 0;
                              controller.changeInfoWidgetValue(amount);
                            }
                            return;
                          },
                        ),
                        controller.paymentMethod?.name != MyStrings.selectOne ? const InfoWidget() : const SizedBox(),
                        const SizedBox(height: 35),
                        controller.submitLoading
                            ? const RoundedLoadingBtn()
                            : RoundedButton(
                                text: MyStrings.submit,
                                textColor: MyColor.colorWhite,
                                textSize: Dimensions.space17,
                                width: double.infinity,
                                press: () {
                                  controller.submitDeposit(widget.id);
                                },
                              )
                      ],
                    ),
                  ),
                ),
              ),
      )),
    );
  }
}
