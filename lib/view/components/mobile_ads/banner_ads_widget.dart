import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_lab/core/helper/ads/ads_unit_id_helper.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:quiz_lab/data/services/api_client.dart';
import 'package:unity_ads_plugin/unity_ads_plugin.dart';
// Import the async package for using timers

import '../../../core/helper/ads/good_banner.dart';
import '../../../environment.dart';

class BannerAdsWidget extends StatefulWidget {
  const BannerAdsWidget({super.key});

  @override
  State<BannerAdsWidget> createState() => _BannerAdsWidgetState();
}

class _BannerAdsWidgetState extends State<BannerAdsWidget> {
  bool isAdLoaded = true;
  bool hasUnityBannerAds = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Environment.showBannerAds
        ? IntrinsicHeight(
            child: Get.find<ApiClient>().isAdmobAddEnable()
                ? GoodBanner(
                    adUnitId: AdUnitHelper.bannerAdUnitId!,
                    adRequest: const AdRequest(),
                    interval: Environment.hideHomeBannerAdsAfteraMiniutes * 60 * 1000, // min to milisec
                    adSize: AdSize.banner,
                  )
                : hasUnityBannerAds? UnityBannerAd(
                    placementId: 'Banner_Android',
                    onLoad: (placementId) => print('Banner loaded: $placementId'),
                    onClick: (placementId) => print('Banner clicked: $placementId'),
                    onShown: (placementId) => print('Banner shown: $placementId'),
                    onFailed: (placementId, error, message) {
                      print('Banner Ad $placementId failed: $error $message');
                      hasUnityBannerAds = false;
                      print(hasUnityBannerAds);
                    }):const SizedBox(),
          )
        : const SizedBox.shrink();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
