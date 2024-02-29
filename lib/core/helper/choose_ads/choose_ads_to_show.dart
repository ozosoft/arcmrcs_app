import 'package:quiz_lab/core/helper/ads/admob_helper.dart';
import 'package:quiz_lab/core/helper/unity-ads/unity_ads_helper.dart';

class ChooseAds {
  static showInterstileAds(bool isAdmobActive) async {
     await AdManager.loadUnityIntAd();
    if (isAdmobActive) {
      AdmobHelper().showGoodInterstitialAds();
    } else {
      AdManager.showIntAd();
    }
  }

  static showRewardedAds(bool isAdmobActive) async{
   
      await AdManager.loadUnityRewardedAd();
    if (isAdmobActive) {
      AdmobHelper().loadRewardAdAlways();
    } else {
      print("called here");
      AdManager.showRewardedAd();
    }
  }
}
