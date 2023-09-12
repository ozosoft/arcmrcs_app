import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_images.dart';
import 'package:flutter_prime/core/utils/style.dart';
import 'package:flutter_prime/view/components/animated_widget/expanded_widget.dart';
import 'package:flutter_svg/svg.dart';

class NotificationCard extends StatefulWidget {
  final String title, image, shortDesc, details, date;
  final bool expansionVisible, fromViewAll, fromBookmark;

  const NotificationCard(
      {super.key,
      required this.title,
      required this.image,
      this.expansionVisible = false,
      this.fromBookmark = false,
      required this.fromViewAll,
      this.shortDesc = "1",
      this.details = "",
      this.date = ""});

  @override
  State<NotificationCard> createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.space12, vertical: Dimensions.space10),
      child: InkWell(
        onTap: () {
          setState(() {
            isExpanded = !isExpanded;
          });
        },
        child: Container(
            decoration: BoxDecoration(
              color: MyColor.colorWhite,
              borderRadius: BorderRadius.circular(Dimensions.space5),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(61, 158, 158, 158),
                  blurRadius: 5,
                  spreadRadius: .5,
                  offset: Offset(
                    .4,
                    .4,
                  ),
                )
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: Dimensions.space3),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(width: Dimensions.space20),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                          top: Dimensions.space20, bottom: Dimensions.space20),
                      child: SvgPicture.asset(
                        widget.image,
                        height: Dimensions.space40,
                      ),
                    ),
                    const SizedBox(
                      width: Dimensions.space20,
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(top: Dimensions.space15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.title,
                            style: semiBoldMediumLarge,
                          ),
                          const SizedBox(height: Dimensions.space5),
                          isExpanded
                              ? SizedBox(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(widget.details,
                                      softWrap: true,
                                          style: regularDefault.copyWith(color: MyColor.textColor)),
                                      const SizedBox(
                                          height: Dimensions.space3),
                                      Text(widget.date,
                                      softWrap: true,
                                          style: regularDefault.copyWith(color: MyColor.textColor)),
                                    ],
                                  ),
                                )
                              : Text(widget.shortDesc,
                                  softWrap: true,
                                  style: regularDefault.copyWith(color: MyColor.textColor)),
                          const SizedBox(width: Dimensions.space10),
                        ],
                      ),
                    ),
                    const Spacer(),
                    isExpanded
                        ? const SizedBox()
                        : Padding(
                            padding:
                                const EdgeInsetsDirectional.only(top: Dimensions.space20),
                            child: SvgPicture.asset(
                              isExpanded
                                  ? MyImages.arrowDownSVG
                                  : MyImages.playSVG,
                              height: Dimensions.space35,
                            ),
                          ),
                    const SizedBox(width: Dimensions.space10),
                  ],
                ),
                const SizedBox(height: Dimensions.space3),
                widget.expansionVisible
                    ? ExpandedSection(
                        duration: 300,
                        expand: isExpanded,
                        child: const Column(
                          children: [],
                        ),
                      )
                    : const SizedBox(),
              ],
            )),
      ),
    );
  }
}
