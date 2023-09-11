import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../environment.dart';
import 'ads_unit_id_helper.dart';

class AdmobHelper {
  InterstitialAd? _interstitialAd;
  InterstitialAd? _interstitialAdAlways;

  int _interstitialLoadAttempts = 0;

  // Banner Ads
  static BannerAd getBannerAd() {
    BannerAd bAd = BannerAd(
        size: AdSize.banner,
        adUnitId: AdUnitHelper.bannerAdUnitId,
        listener: BannerAdListener(onAdClosed: (Ad ad) {
          print("Ad Closed");
        }, onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
        }, onAdLoaded: (Ad ad) {
          print('Ad Loaded');
        }, onAdOpened: (Ad ad) {
          print('Ad opened');
        }),
        request: const AdRequest());
    return bAd;
  }

  // Native Banner Ads
  static NativeAd getNativeBannerAd() {
    NativeAd nativeBAd = NativeAd(
      adUnitId: AdUnitHelper.nativeBannerAdUnitId,
      request: const AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (Ad ad) {
          print('$NativeAd loaded.');
          // setState(() {
          //   _nativeAdIsLoaded = true;
          // });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('$NativeAd failedToLoad: $error');
          ad.dispose();
        },
        onAdOpened: (Ad ad) => print('$NativeAd onAdOpened.'),
        onAdClosed: (Ad ad) => print('$NativeAd onAdClosed.'),
      ),
      nativeTemplateStyle: NativeTemplateStyle(
        templateType: TemplateType.medium,
        mainBackgroundColor: Colors.white12,
        callToActionTextStyle: NativeTemplateTextStyle(
          size: 16.0,
        ),
        primaryTextStyle: NativeTemplateTextStyle(
          textColor: Colors.black38,
          backgroundColor: Colors.white70,
        ),
      ),
    );
    return nativeBAd;
  }

  // create interstitial ads
  void createInterad() {
    InterstitialAd.load(
        adUnitId: AdUnitHelper.interstitialAdUnitId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(onAdLoaded: (InterstitialAd ad) {
          _interstitialAd = ad;
          _interstitialLoadAttempts = 0;
        }, onAdFailedToLoad: (LoadAdError error) {
          _interstitialLoadAttempts += 1;
          _interstitialAd = null;
          if (_interstitialLoadAttempts <= Environment.interstitialAdsShowAfter) {
            createInterad();
          }
        }));
  }

  void showInterad() {
    if (_interstitialAd != null) {
      _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(onAdDismissedFullScreenContent: (InterstitialAd ad) {
        ad.dispose();
        createInterad();
      }, onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        ad.dispose();
        createInterad();
      });
      _interstitialAd?.show();
    }
  }

  // create interstitial ads always
  void loadInterstitialAdAlways() {
    InterstitialAd.load(
        adUnitId: AdUnitHelper.interstitialAdUnitId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          // Called when an ad is successfully received.
          onAdLoaded: (ad) {
            ad.fullScreenContentCallback = FullScreenContentCallback(
              // Called when the ad showed the full screen content.
              onAdShowedFullScreenContent: (ad) {},
              // Called when an impression occurs on the ad.
              onAdImpression: (ad) {},
              // Called when the ad failed to show full screen content.
              onAdFailedToShowFullScreenContent: (ad, err) {
                // Dispose the ad here to free resources.
                ad.dispose();
              },
              // Called when the ad dismissed full screen content.
              onAdDismissedFullScreenContent: (ad) {
                // Dispose the ad here to free resources.
                ad.dispose();
              },
              // Called when a click is recorded for an ad.
              onAdClicked: (ad) {},
            );

            debugPrint('$ad loaded.');
            // Keep a reference to the ad so you can show it later.
            _interstitialAdAlways = ad;
            
            ad.show();
            ad.dispose();
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (LoadAdError error) {
            debugPrint('InterstitialAd failed to load: $error');
          },
        ));
  }
}
