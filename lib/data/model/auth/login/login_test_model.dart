import '../../model/message_model/message_model.dart';

class login_model {
  String? remark;
  String? status;
  Message? message;
  Data? data;

  login_model({this.remark, this.status, this.message, this.data});

  login_model.fromJson(Map<String, dynamic> json) {
    remark = json['remark'];
    status = json['status'];
    message =
        json['message'] != null ? Message.fromJson(json['message']) : null;
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['remark'] = remark;
    data['status'] = status;
    if (message != null) {
      data['message'] = message!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  GeneralSetting? generalSetting;

  Data({this.generalSetting});

  Data.fromJson(Map<String, dynamic> json) {
    generalSetting = json['general_setting'] != null
        ? GeneralSetting.fromJson(json['general_setting'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (generalSetting != null) {
      data['general_setting'] = generalSetting!.toJson();
    }
    return data;
  }
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
  Null createdAt;
  String? updatedAt;

  GeneralSetting(
      {this.id,
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
      this.updatedAt});

  GeneralSetting.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    siteName = json['site_name'];
    curText = json['cur_text'];
    curSym = json['cur_sym'];
    emailFrom = json['email_from'];
    smsBody = json['sms_body'];
    smsFrom = json['sms_from'];
    baseColor = json['base_color'];
    secondaryColor = json['secondary_color'];
    globalShortcodes = json['global_shortcodes'] != null
        ? GlobalShortcodes.fromJson(json['global_shortcodes'])
        : null;
    kv = json['kv'];
    ev = json['ev'];
    en = json['en'];
    sv = json['sv'];
    sn = json['sn'];
    forceSsl = json['force_ssl'];
    maintenanceMode = json['maintenance_mode'];
    securePassword = json['secure_password'];
    agree = json['agree'];
    multiLanguage = json['multi_language'];
    registration = json['registration'];
    activeTemplate = json['active_template'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['site_name'] = siteName;
    data['cur_text'] = curText;
    data['cur_sym'] = curSym;
    data['email_from'] = emailFrom;
    data['sms_body'] = smsBody;
    data['sms_from'] = smsFrom;
    data['base_color'] = baseColor;
    data['secondary_color'] = secondaryColor;
    if (globalShortcodes != null) {
      data['global_shortcodes'] = globalShortcodes!.toJson();
    }
    data['kv'] = kv;
    data['ev'] = ev;
    data['en'] = en;
    data['sv'] = sv;
    data['sn'] = sn;
    data['force_ssl'] = forceSsl;
    data['maintenance_mode'] = maintenanceMode;
    data['secure_password'] = securePassword;
    data['agree'] = agree;
    data['multi_language'] = multiLanguage;
    data['registration'] = registration;
    data['active_template'] = activeTemplate;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class GlobalShortcodes {
  String? siteName;
  String? siteCurrency;
  String? currencySymbol;

  GlobalShortcodes({this.siteName, this.siteCurrency, this.currencySymbol});

  GlobalShortcodes.fromJson(Map<String, dynamic> json) {
    siteName = json['site_name'];
    siteCurrency = json['site_currency'];
    currencySymbol = json['currency_symbol'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['site_name'] = siteName;
    data['site_currency'] = siteCurrency;
    data['currency_symbol'] = currencySymbol;
    return data;
  }
}