import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_images.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/core/utils/style.dart';
import 'package:flutter_prime/view/components/buttons/level_card_button.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ReviewAnswerSection extends StatefulWidget {
  const ReviewAnswerSection({super.key});

  @override
  State<ReviewAnswerSection> createState() => _ReviewAnswerSectionState();
}

class _ReviewAnswerSectionState extends State<ReviewAnswerSection> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.space20),
            color: MyColor.colorWhite),
        padding: const EdgeInsets.all(Dimensions.space20),
       
        child: Column(
          children: [
            Container(
                padding: const EdgeInsets.only(
                    top: Dimensions.space20,
                    left: Dimensions.space15,
                    right: Dimensions.space20),
                child: Text(
                  MyStrings.quizQuestions,
                  style: semiBoldExtraLarge.copyWith(fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                )),
            const SizedBox(
              height: Dimensions.space25,
            ),
            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: MyStrings().quizquestions.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: const EdgeInsets.all(Dimensions.space5),
                    padding: const EdgeInsets.all(Dimensions.space14),
                    decoration: BoxDecoration(
                        color: MyColor.quizquestionsColor[index],
                        borderRadius: BorderRadius.circular(Dimensions.space8),
                        border: Border.all(color: MyColor.colorLightGrey)),
                    child: Row(
                      children: [
                        Text(
                          MyStrings().quizquestions[index].rank,
                          style: regularMediumLarge.copyWith(
                              color: MyColor.quizquestionsTextColor[index]),
                        ),
                        const SizedBox(width: Dimensions.space8),
                        Text(
                          MyStrings().quizquestions[index].questions,
                          style: regularMediumLarge.copyWith(
                              color: MyColor.quizquestionsTextColor[index]),
                        ),
                        const Spacer(),
                        SvgPicture.asset(
                          MyImages().rightORWrong[index],
                          fit: BoxFit.cover,
                        )
                      ],
                    ),
                  );
                }),
             const SizedBox(
              height: Dimensions.space25,
            ),
            InkWell(
              onTap: () {
                setState(() {});
              },
              child: const LevelCardButton(
                hasIcon: false,
                height: Dimensions.space45,
                width: Dimensions.space78,
                hasImage: false,
                text: MyStrings.twobyTen,
              ),
            ),
            const SizedBox(
              height: Dimensions.space25,
            ),
          ],
        ),
      ),
    );
  }
}
