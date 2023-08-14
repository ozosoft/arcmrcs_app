import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_images.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/core/utils/style.dart';
import 'package:flutter_prime/view/components/app-bar/custom_category_appBar.dart';
import 'package:flutter_prime/view/components/bottom-sheet/custom_bottom_sheet.dart';
import 'package:flutter_prime/view/components/divider/custom_vertical_divider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/utils/dimensions.dart';
import '../wallet/widgets/coin-redeem/payment_bottomSheet.dart';

class CoinStoreScreen extends StatefulWidget {
  const CoinStoreScreen({super.key});

  @override
  State<CoinStoreScreen> createState() => _CoinStoreScreenState();
}

class _CoinStoreScreenState extends State<CoinStoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomCategoryAppBar(title: MyStrings.coins),
      body: ListView.builder(
          padding: const EdgeInsets.only(top: Dimensions.space25),
          shrinkWrap: true,
          itemCount: MyStrings().coinsReedemdetails.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.space15, vertical: Dimensions.space5),
              child: InkWell(
                onTap: () {
                  CustomBottomSheet(child: const PaymentBottomSheetScreen())
                      .customBottomSheet(context);
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
                                    MyStrings()
                                        .coinsReedemdetails[index]['pack_name']
                                        .toString(),
                                    style: regularLarge.copyWith(
                                        color: MyColor.textColor),
                                  ),
                                  const SizedBox(
                                    height: Dimensions.space5,
                                  ),
                                  Text(
                                    MyStrings()
                                        .coinsReedemdetails[index]
                                            ['total_coins']
                                        .toString(),
                                    style: semiBoldMediumLarge.copyWith(
                                        fontWeight: FontWeight.w500),
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
                        SizedBox(
                            child: Text(
                                MyStrings()
                                    .coinsReedemdetails[index]['price']
                                    .toString(),
                                style: semiBoldExtraLarge))
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
