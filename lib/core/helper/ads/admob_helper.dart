import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../environment.dart';
import 'ads_unit_id_helper.dart';

class AdmobHelper {
  static final AdmobHelper _instance = AdmobHelper._internal();
  factory AdmobHelper() => _instance;

  AdmobHelper._internal();

  InterstitialAd? _interstitialAd;
  InterstitialAd get interstitialAd => _interstitialAd!;
  int _interstitialLoadAttempts = 0;

  // Banner Ads
  static BannerAd getBannerAd() {
    BannerAd bAd = BannerAd(
        size: AdSize.banner,
        adUnitId: AdUnitHelper.bannerAdUnitId,
        listener: BannerAdListener(onAdClosed: (Ad ad) {
          debugPrint("Ad Closed");
        }, onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
        }, onAdLoaded: (Ad ad) {
          debugPrint('Ad Loaded');
        }, onAdOpened: (Ad ad) {
          debugPrint('Ad opened');
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
          debugPrint('$NativeAd loaded.');
          // setState(() {
          //   _nativeAdIsLoaded = true;
          // });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          debugPrint('$NativeAd failedToLoad: $error');
          ad.dispose();
        },
        onAdOpened: (Ad ad) => debugPrint('$NativeAd onAdOpened.'),
        onAdClosed: (Ad ad) => debugPrint('$NativeAd onAdClosed.'),
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
  void createInterstitialAd() {
    if (Environment.showInterstitialAds == true) {
      InterstitialAd.load(
          adUnitId: AdUnitHelper.interstitialAdUnitId,
          request: const AdRequest(),
          adLoadCallback: InterstitialAdLoadCallback(onAdLoaded: (InterstitialAd ad) {
            debugPrint('$ad loaded Interstitial.');
            _interstitialAd = ad;
            // _interstitialLoadAttempts = 0;
          }, onAdFailedToLoad: (LoadAdError error) {
            _interstitialAd = null;
            debugPrint("from load344");
          }));
    }
  }

  void showInterstitialAd() {
    debugPrint(_interstitialLoadAttempts.toString());
    if (Environment.showInterstitialAds == true) {
      if (_interstitialAd != null) {
        _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(onAdDismissedFullScreenContent: (InterstitialAd ad) {
          debugPrint("from load");
          ad.dispose();
          createInterstitialAd();
        }, onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
          debugPrint("from failedload");
          ad.dispose();
          createInterstitialAd();
        });

        if (_interstitialLoadAttempts == Environment.interstitialAdsShowAfter) {
          _interstitialAd?.show();

          _interstitialLoadAttempts = 1;
          debugPrint("from load3");
        } else {
          _interstitialLoadAttempts += 1;
          debugPrint("from load5");
        }
      } else {
        createInterstitialAd();
      }
    }
  }
// Create interstitial ads (load it only once)
  // Create interstitial ads (load it only once)
  // void createInterad() {
  //   if (_interstitialAd == null) {
  //     InterstitialAd.load(
  //       adUnitId: AdUnitHelper.interstitialAdUnitId,
  //       request: const AdRequest(),
  //       adLoadCallback: InterstitialAdLoadCallback(
  //         onAdLoaded: (InterstitialAd ad) {
  //           _interstitialAd = ad;
  //           debugPrint('$ad loaded Interstitial.');
  //           _interstitialLoadAttempts = 0;
  //           _adCounter = 0; // Reset the ad counter when a new ad is loaded
  //         },
  //         onAdFailedToLoad: (LoadAdError error) {
  //           debugPrint('$error loaded Interstitial Failed.');
  //           _interstitialAd = null;
  //           createInterad();
  //           // Handle load failure appropriately
  //         },
  //       ),
  //     );
  //   }
  // }

  // // Show interstitial ads after the 5th time clicking
  // void showInterad() {
  //   if (_interstitialAd != null) {
  //     _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
  //       onAdDismissedFullScreenContent: (InterstitialAd ad) {
  //         ad.dispose();
  //         // Increment the ad counter after each click
  //         _adCounter++;

  //         // Check if it's the 5th click and show the ad
  //         if (_adCounter >= 5) {
  //           _interstitialAd!.show();
  //           _adCounter = 0; // Reset the counter after showing the ad
  //         }
  //         createInterad();
  //       },
  //       onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
  //         ad.dispose();
  //         _interstitialAd = null;
  //       },
  //     );
  //     // _interstitialAd?.show();
  //   } else {
  //     debugPrint("InterstitialAd is null");
  //   }
  // }

  // Create interstitial ads
  // Future<void> createInterad() async {
  //   await InterstitialAd.load(
  //     adUnitId: AdUnitHelper.interstitialAdUnitId,
  //     request: const AdRequest(),
  //     adLoadCallback: InterstitialAdLoadCallback(
  //       onAdLoaded: (InterstitialAd ad) {
  //         _interstitialAd = ad;
  //         _interstitialLoadAttempts = 0;
  //         debugPrint('$ad loaded Interstitial.');
  //         // ad.dispose();
  //       },
  //       onAdFailedToLoad: (LoadAdError error) {
  //         debugPrint('$error loaded Interstitial Failed.');

  //         _interstitialAd = null;
  //         if (_interstitialLoadAttempts <= Environment.interstitialAdsShowAfter) {
  //           createInterad();
  //         }
  //       },
  //     ),
  //   );
  // }

  // // Show interstitial ads
  // void showInterad() {
  //   try {
  //     if (_interstitialAd != null) {
  //       _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
  //         onAdDismissedFullScreenContent: (InterstitialAd ad) {
  //           // createInterad().whenComplete(() {
  //           //   debugPrint("Shown And Dispose");
  //           //   ad.dispose();
  //           // });
  //         },
  //         onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
  //           debugPrint("Shown Failed");
  //           // ad.dispose();
  //           createInterad();
  //         },
  //       );
  //       debugPrint(_interstitialLoadAttempts);
  //       _interstitialAd?.show();
  //     } else {
  //       debugPrint("InterstitialAd is null");
  //     }
  //   } catch (e) {
  //     // createInterad();

  //     Get.snackbar("Error", e.toString());
  //   }
  // }

// Show interstitial ads after the 5th time clicking
  // void showInterad() {
  //   if (_interstitialAd != null) {
  //     _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
  //       onAdDismissedFullScreenContent: (InterstitialAd ad) {
  //         ad.dispose();
  //         // Increment the ad counter and check if it's the 5th click

  //         if (_interstitialLoadAttempts >= 5) {
  //           createInterad();
  //           _interstitialLoadAttempts = 0; // Reset the counter after showing the ad
  //         }
  //       },
  //       onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
  //         ad.dispose();
  //         createInterad();
  //       },
  //     );
  //     _interstitialAd?.show();
  //   } else {
  //     debugPrint("InterstitialAd is null");
  //   }
  // }

  // create and load interstitial ads always
  void loadInterstitialAdAlways() {
    if (Environment.showInterstitialAds == true) {
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

  // create and load Reward ads Autromaticaly
  void loadRewardAdAlways() {
    if (Environment.showRewardlAds == true) {
      RewardedAd.load(
          adUnitId: AdUnitHelper.rewardedAdUnitId,
          request: const AdRequest(),
          rewardedAdLoadCallback: RewardedAdLoadCallback(
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

              ad.show(onUserEarnedReward: (AdWithoutView ad, RewardItem rewardItem) {
                debugPrint("You Get ${rewardItem.amount}");
                // Reward the user for watching an ad.
              });
            },
            // Called when an ad request failed.
            onAdFailedToLoad: (LoadAdError error) {
              debugPrint('RewardedAd failed to load: $error');
            },
          ));
    }
  }
}
