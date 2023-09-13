import 'package:flutter/material.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';
import 'package:quiz_lab/core/utils/my_images.dart';
import 'package:quiz_lab/view/screens/notification/widget/notification_card.dart';

class NotificationCardScreen extends StatefulWidget {
  const NotificationCardScreen({super.key});

  @override
  State<NotificationCardScreen> createState() => _NotificationCardScreenState();
}

class _NotificationCardScreenState extends State<NotificationCardScreen> {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> notifications = [
      {'title': "rewardNotification", 'short_Notification': "shortDesc1", 'detail_Notification': "detailnotifucation1", 'date': "detailnotifucationdate1"},
      {'title': "joinwithnewroom", 'short_Notification': "shortDesc2", 'detail_Notification': "detailnotifucation1", 'date': "detailnotifucationdate2"},
      {'title': "eventNotification", 'short_Notification': "shortDesc3", 'detail_Notification': "detailnotifucation1", 'date': "detailnotifucationdate3"},
    ];

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsetsDirectional.only(top: Dimensions.space25),
              shrinkWrap: true,
              itemCount: notifications.length,
              itemBuilder: (BuildContext context, int index) {
                return NotificationCard(
                  title: notifications[index]["title"].toString(),
                  image: MyImages().notificatioImages[index],
                  expansionVisible: true,
                  fromViewAll: false,
                  shortDesc: notifications[index]["short_Notification"].toString(),
                  fromBookmark: true,
                  details: notifications[index]["detail_Notification"].toString(),
                  date: notifications[index]["date"].toString(),
                );
              }),
        ],
      ),
    );
  }
}
