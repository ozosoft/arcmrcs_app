// import 'package:flutter/material.dart';
// import 'package:quiz_lab/core/route/route.dart';
// import 'package:quiz_lab/view/components/bottom-sheet/custom_bottom_sheet.dart';
// import 'package:quiz_lab/view/screens/exam_zone/widgets/enter_exam_room_bottom_sheet.dart';
// import 'package:get/get.dart';

// class CardController extends GetxController {
//   bool isExpanded = false;
//   bool isLoading = true;

//   expand(bool fromExam) async {
//     isExpanded = fromExam ? isExpanded : !isExpanded;

//     update();
//   }

//   taped(
//       bool fromExam, String title, subcategoryIds, BuildContext context) async {
//     fromExam
//         ? CustomBottomSheet(child: EnterRoomBottomSheetWidget())
//             .customBottomSheet(context)
//         :subcategoryIds ==""?SizedBox(): Get.toNamed(RouteHelper.subCategories,
//             arguments: [title, subcategoryIds]);
   
//     update();
//   }
// }