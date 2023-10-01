import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';
import 'package:quiz_lab/core/utils/my_color.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/core/utils/style.dart';
import 'package:quiz_lab/data/controller/exam_zone/exam_zone_controller.dart';
import 'package:quiz_lab/data/repo/exam_zone/exam_zone_repo.dart';
import 'package:quiz_lab/data/services/api_client.dart';
import 'package:quiz_lab/view/components/bottom-sheet/bottom_sheet_bar.dart';
import 'package:quiz_lab/view/components/buttons/rounded_button.dart';
import 'package:quiz_lab/view/components/otp_field_widget/otp_field_widget.dart';
import 'package:quiz_lab/view/components/snack_bar/show_custom_snackbar.dart';
import 'package:quiz_lab/view/components/text/default_text.dart';
import 'package:get/get.dart';

import '../../../../data/model/dashboard/dashboard_model.dart';
import '../../../../data/model/exam_zone/exam_zone_model.dart';
import '../../../components/buttons/rounded_loading_button.dart';
import '../../../components/custom_loader/custom_loader.dart';

class EnterRoomBottomSheetWidget extends StatefulWidget {
  final Exam? quizInfo;
  final Exams? quizInfoDashBoard;
  const EnterRoomBottomSheetWidget({super.key, this.quizInfo, this.quizInfoDashBoard});

  @override
  State<EnterRoomBottomSheetWidget> createState() => _EnterRoomBottomSheetWidgetState();
}

class _EnterRoomBottomSheetWidgetState extends State<EnterRoomBottomSheetWidget> {
  bool viewAll = false;

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
        padding: const EdgeInsetsDirectional.only(top: Dimensions.space10, start: Dimensions.space10, end: Dimensions.space10),
        child: Column(
          children: [
            const BottomSheetBar(),
            const SizedBox(height: Dimensions.space20),
            Text(
              "${widget.quizInfo != null ? widget.quizInfo!.title : widget.quizInfoDashBoard != null ? widget.quizInfoDashBoard!.title : MyStrings.enterExam.tr}",
              style: semiBoldExtraLarge,
            ),
            const SizedBox(height: Dimensions.space15),
            Text(MyStrings.examKey.tr,
                style: regularLarge.copyWith(
                  color: MyColor.textColor,
                )),
            Padding(
              // padding: const EdgeInsetsDirectional.only(right: Dimensions.space10,),
              padding: const EdgeInsets.symmetric(
                vertical: Dimensions.space10,
              ),
              child: OTPFieldWidget(
                onChanged: (value) {
                  controller.enterExamKey = value;
                },
                length: 6,
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
                  Text(
                    MyStrings.examRules.tr,
                    textAlign: TextAlign.center,
                    style: semiBoldMediumLarge,
                  ),
                  const SizedBox(
                    height: Dimensions.space10,
                  ),
                  if (widget.quizInfo != null || widget.quizInfoDashBoard != null)
                    SizedBox(
                      height: Dimensions.space90 * 2.5,
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          width: double.infinity,
                          color: Colors.transparent,
                          child: HtmlWidget(
                            """${widget.quizInfo != null ? widget.quizInfo!.examRule : widget.quizInfoDashBoard != null ? widget.quizInfoDashBoard!.examRule : ""}""",
                            textStyle: regularDefault.copyWith(color: Colors.black),
                            onLoadingBuilder: (context, element, loadingProgress) => const Center(
                              child: CustomLoader(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  // ListView.builder(
                  //     physics: const BouncingScrollPhysics(),
                  //     itemCount: viewAll == true ? 3 : 2,
                  //     shrinkWrap: true,
                  //     itemBuilder: (BuildContext context, int index) {
                  //       return Container(
                  //         margin: const EdgeInsets.all(Dimensions.space5),
                  //         color: Colors.transparent,
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.start,
                  //           crossAxisAlignment: CrossAxisAlignment.center,
                  //           children: [
                  //             Text('\u2022', style: regularLarge.copyWith(overflow: TextOverflow.visible, color: MyColor.redCancelTextColor, fontSize: 20)),
                  //             const SizedBox(
                  //               width: Dimensions.space10,
                  //             ),
                  //             Expanded(
                  //               child: Text(
                  //                 MyStrings().rules[index],
                  //                 style: regularLarge.copyWith(overflow: TextOverflow.visible, color: MyColor.textColor),
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       );
                  //     }),
                  const SizedBox(
                    height: Dimensions.space10,
                  ),
                  // InkWell(
                  //   onTap: () {
                  //     debugPrint(viewAll.toString());
                  //     viewAll = !viewAll;
                  //     controller.update();
                  //   },
                  //   child: Text(
                  //     viewAll == false ? "${MyStrings.viewAllRules.tr} ↑ " : "${MyStrings.viewLessRules.tr} ↓ ",
                  //     style: regularLarge.copyWith(color: MyColor.textColor, fontWeight: FontWeight.bold),
                  //   ),
                  // ),
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
                        value: controller.agreeExamRules,
                        side: MaterialStateBorderSide.resolveWith(
                          (states) => BorderSide(width: Dimensions.space1, color: controller.agreeExamRules ? MyColor.getTextFieldEnableBorder() : MyColor.getTextFieldDisableBorder()),
                        ),
                        onChanged: (value) {
                          controller.changeExamRules(value!);
                        }),
                  ),
                  const SizedBox(width: Dimensions.space8),
                  DefaultText(
                    text: MyStrings.iAgreewithrules.tr,
                    textColor: MyColor.getAuthTextColor(),
                  )
                ],
              ),
            ),
            const SizedBox(height: Dimensions.space30),
            controller.submitLoading == true
                ? const RoundedLoadingBtn()
                : RoundedButton(
                    text: MyStrings.submit.tr,
                    press: () {
                      if (controller.enterExamKey == "") {
                        CustomSnackBar.error(errorList: [(MyStrings.examKeyMsg.tr)]);
                      } else {
                        if (controller.agreeExamRules == true) {
                          if (widget.quizInfo != null) {
                            controller.enterExamZone(widget.quizInfo!.id.toString(), controller.enterExamKey);
                          }
                          if (widget.quizInfoDashBoard != null) {
                            controller.enterExamZone(widget.quizInfoDashBoard!.id.toString(), controller.enterExamKey);
                          }
                        } else {
                          CustomSnackBar.error(errorList: [(MyStrings.agreeExamRules.tr)]);
                        }
                      }
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
