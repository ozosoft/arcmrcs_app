// To parse this JSON data, do
//
//     final generalSettingResponseModel = generalSettingResponseModelFromJson(jsonString);

import 'dart:convert';

import '../model/message_model/message_model.dart';

GeneralSettingResponseModel generalSettingResponseModelFromJson(String str) => GeneralSettingResponseModel.fromJson(json.decode(str));

String generalSettingResponseModelToJson(GeneralSettingResponseModel data) => json.encode(data.toJson());

class GeneralSettingResponseModel {
  String? remark;
  String? status;
  Message? message;
  Data? data;

  GeneralSettingResponseModel({
    this.remark,
    this.status,
    this.message,
    this.data,
  });

  factory GeneralSettingResponseModel.fromJson(Map<String, dynamic> json) => GeneralSettingResponseModel(
        remark: json["remark"],
        status: json["status"],
        message: json["message"] == null ? null : Message.fromJson(json["message"]),
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "remark": remark,
        "status": status,
        "message": message?.toJson(),
        "data": data?.toJson(),
      };
}

class Data {
  GeneralSetting? generalSetting;

  Data({
    this.generalSetting,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        generalSetting: json["general_setting"] == null ? null : GeneralSetting.fromJson(json["general_setting"]),
      );

  Map<String, dynamic> toJson() => {
        "general_setting": generalSetting?.toJson(),
      };
}

class GeneralSetting {
  int? id;
  String? siteName;
  String? curText;
  String? curSym;
  String? emailFrom;
  String? smsBody;
  String? smsFrom;
  String? baseColor;
  String? secondaryColor;
  GlobalShortcodes? globalShortcodes;
  String? kv;
  String? ev;
  String? en;
  String? sv;
  String? sn;
  String? forceSsl;
  String? maintenanceMode;
  String? securePassword;
  String? agree;
  String? multiLanguage;
  String? registration;
  String? activeTemplate;
  PushConfig? pushConfig;
  String? pushNotification;
  String? gqAnsDuration;
  String? contestAnsDuration;
  String? funAnsDuration;
  String? guessAnsDuration;
  String? dailyQuizAnsDuration;
  String? battleAnsDuration;
  String? gqScore;
  String? contestScore;
  String? examScore;
  String? guessScore;
  String? dailyQuizScore;
  String? funScore;
  String? welcomeBonus;
  String? battleParticipatePoint;
  String? roomCreatePoint;
  String? perLevelQuestion;
  String? referCoin;
  String? battleCategory;
  String? perBattleQuestion;
  String? onSelectAnsStatus;
  SocialiteCredentials? socialiteCredentials;
  String? bannerAdsId;
  String? bannerAdsStatus;
  String? interstitialUnitId;
  String? interstitialUnitStatus;
  String? rewardedUnitId;
  String? rewardedUnitStatus;
  String? iosBannerAdsId;
  String? iosInterstitialUnitId;
  String? iosRewardedUnitId;
  String? googleLogin;
  String? mobileLogin;
  dynamic createdAt;
  String? updatedAt;

  GeneralSetting({
    this.id,
    this.siteName,
    this.curText,
    this.curSym,
    this.emailFrom,
    this.smsBody,
    this.smsFrom,
    this.baseColor,
    this.secondaryColor,
    this.globalShortcodes,
    this.kv,
    this.ev,
    this.en,
    this.sv,
    this.sn,
    this.forceSsl,
    this.maintenanceMode,
    this.securePassword,
    this.agree,
    this.multiLanguage,
    this.registration,
    this.activeTemplate,
    this.pushConfig,
    this.pushNotification,
    this.gqAnsDuration,
    this.contestAnsDuration,
    this.funAnsDuration,
    this.guessAnsDuration,
    this.dailyQuizAnsDuration,
    this.battleAnsDuration,
    this.gqScore,
    this.contestScore,
    this.examScore,
    this.guessScore,
    this.dailyQuizScore,
    this.funScore,
    this.welcomeBonus,
    this.battleParticipatePoint,
    this.roomCreatePoint,
    this.perLevelQuestion,
    this.referCoin,
    this.battleCategory,
    this.perBattleQuestion,
    this.onSelectAnsStatus,
    this.socialiteCredentials,
    this.bannerAdsId,
    this.bannerAdsStatus,
    this.interstitialUnitId,
    this.interstitialUnitStatus,
    this.rewardedUnitId,
    this.rewardedUnitStatus,
    this.iosBannerAdsId,
    this.iosInterstitialUnitId,
    this.iosRewardedUnitId,
    this.googleLogin,
    this.mobileLogin,
    this.createdAt,
    this.updatedAt,
  });

