import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/view/screens/drawer/drawer_screen.dart';
import 'package:flutter_prime/view/screens/homepage/homepage-widgets/home-body-sections/exam_zone/exam_zone_screen.dart';
import 'package:flutter_prime/view/screens/homepage/homepage-widgets/home-body-sections/top-categories/top_category_section.dart';
import 'homepage-widgets/custom_sliver_appbar.dart';
import 'homepage-widgets/home-body-sections/battles_of_the_day_section.dart';
import 'homepage-widgets/home-body-sections/play_diffrent_quizes/play_diffrent_quizes.dart';
import 'homepage-widgets/home-body-sections/quiz_contest_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: CustomScrollView(
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
                    ExamZoneScreen(),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(child: PlayDiffrentQuizes()),
          ],
        ),
      ),
      drawer: DrawerScreen(),
    );
  }
}
