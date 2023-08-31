// import 'package:flutter/material.dart';
// import 'package:flutter_prime/core/utils/dimensions.dart';
// import 'package:flutter_prime/core/utils/my_color.dart';
// import 'package:flutter_prime/core/utils/my_images.dart';
// import 'package:flutter_prime/core/utils/my_strings.dart';
// import 'package:flutter_prime/core/utils/style.dart';
// import 'package:flutter_prime/data/controller/play_diffrent_quizes/fun_n_learn/fun_n_learn_sub_categories_controller.dart';
// import 'package:flutter_prime/view/components/animated_widget/expanded_widget.dart';
// import 'package:flutter_prime/view/components/custom_loader/custom_loader.dart';
// import 'package:flutter_prime/view/components/divider/custom_horizontal_divider.dart';
// import 'package:flutter_prime/view/components/text/custom_text_with_underline.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';

// class FunNLearnExpandedSections extends StatefulWidget {
//   final int categoryindex;
//   final bool isExpand;
//   final String title;
//   const FunNLearnExpandedSections({super.key, required this.categoryindex, required this.isExpand, required this.title});

//   @override
//   State<FunNLearnExpandedSections> createState() => _FunNLearnExpandedSectionsState();
// }

// class _FunNLearnExpandedSectionsState extends State<FunNLearnExpandedSections> {
//   @override
//   Widget build(BuildContext context) {
//     print("fun and Learn expanded");
//     return GetBuilder<FunNLearnSubCategoriesController>(
//       builder: (controller) => controller.loader
//           ? CustomLoader()
//           : ExpandedSection(
//               duration: 300,
//               expand: widget.isExpand,
//               child: Column(
//                 children: [
//                   const CustomHorizontalDivider(),
//                   Container(
//                     color: MyColor.colorWhite,
//                     padding: const EdgeInsets.all(Dimensions.space10),
//                     child: GridView.builder(
//                         shrinkWrap: true,
//                         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(childAspectRatio: 2.3, crossAxisCount: 3),
//                         itemCount: controller.subCategoriesList[widget.categoryindex].quizInfosCount.length,
//                         itemBuilder: (BuildContext context, int index) {
//                           // if (!controller.viewMore && index >= 2) {
//                           //   return SizedBox.shrink();
//                           //    }
//                           return Padding(
//                               padding: const EdgeInsets.symmetric(vertical: Dimensions.space5, horizontal: Dimensions.space5),
//                               child: InkWell(
//                                 onTap: () {
//                                   // Get.toNamed(RouteHelper.funNlearndescriptionScreenScreen, arguments: [widget.title, controller.subCategoriesList[widget.categoryindex].quizInfos![index].id]);
//                                   print("hiiii");
//                                 },
//                                 child: Container(
//                                   padding: const EdgeInsets.symmetric(horizontal: Dimensions.space8, vertical: Dimensions.space8),
//                                   decoration: BoxDecoration(
//                                       color: controller.subCategoriesList[widget.categoryindex].quizInfosCount![index].playInfo != null ? MyColor.completedlevel : MyColor.lockedLevel, borderRadius: BorderRadius.circular(Dimensions.space7), border: Border.all(color: controller.subCategoriesList[widget.categoryindex].quizInfos![index].playInfo != null ? MyColor.completedlevel : MyColor.lockedLevel)),
//                                   child: Row(
//                                     children: [
//                                       SvgPicture.asset(controller.subCategoriesList[widget.categoryindex].quizInfosCount![index].playInfo != null ? MyImages.levelGreenTikSVG : MyImages.lockLevelSVG),
//                                       const SizedBox(width: Dimensions.space4),
//                                       Text(
//                                         controller.subCategoriesList[widget.categoryindex].quizInfos![index].level!.title.toString(),
//                                         style: regularLarge,
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ));
//                         }),
//                   ),
//                   InkWell(
//                     onTap: () {
//                       controller.viewMore = !controller.viewMore;
//                       print(controller.viewMore);
//                     },
//                     child: const Padding(
//                       padding: EdgeInsets.only(bottom: Dimensions.space20),
//                       child: CustomTextWithUndeline(
//                         text: MyStrings.viewMore,
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//     );
//   }
// }