  factory GeneralSetting.fromJson(Map<String, dynamic> json) => GeneralSetting(
        id: json["id"],
        siteName: json["site_name"],
        curText: json["cur_text"],
        curSym: json["cur_sym"],
        emailFrom: json["email_from"],
        smsBody: json["sms_body"],
        smsFrom: json["sms_from"],
        baseColor: json["base_color"],
        secondaryColor: json["secondary_color"],
        globalShortcodes: json["global_shortcodes"] == null ? null : GlobalShortcodes.fromJson(json["global_shortcodes"]),
        kv: json["kv"],
        ev: json["ev"],
        en: json["en"],
        sv: json["sv"],
        sn: json["sn"],
        forceSsl: json["force_ssl"],
        maintenanceMode: json["maintenance_mode"],
        securePassword: json["secure_password"],
        agree: json["agree"],
        multiLanguage: json["multi_language"],
        registration: json["registration"],
        activeTemplate: json["active_template"],
        pushConfig: json["push_config"] == null ? null : PushConfig.fromJson(json["push_config"]),
        pushNotification: json["push_notification"],
        gqAnsDuration: json["gq_ans_duration"],
        contestAnsDuration: json["contest_ans_duration"],
        funAnsDuration: json["fun_ans_duration"],
        guessAnsDuration: json["guess_ans_duration"],
        dailyQuizAnsDuration: json["daily_quiz_ans_duration"],
        battleAnsDuration: json["battle_ans_duration"],
        gqScore: json["gq_score"],
        contestScore: json["contest_score"],
        examScore: json["exam_score"],
        guessScore: json["guess_score"],
        dailyQuizScore: json["daily_quiz_score"],
        funScore: json["fun_score"],
        welcomeBonus: json["welcome_bonus"],
        battleParticipatePoint: json["battle_participate_point"],
        roomCreatePoint: json["room_create_point"],
        perLevelQuestion: json["per_level_question"],
        referCoin: json["refer_coin"],
        battleCategory: json["battle_category"],
        perBattleQuestion: json["per_battle_question"],
        onSelectAnsStatus: json["on_select_ans_status"],
        socialiteCredentials: json["socialite_credentials"] == null ? null : SocialiteCredentials.fromJson(json["socialite_credentials"]),
        bannerAdsId: json["banner_ads_id"],
        bannerAdsStatus: json["banner_ads_status"],
        interstitialUnitId: json["interstitial_unit_id"],
        interstitialUnitStatus: json["interstitial_unit_status"],
        rewardedUnitId: json["rewarded_unit_id"],
        rewardedUnitStatus: json["rewarded_unit_status"],
        iosBannerAdsId: json["ios_banner_ads_id"],
        iosInterstitialUnitId: json["ios_interstitial_unit_id"],
        iosRewardedUnitId: json["ios_rewarded_unit_id"],
        googleLogin: json["google_login"],
        mobileLogin: json["mobile_login"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "site_name": siteName,
        "cur_text": curText,
        "cur_sym": curSym,
        "email_from": emailFrom,
        "sms_body": smsBody,
        "sms_from": smsFrom,
        "base_color": baseColor,
        "secondary_color": secondaryColor,
        "global_shortcodes": globalShortcodes?.toJson(),
        "kv": kv,
        "ev": ev,
        "en": en,
        "sv": sv,
        "sn": sn,
        "force_ssl": forceSsl,
        "maintenance_mode": maintenanceMode,
        "secure_password": securePassword,
        "agree": agree,
        "multi_language": multiLanguage,
        "registration": registration,
        "active_template": activeTemplate,
        "push_config": pushConfig?.toJson(),
        "push_notification": pushNotification,
        "gq_ans_duration": gqAnsDuration,
        "contest_ans_duration": contestAnsDuration,
        "fun_ans_duration": funAnsDuration,
        "guess_ans_duration": guessAnsDuration,
        "daily_quiz_ans_duration": dailyQuizAnsDuration,
        "battle_ans_duration": battleAnsDuration,
        "gq_score": gqScore,
        "contest_score": contestScore,
        "exam_score": examScore,
        "guess_score": guessScore,
        "daily_quiz_score": dailyQuizScore,
        "fun_score": funScore,
        "welcome_bonus": welcomeBonus,
        "battle_participate_point": battleParticipatePoint,
        "room_create_point": roomCreatePoint,
        "per_level_question": perLevelQuestion,
        "refer_coin": referCoin,
        "battle_category": battleCategory,
        "per_battle_question": perBattleQuestion,
        "on_select_ans_status": onSelectAnsStatus,
        "socialite_credentials": socialiteCredentials?.toJson(),
        "banner_ads_id": bannerAdsId,
        "banner_ads_status": bannerAdsStatus,
        "interstitial_unit_id": interstitialUnitId,
        "interstitial_unit_status": interstitialUnitStatus,
        "rewarded_unit_id": rewardedUnitId,
        "rewarded_unit_status": rewardedUnitStatus,
        "ios_banner_ads_id": iosBannerAdsId,
        "ios_interstitial_unit_id": iosInterstitialUnitId,
        "ios_rewarded_unit_id": iosRewardedUnitId,
        "google_login": googleLogin,
        "mobile_login": mobileLogin,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

class GlobalShortcodes {
  String? siteName;
  String? siteCurrency;
  String? currencySymbol;

  GlobalShortcodes({
    this.siteName,
    this.siteCurrency,
    this.currencySymbol,
  });

  factory GlobalShortcodes.fromJson(Map<String, dynamic> json) => GlobalShortcodes(
        siteName: json["site_name"],
        siteCurrency: json["site_currency"],
        currencySymbol: json["currency_symbol"],
      );

  Map<String, dynamic> toJson() => {
        "site_name": siteName,
        "site_currency": siteCurrency,
        "currency_symbol": currencySymbol,
      };
}

class PushConfig {
  String? serverKey;
  String? apiKey;
  String? authDomain;
  String? projectId;
  String? storageBucket;
  String? messagingSenderId;
  String? appId;
  String? measurementId;

  PushConfig({
    this.serverKey,
    this.apiKey,
    this.authDomain,
    this.projectId,
    this.storageBucket,
    this.messagingSenderId,
    this.appId,
    this.measurementId,
  });

  factory PushConfig.fromJson(Map<String, dynamic> json) => PushConfig(
        serverKey: json["serverKey"],
        apiKey: json["apiKey"],
        authDomain: json["authDomain"],
        projectId: json["projectId"],
        storageBucket: json["storageBucket"],
        messagingSenderId: json["messagingSenderId"],
        appId: json["appId"],
        measurementId: json["measurementId"],
      );

  Map<String, dynamic> toJson() => {
        "serverKey": serverKey,
        "apiKey": apiKey,
        "authDomain": authDomain,
        "projectId": projectId,
        "storageBucket": storageBucket,
        "messagingSenderId": messagingSenderId,
        "appId": appId,
        "measurementId": measurementId,
      };
}

class SocialiteCredentials {
  Facebook? google;
  Facebook? facebook;
  Facebook? linkedin;

  SocialiteCredentials({
    this.google,
    this.facebook,
    this.linkedin,
  });

  factory SocialiteCredentials.fromJson(Map<String, dynamic> json) => SocialiteCredentials(
        google: json["google"] == null ? null : Facebook.fromJson(json["google"]),
        facebook: json["facebook"] == null ? null : Facebook.fromJson(json["facebook"]),
        linkedin: json["linkedin"] == null ? null : Facebook.fromJson(json["linkedin"]),
      );

  Map<String, dynamic> toJson() => {
        "google": google?.toJson(),
        "facebook": facebook?.toJson(),
        "linkedin": linkedin?.toJson(),
      };
}

class Facebook {
  String? clientId;
  String? clientSecret;
  int? status;

  Facebook({
    this.clientId,
    this.clientSecret,
    this.status,
  });

  factory Facebook.fromJson(Map<String, dynamic> json) => Facebook(
        clientId: json["client_id"],
        clientSecret: json["client_secret"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "client_id": clientId,
        "client_secret": clientSecret,
        "status": status,
      };
}
