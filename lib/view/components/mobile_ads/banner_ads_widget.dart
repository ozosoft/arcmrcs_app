import 'package:flutter/material.dart';
import 'package:quiz_lab/core/helper/ads/ads_unit_id_helper.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:async'; // Import the async package for using timers

import '../../../environment.dart';

class BannerAdsWidget extends StatefulWidget {
  const BannerAdsWidget({super.key});

  @override
  State<BannerAdsWidget> createState() => _BannerAdsWidgetState();
}

class _BannerAdsWidgetState extends State<BannerAdsWidget> {
  BannerAd? _bannerAd;
  bool _showBannerAds = true; // Track whether to show or hide banner ads
  late Timer _timer; // Timer to hide banner ads after 5 minutes

  @override
  void initState() {
    super.initState();

    if (AdUnitHelper.bannerAdUnitId != null) {
      _bannerAd = BannerAd(
        adUnitId: AdUnitHelper.bannerAdUnitId!,
        request: const AdRequest(),
        size: AdSize.banner,
        listener: BannerAdListener(
          onAdLoaded: (Ad ad) {
            debugPrint('$BannerAd loaded.');
          },
          onAdFailedToLoad: (Ad ad, LoadAdError error) {
            debugPrint('$BannerAd failedToLoad: $error');
          },
          onAdOpened: (Ad ad) => debugPrint('$BannerAd onAdOpened.'),
          onAdClosed: (Ad ad) => debugPrint('$BannerAd onAdClosed.'),
          onAdWillDismissScreen: (Ad ad) => debugPrint('$BannerAd onAdWillDismissScreen.'),
        ),
      );

      // Load the banner ad initially if necessary
      if (Environment.showBannerAds && AdUnitHelper.bannerAdUnitShow! == '1') {
        _bannerAd!.load();
      }

      // Set up a timer to hide banner ads after {given} minutes
      _timer = Timer(const Duration(minutes: Environment.hideHomeBannerAdsAfteraMiniutes), () {
        if (Environment.hideAfterShowBannerAds) {
          setState(() {
            _showBannerAds = false;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final AdWidget adWidget = AdWidget(ad: _bannerAd!);
    return Environment.showBannerAds && _showBannerAds // Check if banner ads should be shown
        ? Container(
            alignment: Alignment.center,
            width: _bannerAd!.size.width.toDouble(),
            height: _bannerAd!.size.height.toDouble(),
            child: adWidget,
          )
        : const SizedBox();
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel(); // Cancel the timer when disposing of the widget
    _bannerAd!.dispose();
    _bannerAd = null;
  }
}
