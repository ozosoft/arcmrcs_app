// To parse this JSON data, do
//
//     final dailyQuizSubmitAnswerModel = dailyQuizSubmitAnswerModelFromJson(jsonString);

import 'dart:convert';

DailyQuizSubmitAnswerModel dailyQuizSubmitAnswerModelFromJson(String str) => DailyQuizSubmitAnswerModel.fromJson(json.decode(str));

String dailyQuizSubmitAnswerModelToJson(DailyQuizSubmitAnswerModel data) => json.encode(data.toJson());

class DailyQuizSubmitAnswerModel {
    String? remark;
    String? status;
    Message? message;
    Data? data;

    DailyQuizSubmitAnswerModel({
        this.remark,
        this.status,
        this.message,
        this.data,
    });

    factory DailyQuizSubmitAnswerModel.fromJson(Map<String, dynamic> json) => DailyQuizSubmitAnswerModel(
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
    int? totalQuestion;
    int? correctAnswer;
    int? wrongAnswer;
    String? winingCoin;
    User? user;

    Data({
        this.totalQuestion,
        this.correctAnswer,
        this.wrongAnswer,
        this.winingCoin,
        this.user,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        totalQuestion: json["totalQuestion"],
        correctAnswer: json["correctAnswer"],
        wrongAnswer: json["wrongAnswer"],
        winingCoin: json["winingCoin"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "totalQuestion": totalQuestion,
        "correctAnswer": correctAnswer,
        "wrongAnswer": wrongAnswer,
        "winingCoin": winingCoin,
        "user": user?.toJson(),
    };
}

class User {
    int? id;
    String? firstname;
    String? lastname;
    String? username;
    String? avatar;
    String? email;
    String? countryCode;
    String? mobile;
    String? refBy;
    dynamic referralCode;
    Address? address;
    String? status;
    String? kv;
    String? ev;
    String? sv;
    String? profileComplete;
    DateTime? verCodeSendAt;
    String? ts;
    String? tv;
    dynamic tsc;
    dynamic banReason;
    int? coins;
    int? score;
    dynamic loginBy;
    DateTime? createdAt;
    DateTime? updatedAt;

    User({
        this.id,
        this.firstname,
        this.lastname,
        this.username,
        this.avatar,
        this.email,
        this.countryCode,
        this.mobile,
        this.refBy,
        this.referralCode,
        this.address,
        this.status,
        this.kv,
        this.ev,
        this.sv,
        this.profileComplete,
        this.verCodeSendAt,
        this.ts,
        this.tv,
        this.tsc,
        this.banReason,
        this.coins,
        this.score,
        this.loginBy,
        this.createdAt,
        this.updatedAt,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        username: json["username"],
        avatar: json["avatar"],
        email: json["email"],
        countryCode: json["country_code"],
        mobile: json["mobile"],
        refBy: json["ref_by"],
        referralCode: json["referral_code"],
        address: json["address"] == null ? null : Address.fromJson(json["address"]),
        status: json["status"],
        kv: json["kv"],
        ev: json["ev"],
        sv: json["sv"],
        profileComplete: json["profile_complete"],
        verCodeSendAt: json["ver_code_send_at"] == null ? null : DateTime.parse(json["ver_code_send_at"]),
        ts: json["ts"],
        tv: json["tv"],
        tsc: json["tsc"],
        banReason: json["ban_reason"],
        coins: json["coins"],
        score: json["score"],
        loginBy: json["login_by"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "firstname": firstname,
        "lastname": lastname,
        "username": username,
        "avatar": avatar,
        "email": email,
        "country_code": countryCode,
        "mobile": mobile,
        "ref_by": refBy,
        "referral_code": referralCode,
        "address": address?.toJson(),
        "status": status,
        "kv": kv,
        "ev": ev,
        "sv": sv,
        "profile_complete": profileComplete,
        "ver_code_send_at": verCodeSendAt?.toIso8601String(),
        "ts": ts,
        "tv": tv,
        "tsc": tsc,
        "ban_reason": banReason,
        "coins": coins,
        "score": score,
        "login_by": loginBy,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}

class Address {
    String? country;
    String? address;
    String? state;
    String? zip;
    String? city;

    Address({
        this.country,
        this.address,
        this.state,
        this.zip,
        this.city,
    });

    factory Address.fromJson(Map<String, dynamic> json) => Address(
        country: json["country"],
        address: json["address"],
        state: json["state"],
        zip: json["zip"],
        city: json["city"],
    );

    Map<String, dynamic> toJson() => {
        "country": country,
        "address": address,
        "state": state,
        "zip": zip,
        "city": city,
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
