import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/widgets.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';
import 'package:quiz_lab/core/utils/my_color.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/core/utils/style.dart';

class RefferalCodeSection extends StatefulWidget {
  const RefferalCodeSection({super.key});

  @override
  State<RefferalCodeSection> createState() => _RefferalCodeSectionState();
}

class _RefferalCodeSectionState extends State<RefferalCodeSection> {
  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              MyStrings.refferalCode.toUpperCase(),
              style: semiBoldLarge,
            ),
            const SizedBox(
              height: Dimensions.space10,
            ),
            DottedBorder(
              borderType: BorderType.RRect,
              radius: const Radius.circular(Dimensions.space8),
              dashPattern: [8, 10],
              color: MyColor.lightGreyTextColor,
              strokeWidth: 2,
              child: Container(
                padding:const EdgeInsets.all(10),
                decoration: BoxDecoration(color: MyColor.colorYellow.withOpacity(.2)),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                 const Text(
                    "EKREF3123",
                    style: semiBoldExtraLarge,
                  ),
                  Text(
                    MyStrings.tapToShare,
                    style: semiBoldDefault.copyWith(color: MyColor.greyTextColor),
                  )
                ]),
              ),
            ),
            const SizedBox(
              height: Dimensions.space40,
            ),
            const Text(
              MyStrings.referByFriends,
              style: regularMediumLarge,
            ),
          ]),
        ),
      ],
    );
  }
}