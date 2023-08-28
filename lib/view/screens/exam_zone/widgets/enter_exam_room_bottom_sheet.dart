import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/core/utils/style.dart';
import 'package:flutter_prime/data/controller/exam_zone/exam_zone_controller.dart';
import 'package:flutter_prime/data/repo/exam_zone/exam_zone_repo.dart';
import 'package:flutter_prime/data/services/api_service.dart';
import 'package:flutter_prime/view/components/bottom-sheet/bottom_sheet_bar.dart';
import 'package:flutter_prime/view/components/buttons/rounded_button.dart';
import 'package:flutter_prime/view/components/otp_field_widget/otp_field_widget.dart';
import 'package:flutter_prime/view/components/text/default_text.dart';
import 'package:get/get.dart';

class EnterRoomBottomSheetWidget extends StatefulWidget {
  final String quizInfo_id;
  EnterRoomBottomSheetWidget({super.key, required this.quizInfo_id});

  @override
  State<EnterRoomBottomSheetWidget> createState() => _EnterRoomBottomSheetWidgetState();
}

class _EnterRoomBottomSheetWidgetState extends State<EnterRoomBottomSheetWidget> {
  bool viewAll = false;
  bool agree = false;

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(ExamZoneRepo(apiClient: Get.find()));

     Get.put(ExamZoneController(
      examZoneRepo: Get.find(),
    ));

    super.initState();

   
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ExamZoneController>(
      builder: (controller) => Padding(
        padding: const EdgeInsets.only(top: Dimensions.space10, left: Dimensions.space10, right: Dimensions.space10),
        child: Column(
          children: [
            const BottomSheetBar(),
            const SizedBox(height: Dimensions.space20),
            const Text(
              MyStrings.enterExam,
              style: semiBoldExtraLarge,
            ),
            const SizedBox(height: Dimensions.space15),
            Text(MyStrings.examKey,
                style: regularLarge.copyWith(
                  color: MyColor.textColor,
                )),
            const SizedBox(height: Dimensions.space15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.space5),
              child: OTPFieldWidget(
                onChanged: (value) {
                  controller.enterExamKey = value;
                },
                fromExam: true,
                inActiveColor: MyColor.colorWhite,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: Dimensions.space20, horizontal: Dimensions.space10),
              width: double.infinity,
              decoration: BoxDecoration(color: MyColor.cardColor, border: Border.all(color: MyColor.cardBorderColor), borderRadius: BorderRadius.circular(Dimensions.space8)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    MyStrings.examRules,
                    textAlign: TextAlign.center,
                    style: semiBoldMediumLarge,
                  ),
                  ListView.builder(
                      itemCount: viewAll == true ? 3 : 2,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('\u2022',
                                style: regularOverLarge.copyWith(
                                  fontSize: 40,
                                  color: MyColor.primaryColor,
                                )),
                            const SizedBox(
                              width: Dimensions.space10,
                            ),
                            Expanded(
                              child: Text(
                                MyStrings().rules[index],
                                style: regularLarge.copyWith(overflow: TextOverflow.visible, color: MyColor.textColor),
                              ),
                            ),
                          ],
                        );
                      }),
                  InkWell(
                      onTap: () {
                        print(viewAll);
                        viewAll = !viewAll;
                      },
                      child: Text(
                        MyStrings.viewAllRules,
                        style: regularLarge.copyWith(color: MyColor.textColor),
                      )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: Dimensions.space10),
              child: Row(
                children: [
                  SizedBox(
                    width: Dimensions.space25,
                    height: Dimensions.space25,
                    child: Checkbox(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.space5)),
                        activeColor: MyColor.primaryColor,
                        checkColor: MyColor.colorWhite,
                        value: agree,
                        side: MaterialStateBorderSide.resolveWith(
                          (states) => BorderSide(width: Dimensions.space1, color: agree ? MyColor.getTextFieldEnableBorder() : MyColor.getTextFieldDisableBorder()),
                        ),
                        onChanged: (value) {
                          setState(() {
                            agree = !agree;
                          });
                        }),
                  ),
                  const SizedBox(width: Dimensions.space8),
                  DefaultText(
                    text: MyStrings.iAgreewithrules,
                    textColor: MyColor.getAuthTextColor(),
                  )
                ],
              ),
            ),
            const SizedBox(height: Dimensions.space30),
            RoundedButton(
              text: MyStrings.submit,
              press: () {
                // Get.toNamed(RouteHelper.createRoomScreen);
                controller.enterExamZone(widget.quizInfo_id, controller.enterExamKey);
              },
              textSize: Dimensions.space20,
              cornerRadius: Dimensions.space10,
            ),
            const SizedBox(
              height: Dimensions.space20,
            ),
            const SizedBox(
              height: Dimensions.space50,
            ),
          ],
        ),
      ),
    );
  }
}
