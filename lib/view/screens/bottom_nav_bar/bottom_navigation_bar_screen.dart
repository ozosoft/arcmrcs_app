import 'package:flutter/material.dart';
import 'package:flutter_prime/core/utils/dimensions.dart';
import 'package:flutter_prime/core/utils/my_color.dart';
import 'package:flutter_prime/core/utils/my_images.dart';
import 'package:flutter_prime/view/screens/coin_store/coin_store_screen.dart';
import 'package:flutter_prime/view/screens/home_page/home_screen.dart';
import 'package:flutter_prime/view/screens/leader_board/leader_board_screen.dart';
import 'package:flutter_prime/view/screens/profile/profile_screen.dart';
import 'package:flutter_prime/view/screens/settings/settings_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import '../../components/mobile_ads/banner_ads_widget.dart';


class BottomNavigationBarScreen extends StatefulWidget {
  const BottomNavigationBarScreen({super.key});

  @override
  _BottomNavigationBarScreenState createState() => _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {
  int _selectedIndex = 2;

  int _page = 2;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  static const List<Widget> _widgetOptions = <Widget>[CoinStoreScreen(), SettingsScreen(), HomeScreen(), LeaderBoardScreen(), ProfileScreen()];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: _widgetOptions.elementAt(_page),
          ),
          const Positioned.fill(
            bottom: 0,
            child: Align(alignment: Alignment.bottomCenter, child: BannerAdsWidget()),
          )
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 2,
        height: Dimensions.space60,
        items: <Widget>[
          Padding(
            padding: const EdgeInsets.all(Dimensions.space2),
            child: SvgPicture.asset(MyImages.coinStoreDrawer, height: Dimensions.space35, width: Dimensions.space50, color: _page == 0 ? MyColor.colorWhite : MyColor.bottomNavBarIconInActiveColor),
          ),
          Padding(
            padding: const EdgeInsets.all(Dimensions.space8),
            child: SvgPicture.asset(MyImages.settingsFilledSVG, height: Dimensions.space25, width: Dimensions.space50, color: _page == 1 ? MyColor.colorWhite : MyColor.bottomNavBarIconInActiveColor),
          ),
          Padding(
            padding: const EdgeInsets.all(Dimensions.space8),
            child: SvgPicture.asset(
              MyImages.homeFilledSVG,
              height: Dimensions.space25,
              width: Dimensions.space50,
              color: _page == 2 ? null : MyColor.bottomNavBarIconInActiveColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(Dimensions.space8),
            child: SvgPicture.asset(MyImages.prizeFilledSVG, height: Dimensions.space25, width: Dimensions.space50, color: _page == 3 ? MyColor.colorWhite : MyColor.bottomNavBarIconInActiveColor),
          ),
          Padding(
            padding: const EdgeInsets.all(Dimensions.space8),
            child: SvgPicture.asset(MyImages.profileFilledSVG, height: Dimensions.space25, width: Dimensions.space40, color: _page == 4 ? MyColor.colorWhite : MyColor.bottomNavBarIconInActiveColor),
          ),
        ],
        color: Colors.white,
        buttonBackgroundColor: MyColor.primaryColor,
        backgroundColor: MyColor.transparentColor,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 400),
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
            _page = index;
          });
        },
        letIndexChange: (index) => true,
      ),
    );
  }
}
