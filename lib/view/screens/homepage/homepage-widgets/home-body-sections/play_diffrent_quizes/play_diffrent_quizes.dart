import 'package:flutter/material.dart';
import 'package:flutter_prime/core/route/route.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/core/utils/style.dart';
import 'package:flutter_prime/core/utils/url_container.dart';
import 'package:flutter_prime/data/controller/dashboard/dashboard_controller.dart';
import 'package:flutter_prime/data/repo/dashboard/dashboard_repo.dart';
import 'package:flutter_prime/data/services/api_service.dart';
import 'package:get/get.dart';

class PlayDiffrentQuizes extends StatefulWidget {
  const PlayDiffrentQuizes({super.key});

  @override
  State<PlayDiffrentQuizes> createState() => _PlayDiffrentQuizesState();
}

class _PlayDiffrentQuizesState extends State<PlayDiffrentQuizes> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(DashBoardRepo(apiClient: Get.find()));
    Get.put(DashBoardController(dashRepo: Get.find()));
    DashBoardController controller = Get.put(DashBoardController(dashRepo: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getdata();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashBoardController>(
      builder: (controller) => Padding(
        padding: const EdgeInsets.all(Dimensions.space10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: Dimensions.space10),
            const Text(
              MyStrings.playDiffrentQuizs,
              style: boldMediumLarge,
            ),
            const SizedBox(height: Dimensions.space10),
            // GridView.builder(

            //       gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
            //         crossAxisCount: 2,
            //         childAspectRatio: 1.2
            //       ),
            //       itemCount: controller.quizlist.length,
            //       itemBuilder: (context, index) {
            //         return    Container(
            //           padding:const EdgeInsets.symmetric(horizontal: Dimensions.space10),
            //        decoration: BoxDecoration(
            //                   color: MyColor.colorWhite,
            //                   borderRadius:
            //                       BorderRadius.circular(Dimensions.defaultRadius),
            //                   boxShadow: const [
            //                     BoxShadow(
            //                       color: Color.fromARGB(61, 158, 158, 158),
            //                       blurRadius: 7,
            //                       spreadRadius: .5,
            //                       offset: Offset(
            //                         .4,
            //                         .4,
            //                       ),
            //                     )
            //                   ],
            //                 ),
            //         margin:const EdgeInsets.all(Dimensions.space5),
            //         child: Column(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //           // SvgPicture.asset(MyImages().playDiffrentGamesImages[index]),
            //           Image.network(UrlContainer.playdiffrentImage+controller.quizlist[index].image.toString()),
            //           const SizedBox(height: Dimensions.space10,),
            //            Text(controller.quizlist[index].name.toString(),style: semiBoldExtraLarge,),
            //             const SizedBox(height: Dimensions.space3),
            //            Text(controller.quizlist[index].shortDescription.toString(),style: regularDefault.copyWith(color: MyColor.textColor,),textAlign: TextAlign.center),
            //         ],),
            //       );

            //       },
            //       shrinkWrap: true,
            //       physics: NeverScrollableScrollPhysics(),
            //     ),

            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(RouteHelper.funNlearnScreenScreen);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: Dimensions.space15, vertical: Dimensions.space30),
                      decoration: BoxDecoration(
                        color: MyColor.colorWhite,
                        borderRadius: BorderRadius.circular(Dimensions.defaultRadius),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(61, 158, 158, 158),
                            blurRadius: 7,
                            spreadRadius: .5,
                            offset: Offset(
                              .4,
                              .4,
                            ),
                          )
                        ],
                      ),
                      margin: const EdgeInsets.all(Dimensions.space5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // SvgPicture.asset(MyImages().playDiffrentGamesImages[index]),

                          Image.network(UrlContainer.playdiffrentImage + controller.quizlist[0].image.toString()),

                          const SizedBox(
                            height: Dimensions.space10,
                          ),

                          Text(
                            controller.quizlist[0].name.toString(),
                            style: semiBoldExtraLarge,
                          ),

                          const SizedBox(height: Dimensions.space3),

                          Text(controller.quizlist[0].shortDescription.toString(),
                              style: regularDefault.copyWith(
                                color: MyColor.textColor,
                              ),
                              textAlign: TextAlign.center),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: Dimensions.space15, vertical: Dimensions.space30),
                    decoration: BoxDecoration(
                      color: MyColor.colorWhite,
                      borderRadius: BorderRadius.circular(Dimensions.defaultRadius),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(61, 158, 158, 158),
                          blurRadius: 7,
                          spreadRadius: .5,
                          offset: Offset(
                            .4,
                            .4,
                          ),
                        )
                      ],
                    ),
                    margin: const EdgeInsets.all(Dimensions.space5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // SvgPicture.asset(MyImages().playDiffrentGamesImages[index]),
                        Image.network(UrlContainer.playdiffrentImage + controller.quizlist[1].image.toString()),
                        const SizedBox(
                          height: Dimensions.space10,
                        ),
                        Text(
                          controller.quizlist[1].name.toString(),
                          style: semiBoldExtraLarge,
                        ),
                        const SizedBox(height: Dimensions.space3),
                        Text(controller.quizlist[1].shortDescription.toString(),
                            style: regularDefault.copyWith(
                              color: MyColor.textColor,
                            ),
                            textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
