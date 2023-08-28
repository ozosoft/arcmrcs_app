import 'package:flutter/material.dart';
import 'package:flutter_prime/view/components/app-bar/custom_category_appBar.dart';
import 'package:flutter_prime/view/screens/1vs1/play-with-friends-bottom-sheet/rooms/create-room/create-room-body-section/create_room_body_section.dart';
import '../../../../../../core/utils/my_strings.dart';

class CreateRoomScreen extends StatelessWidget {
  const CreateRoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: Color(0xFFF8F8F8),
        appBar: CustomCategoryAppBar(title: MyStrings.createRoom),
        body: CreateRoomBodySection());
  }
}
