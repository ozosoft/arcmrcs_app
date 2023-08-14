import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/core/utils/style.dart';
import 'package:flutter_prime/view/components/app-bar/custom_category_appBar.dart';


class CoinHistoryScreen extends StatefulWidget {
  const CoinHistoryScreen({super.key});

  @override
  State<CoinHistoryScreen> createState() => _CoinHistoryScreenState();
}

class _CoinHistoryScreenState extends State<CoinHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:const CustomCategoryAppBar(title: MyStrings.coinHistory),
      body: ListView.builder(
          padding: const EdgeInsets.only(top: Dimensions.space25),
          shrinkWrap: true,
          itemCount: MyStrings().coinHistoryies.length,
          itemBuilder: (BuildContext context, int index) {
            final itemText = MyStrings().rewardsList[index];
            final isPlus = itemText.contains('+');
            final isMinus = itemText.contains('-');
            final textColor = isPlus
                ? MyColor.colorGreen
                : isMinus
                    ? MyColor.colorRed
                    : Colors.black;

            return Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.space15, vertical: Dimensions.space5),
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
                                Text(
                                    MyStrings()
                                        .coinHistoryies[index]['title']
                                        .toString(),
                                    style: semiBoldMediumLarge),
                                const SizedBox(
                                  height: Dimensions.space8,
                                ),
                                Text(
                                  MyStrings()
                                      .coinHistoryies[index]['date']
                                      .toString(),
                                  style: regularLarge.copyWith(
                                      color: MyColor.textColor),
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
                              itemText,
                              style: semiBoldLarge.copyWith(color: textColor))),
                      const SizedBox(
                        width: Dimensions.space10,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
