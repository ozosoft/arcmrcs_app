import 'package:flutter/material.dart';
import 'package:flutter_prime/core/helper/ads/ads_unit_id_helper.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../environment.dart';

class QuizBannerAdsWidget extends StatefulWidget {
  const QuizBannerAdsWidget({super.key});

  @override
  State<QuizBannerAdsWidget> createState() => _QuizBannerAdsWidgetState();
}

class _QuizBannerAdsWidgetState extends State<QuizBannerAdsWidget> {
  BannerAd? _bannerAd;

  @override
  void initState() {
    super.initState();
    _bannerAd = BannerAd(
      adUnitId: AdUnitHelper.bannerAdUnitId,
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
    if (Environment.showBannerAds) {
      _bannerAd!.load();
    } else {
      _bannerAd!.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    final AdWidget adWidget = AdWidget(ad: _bannerAd!);
    return Environment.showBannerAds
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
    _bannerAd!.dispose();
    _bannerAd = null;
  }
}
