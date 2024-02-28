import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';
import 'package:quiz_lab/core/utils/my_color.dart';
import 'package:quiz_lab/core/utils/my_images.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/core/utils/style.dart';
import 'package:quiz_lab/data/controller/buy_credits/buy_credits_controller.dart';
import 'package:quiz_lab/view/components/app-bar/custom_appbar.dart';
import 'package:quiz_lab/view/components/custom_loader/custom_loader.dart';

class BuyCreditsScreen extends StatefulWidget {
  const BuyCreditsScreen({super.key});

  @override
  State<BuyCreditsScreen> createState() => _BuyCreditsScreenState();
}

class _BuyCreditsScreenState extends State<BuyCreditsScreen> {
  @override
  void initState() {
    BuyCoinsController controller = Get.put(BuyCoinsController());
    controller.loadProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BuyCoinsController>(
      builder: (controller) => Scaffold(
        body: Stack(
          children: [
            Container(height: Dimensions.space180, color: MyColor.primaryColor),
            const CustomAppBar(
              title: MyStrings.buyCredits,
              bgColor: Colors.transparent,
            ),
            controller.controllerLoading
                ? const Center(
                    child: CustomLoader(),
                  )
                : controller.packData.isEmpty
                    ?const Center(
                        child: Text(MyStrings.noPackAvailableRightNow),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: Dimensions.space15, vertical: Dimensions.space65),
                        child: ListView.separated(
                          separatorBuilder: (context, index) {
                            return Container(
                              color: MyColor.colorLightWhite,
                              height: Dimensions.space5,
                            );
                          },
                          itemCount: controller.packData.length,
                          itemBuilder: (context, index) {
                            final product = controller.packData[index];
                            return Container(
                              padding: const EdgeInsets.symmetric(vertical: Dimensions.space12),
                              color: MyColor.colorWhite,
                              child: ListTile(
                                tileColor: MyColor.colorWhite,
                                leading: Image.asset(
                                  MyImages.coinsImage,
                                  height: Dimensions.space35,
                                ),
                                title: Text(controller.packData[index].description.toString()),
                                trailing: Column(
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        print(index);
                                        controller.changeIndex(index);
                                        await controller.purchaseProduct(product);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(Dimensions.space5),
                                        margin: const EdgeInsets.only(top: Dimensions.space10),
                                        decoration: BoxDecoration(color: MyColor.buyCoinButtonColor, borderRadius: BorderRadius.circular(5)),
                                        child: Text(
                                          controller.packData[index].price.toString(),
                                          style: regularMediumLarge.copyWith(color: MyColor.colorWhite),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}
