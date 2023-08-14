import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/view/components/app-bar/custom_category_appBar.dart';
import 'package:flutter_prime/view/screens/1vs1/play-with-friends-bottom-sheet/rooms/join-room/components/join_room_body_section.dart';

class JoinRoomScreen extends StatelessWidget {
  const JoinRoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomCategoryAppBar(title: MyStrings.joinRoom),
      body: Column(children: [
        JoinRoomBodySection()
      ],),
    );
  }
}