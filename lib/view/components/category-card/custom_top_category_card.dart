import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/core/utils/style.dart';
import 'package:flutter_prime/view/components/image_widget/my_image_widget.dart';

class CustomTopCategoryCard extends StatelessWidget {
  final String title, questionsQuantaty, image;
  final int? index;

  const CustomTopCategoryCard({
    super.key,
    required this.title,
    required this.questionsQuantaty,
    required this.image,
    this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimensions.space5),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: Dimensions.space1),
        width: Dimensions.space103,
        decoration: BoxDecoration(
          color: MyColor.cardBgLighGreyColor,
          border: Border.all(color: MyColor.primaryColor.withOpacity(0.05)),
          borderRadius: BorderRadius.circular(Dimensions.space8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image.network(image),
            MyImageWidget(
              imageUrl: image,
              width: Dimensions.space40,
              height: Dimensions.space40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: Dimensions.space10, horizontal: Dimensions.space5),
              child: Text(
                title.toString(),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: mediumDefault.copyWith(fontWeight: FontWeight.normal, color: MyColor.primaryTextColor),
              ),
            ),
            Text(
              questionsQuantaty + MyStrings.questionse,
              textAlign: TextAlign.center,
              style: regularDefault.copyWith(color: MyColor.colorlighterGrey, fontSize: Dimensions.space12),
            )
          ],
        ),
      ),
    );
  }
}
