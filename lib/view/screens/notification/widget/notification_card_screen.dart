import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_images.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/view/screens/notification/widget/notification_card.dart';

class NotificationCardScreen extends StatefulWidget {
  const NotificationCardScreen({super.key});

  @override
  State<NotificationCardScreen> createState() => _NotificationCardScreenState();
}

class _NotificationCardScreenState extends State<NotificationCardScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            ListView.builder(
              physics:const NeverScrollableScrollPhysics(),
              padding:const EdgeInsets.only(top: Dimensions.space25),
              shrinkWrap: true,
              itemCount: MyStrings().notifications.length,
              itemBuilder: (BuildContext context, int index) {
                return NotificationCard(
                  title: MyStrings().notifications[index]["title"].toString(),
                  image: MyImages().notificatioImages[index],
                  expansionVisible: true,
                  fromViewAll: false,
                  shortDesc: MyStrings().notifications[index]["short_Notification"].toString(),
                  fromBookmark: true,
                  details: MyStrings().notifications[index]["detail_Notification"].toString() ,
                  date: MyStrings().notifications[index]["date"].toString() ,
                );
              }),
       ],
      ),
    );
  }
}