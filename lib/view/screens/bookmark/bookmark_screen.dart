import 'package:flutter/material.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';
import 'package:quiz_lab/core/utils/my_images.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/view/components/app-bar/custom_category_appBar.dart';
import 'package:quiz_lab/view/components/category-card/categories_card.dart';
import 'package:get/get.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({super.key});

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  final List<Map<String, String>> allCategoryies = [
    {'title': "generalKnowledge", 'questions': "questions", 'level': "sixlevel"},
    {'title': "gameandSports", 'questions': "questions2", 'level': "sevenlevel"},
    {'title': "historyAndCulture", 'questions': "questions3", 'level': "tenlevel"},
    {'title': "music", 'questions': "questions4", 'level': "twelvelevel"},
    {'title': "scienceAndTech", 'questions': "questions5", 'level': "eightlevel"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomCategoryAppBar(
        title: MyStrings.bookmarks.tr,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsetsDirectional.only(top: Dimensions.space25),
                shrinkWrap: true,
                itemCount: allCategoryies.length,
                itemBuilder: (BuildContext context, int index) {
                  return CategoriesCard(
                    index: index,
                    title: allCategoryies[index]["title"].toString(),
                    questions: allCategoryies[index]["questions"].toString(),
                    image: MyImages().categoryImages[index],
                    expansionVisible: true,
                    fromViewAll: false,
                    levels: allCategoryies[index]["level"].toString(),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
