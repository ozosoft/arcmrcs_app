import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_images.dart';
import 'package:flutter_prime/core/utils/my_strings.dart';
import 'package:flutter_prime/view/components/app-bar/custom_category_appBar.dart';
import 'package:flutter_prime/view/components/category-card/categories_card.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({super.key});

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomCategoryAppBar(
        title: MyStrings.bookmarks,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.only(top: Dimensions.space25),
                shrinkWrap: true,
                itemCount: MyStrings().allCategoryies.length,
                itemBuilder: (BuildContext context, int index) {
                  return CategoriesCard(
                    index: index,
                    title: MyStrings().allCategoryies[index]["title"].toString(),
                    questions: MyStrings().allCategoryies[index]["questions"].toString(),
                    image: MyImages().categoryImages[index],
                    expansionVisible: true,
                    fromViewAll: false,
                    levels: MyStrings().allCategoryies[index]["level"].toString(),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
