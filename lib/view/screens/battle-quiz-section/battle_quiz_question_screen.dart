import 'package:flutter/material.dart';
import 'package:flutter_prime/view/screens/battle-quiz-section/quiz-screen-widgets/battle_quiz_questions_body_section.dart';
import 'package:get/get.dart';

import '../../../core/utils/dimensions.dart';
import '../../../data/controller/battle/battle_room_controller.dart';
import '../../../data/model/quiz/quiz_list_model.dart';
import '../../components/app-bar/custom_category_appBar.dart';

class BattleQuizQuestionsScreen extends StatefulWidget {
  const BattleQuizQuestionsScreen({super.key});

  @override
  State<BattleQuizQuestionsScreen> createState() =>
      _BattleQuizQuestionsScreenState();
}

class _BattleQuizQuestionsScreenState extends State<BattleQuizQuestionsScreen> {
  final title = Get.arguments[0] as String;
  final List<Question> qustionsList = Get.arguments[1] as List<Question>;
  @override
  Widget build(BuildContext context) {
    print(qustionsList.length);
    print(qustionsList.first.question);
    return Scaffold(
        appBar: CustomCategoryAppBar(title: title.toString()),
        body: GetBuilder<BattleRoomController>(builder: (controller) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.space15, vertical: Dimensions.space50),
            child: BattleQuizBodySection(
              qustionsList: qustionsList,
            ),
          );
        }));
  }
}
