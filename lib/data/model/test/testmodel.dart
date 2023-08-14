// To parse this JSON data, do
//
//     final test = testFromJson(jsonString);

import 'dart:convert';

Test testFromJson(String str) => Test.fromJson(json.decode(str));

String testToJson(Test data) => json.encode(data.toJson());

class Test {
    String? remark;
    String? status;
    Message? message;
    Data? data;

    Test({
        this.remark,
        this.status,
        this.message,
        this.data,
    });

    factory Test.fromJson(Map<String, dynamic> json) => Test(
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
    int? kv;
    int? ev;
    int? en;
    int? sv;
    int? sn;
    int? forceSsl;
    int? maintenanceMode;
    int? securePassword;
    int? agree;
    int? multiLanguage;
    int? registration;
    String? activeTemplate;
    dynamic createdAt;
    DateTime? updatedAt;

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
        createdAt: json["created_at"],
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
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
        "created_at": createdAt,
        "updated_at": updatedAt?.toIso8601String(),
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

class Message {
    List<String>? success;

    Message({
        this.success,
    });

    factory Message.fromJson(Map<String, dynamic> json) => Message(
        success: json["success"] == null ? [] : List<String>.from(json["success"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "success": success == null ? [] : List<dynamic>.from(success!.map((x) => x)),
    };
}
