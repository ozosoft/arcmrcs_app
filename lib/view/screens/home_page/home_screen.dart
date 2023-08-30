import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/view/screens/drawer/drawer_screen.dart';
import 'package:flutter_prime/view/screens/home_page/homepage-widgets/home-body-sections/exam_zone_section/exam_zone_homepage_category_screen.dart';
import 'package:flutter_prime/view/screens/home_page/homepage-widgets/home-body-sections/home_top_category_section/top_category_section.dart';
import 'homepage-widgets/home_appbar_section.dart/custom_sliver_appbar.dart';
import 'homepage-widgets/home-body-sections/battle_of_the_day_section/battles_of_the_day_section.dart';
import 'homepage-widgets/home-body-sections/play_diffrent_quizes/play_diffrent_quizes.dart';
import 'homepage-widgets/home-body-sections/contest_section/quiz_contest_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: <Widget>[
            SliverPersistentHeader(
              pinned: true,
              floating: true,
              delegate: CustomSliverDelegate(
                expandedHeight: Dimensions.space130,
                scaffoldKey: _scaffoldKey,
              ),
            ),
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(Dimensions.space10),
                child: Column(
                  children: [
                    TopCategorySection(),
                    BattleOfTheDaySection(),
                    QuizContestSection(),
                    ExamZoneCategoryScreen(),
                    SizedBox(
                      height: Dimensions.space100,
                    )
                  ],
                ),
              ),
            ),

            // const SliverToBoxAdapter(child: PlayDiffrentQuizes()),
          ],
        ),
      ),
      drawer: const DrawerScreen(),
    );
  }
}
