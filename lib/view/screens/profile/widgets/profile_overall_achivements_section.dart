import 'package:flutter/material.dart';
import 'package:flutter_prime/core/route/route.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_images.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/core/utils/style.dart';
import 'package:flutter_prime/core/utils/url_container.dart';
import 'package:flutter_prime/data/controller/account/profile_controller.dart';
import 'package:flutter_prime/data/repo/account/profile_repo.dart';
import 'package:flutter_prime/data/services/api_service.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../components/image_widget/my_image_widget.dart';

class ProfileTopSection extends StatefulWidget {
  const ProfileTopSection({super.key});

  @override
  State<ProfileTopSection> createState() => _ProfileTopSectionState();
}

class _ProfileTopSectionState extends State<ProfileTopSection> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(ProfileRepo(apiClient: Get.find()));

    ProfileController controller = Get.put(ProfileController(profileRepo: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.loadProfileInfo();
    });
  }

  @override
  Widget build(BuildContext context) {

    return GetBuilder<ProfileController>(
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.only(top: Dimensions.space40, right: Dimensions.space18, left: Dimensions.space18),
          child: Container(
            padding: const EdgeInsets.all(Dimensions.space15),
            decoration: BoxDecoration(color: MyColor.colorWhite, borderRadius: BorderRadius.circular(Dimensions.space10)),
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        if (controller.apiClient.getUserImagePath() != "null")
                          Container(
                            margin: const EdgeInsets.only(top: Dimensions.space20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(Dimensions.space40),
                            ),
                            height: Dimensions.space80,
                            width: Dimensions.space80,
                            child: MyImageWidget(
                              radius: 40,
                              imageUrl: UrlContainer.dashboardUserProfileImage + controller.avatar,
                            ),
                          )
                        else
                          FittedBox(
                            fit: BoxFit.cover,
                            child: Container(
                              margin: const EdgeInsets.only(top: Dimensions.space20),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.space40), image: const DecorationImage(image: AssetImage(MyImages.defaultAvatar), fit: BoxFit.cover)),
                              height: Dimensions.space80,
                              width: Dimensions.space80,
                            ),
                          ),
                        Positioned.fill(
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: InkWell(
                              onTap: () {
                                Get.toNamed(RouteHelper.profileEditScreen);
                              },
                              child: Container(
                                decoration: BoxDecoration(color: MyColor.colorWhite, borderRadius: BorderRadius.circular(Dimensions.space50)),
                                child: Container(
                                    margin: EdgeInsets.all(Dimensions.space2),
                                    padding: const EdgeInsets.all(Dimensions.space4),
                                    decoration: BoxDecoration(color: MyColor.primaryColor, borderRadius: BorderRadius.circular(Dimensions.space50)),
                                    child: const Icon(
                                      Icons.edit,
                                      size: Dimensions.space15,
                                      color: MyColor.colorWhite,
                                    )),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: Dimensions.space15,
                    ),
                    Text(
                      controller.apiClient.getUserFullName(),
                      style: semiBoldExtraLarge.copyWith(fontSize: Dimensions.fontOverLarge),
                    ),
                    const SizedBox(
                      height: Dimensions.space40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: Container(
                          decoration: BoxDecoration(
                            color: MyColor.cardBgLighGreyColor,
                            border: Border.all(color: MyColor.primaryColor.withOpacity(0.05)),
                            borderRadius: BorderRadius.circular(Dimensions.space8),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: Dimensions.space10),
                                child: SvgPicture.asset(MyImages().achivementsType[0].toString()),
                              ),
                              Text(
                                MyStrings.rank,
                                style: semiBoldMediumLarge.copyWith(color: MyColor.primaryColor, fontWeight: FontWeight.w500),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: Dimensions.space5),
                                child: Text(
                                  controller.rank,
                                  style: regularMediumLarge,
                                ),
                              ),
                              const SizedBox(
                                height: Dimensions.space5,
                              ),
                            ],
                          ),
                        )),
                        const SizedBox(
                          width: Dimensions.space10,
                        ),
                        Expanded(
                            child: Container(
                          decoration: BoxDecoration(
                            color: MyColor.cardBgLighGreyColor,
                            border: Border.all(color: MyColor.primaryColor.withOpacity(0.05)),
                            borderRadius: BorderRadius.circular(Dimensions.space8),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: Dimensions.space10),
                                child: SvgPicture.asset(MyImages().achivementsType[1].toString()),
                              ),
                              Text(
                                MyStrings.coins,
                                style: semiBoldMediumLarge.copyWith(color: MyColor.primaryColor, fontWeight: FontWeight.w500),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: Dimensions.space5),
                                child: Text(
                                  controller.coins,
                                  style: regularMediumLarge,
                                ),
                              ),
                              const SizedBox(
                                height: Dimensions.space5,
                              ),
                            ],
                          ),
                        )),
                        const SizedBox(
                          width: Dimensions.space10,
                        ),
                        Expanded(
                            child: Container(
                          decoration: BoxDecoration(
                            color: MyColor.cardBgLighGreyColor,
                            border: Border.all(color: MyColor.primaryColor.withOpacity(0.05)),
                            borderRadius: BorderRadius.circular(Dimensions.space8),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: Dimensions.space10),
                                child: SvgPicture.asset(MyImages().achivementsType[2].toString()),
                              ),
                              Text(
                                MyStrings.score,
                                style: semiBoldMediumLarge.copyWith(color: MyColor.primaryColor, fontWeight: FontWeight.w500),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: Dimensions.space5),
                                child: Text(
                                  controller.score,
                                  style: regularMediumLarge,
                                ),
                              ),
                              const SizedBox(
                                height: Dimensions.space5,
                              ),
                            ],
                          ),
                        )),
                      ],
                    ),
                    const SizedBox(
                      height: Dimensions.space15,
                    ),
                    // const Align(
                    //     alignment: Alignment.centerLeft,
                    //     child: Text(
                    //       MyStrings.yourBadges,
                    //       style: semiBoldMediumLarge,
                    //     )),
                    // const SizedBox(
                    //   height: Dimensions.space5,
                    // ),
                    // GridView.builder(
                    //     physics: const NeverScrollableScrollPhysics(),
                    //     shrinkWrap: true,
                    //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: orientation == Orientation.portrait ? .98 : 2, crossAxisSpacing: Dimensions.space12),
                    //     itemCount: MyStrings().achivements.length,
                    //     itemBuilder: (BuildContext context, index) {
                    //       return Stack(
                    //         children: [
                    //           Container(
                    //             margin: const EdgeInsets.only(
                    //               top: Dimensions.space20,
                    //             ),
                    //             padding: EdgeInsets.only(top: orientation == Orientation.portrait ? size.height * .025 : size.height * .08),
                    //             width: double.infinity,
                    //             decoration: BoxDecoration(
                    //                 color: MyColor.lobbycardColor,
                    //                 border: Border.all(
                    //                   color: MyColor.cardBorderColors,
                    //                 ),
                    //                 borderRadius: BorderRadius.circular(Dimensions.space8)),
                    //             child: Column(
                    //               children: [
                    //                 Text(MyStrings().badgeList[index]['title']!, style: regularLarge.copyWith(color: MyColor.textColor)),
                    //                 Text(
                    //                   MyStrings().badgeList[index]['description']!,
                    //                   style: regularLarge.copyWith(color: MyColor.textColor),
                    //                 ),
                    //               ],
                    //             ),
                    //           ),
                    //           Padding(
                    //             padding: EdgeInsets.only(left: orientation == Orientation.portrait ? size.width * .09 : size.width * .125),
                    //             child: SvgPicture.asset(
                    //               alignment: Alignment.center,
                    //               MyImages().badges[index],
                    //               height: orientation == Orientation.portrait ? Dimensions.space33 : Dimensions.space43,
                    //             ),
                    //           ),
                    //         ],
                    //       );
                    //     }),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
