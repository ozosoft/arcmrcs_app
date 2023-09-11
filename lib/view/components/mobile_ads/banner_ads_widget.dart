import 'package:flutter/material.dart';
import 'package:flutter_prime/core/helper/ads/ads_unit_id_helper.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerAdsWidget extends StatefulWidget {
  const BannerAdsWidget({super.key});

  @override
  State<BannerAdsWidget> createState() => _BannerAdsWidgetState();
}

class _BannerAdsWidgetState extends State<BannerAdsWidget> {
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
          print('$BannerAd loaded.');
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('$BannerAd failedToLoad: $error');
        },
        onAdOpened: (Ad ad) => print('$BannerAd onAdOpened.'),
        onAdClosed: (Ad ad) => print('$BannerAd onAdClosed.'),
        onAdWillDismissScreen: (Ad ad) => print('$BannerAd onAdWillDismissScreen.'),
      ),
    );
    _bannerAd!.load();
  }

  @override
  Widget build(BuildContext context) {
    final AdWidget adWidget = AdWidget(ad: _bannerAd!);
    return Container(
      alignment: Alignment.center,
      child: adWidget,
      width: _bannerAd!.size.width.toDouble(),
      height: _bannerAd!.size.height.toDouble(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _bannerAd!.dispose();
    _bannerAd = null;
  }
}
