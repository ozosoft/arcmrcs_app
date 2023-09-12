// To parse this JSON data, do
//
//     final dashBoardModel = dashBoardModelFromJson(jsonString);

import 'dart:convert';

import '../model/message_model/message_model.dart';

DashBoardModel dashBoardModelFromJson(String str) => DashBoardModel.fromJson(json.decode(str));

String dashBoardModelToJson(DashBoardModel data) => json.encode(data.toJson());

class DashBoardModel {
  String? remark;
  String? status;
  Message? message;
  Data? data;

  DashBoardModel({
    this.remark,
    this.status,
    this.message,
    this.data,
  });

  factory DashBoardModel.fromJson(Map<String, dynamic> json) => DashBoardModel(
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
  User? user;
  Rank? rank;
  List<QuizType>? quizType;
  List<Category>? categories;
  List<Contest>? contest;
  List<Exams>? exams;

  Data({
    this.user,
    this.rank,
    this.quizType,
    this.categories,
    this.contest,
    this.exams,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      user: json["user"] == null ? null : User.fromJson(json["user"]),
      rank: json["rank"] == null ? null : Rank.fromJson(json["rank"]),
      quizType: json["quiz_type"] == null ? [] : List<QuizType>.from(json["quiz_type"]!.map((x) => QuizType.fromJson(x))),
      categories: json["categories"] == null ? [] : List<Category>.from(json["categories"]!.map((x) => Category.fromJson(x))),
      contest: json["contest"] == null ? [] : List<Contest>.from(json["contest"]!.map((x) => Contest.fromJson(x))),
      exams: json["exams"] == null ? [] : List<Exams>.from(json["exams"]!.map((x) => Exams.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "rank": rank?.toJson(),
        "quiz_type": quizType == null ? [] : List<dynamic>.from(quizType!.map((x) => x.toJson())),
        "categories": categories == null ? [] : List<dynamic>.from(categories!.map((x) => x.toJson())),
        "contest": contest == null ? [] : List<dynamic>.from(contest!.map((x) => x.toJson())),
        "exams": exams == null ? [] : List<dynamic>.from(exams!.map((x) => x.toJson())),
      };
}

class Category {
  int? id;
  String? name;
  String? image;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? questionsCount;

  Category({
    this.id,
    this.name,
    this.image,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.questionsCount,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        status: json["status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        questionsCount: json["questions_count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "questions_count": questionsCount,
      };
}

class Contest {
  int? id;
  String? typeId;
  dynamic categoryId;
  dynamic subCategoryId;
  String? title;
  String? image;
  DateTime? startDate;
  String? endDate;
  String? prize;
  String? point;
  dynamic description;
  dynamic levelId;
  String? examStartTime;
  String? examEndTime;
  String? examDuration;
  String? examKey;
  dynamic enrolledPlayer;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  Contest({
    this.id,
    this.typeId,
    this.categoryId,
    this.subCategoryId,
    this.title,
    this.image,
    this.startDate,
    this.endDate,
    this.prize,
    this.point,
    this.description,
    this.levelId,
    this.examStartTime,
    this.examEndTime,
    this.examDuration,
    this.examKey,
    this.enrolledPlayer,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Contest.fromJson(Map<String, dynamic> json) => Contest(
        id: json["id"],
        typeId: json["type_id"],
        categoryId: json["category_id"],
        subCategoryId: json["sub_category_id"],
        title: json["title"],
        image: json["image"],
        startDate: json["start_date"] == null ? null : DateTime.parse(json["start_date"]),
        endDate: json["end_date"] == null ? null : json["end_date"].toString(),
        prize: json["prize"],
        point: json["point"],
        description: json["description"] ?? "",
        levelId: json["level_id"],
        examStartTime: json["exam_start_time"],
        examEndTime: json["exam_end_time"],
        examDuration: json["exam_duration"],
        examKey: json["exam_key"],
        enrolledPlayer: json["enrolled_player"],
        status: json["status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type_id": typeId,
        "category_id": categoryId,
        "sub_category_id": subCategoryId,
        "title": title,
        "image": image,
        "start_date": "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
        "end_date": "${endDate!.toString().padLeft(4, '0')}-${endDate!.toString().padLeft(2, '0')}-${endDate!.toString().padLeft(2, '0')}",
        "prize": prize,
        "point": point,
        "description": description,
        "level_id": levelId,
        "exam_start_time": examStartTime,
        "exam_end_time": examEndTime,
        "exam_duration": examDuration,
        "exam_key": examKey,
        "enrolled_player": enrolledPlayer,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class Exams {
  int? id;
  String? typeId;
  dynamic categoryId;
  dynamic subCategoryId;
  String? title;
  String? image;
  DateTime? startDate;
  DateTime? endDate;
  String? prize;
  String? point;
  dynamic description;
  dynamic levelId;
  String? examStartTime;
  String? examEndTime;
  String? examDuration;
  String? examKey;
  dynamic enrolledPlayer;
  String? status;
  String? winningmark;
  DateTime? createdAt;
  DateTime? updatedAt;

  Exams({
    this.id,
    this.typeId,
    this.categoryId,
    this.subCategoryId,
    this.title,
    this.image,
    this.startDate,
    this.endDate,
    this.prize,
    this.point,
    this.description,
    this.levelId,
    this.examStartTime,
    this.examEndTime,
    this.examDuration,
    this.examKey,
    this.enrolledPlayer,
    this.status,
    this.winningmark,
    this.createdAt,
    this.updatedAt,
  });

  factory Exams.fromJson(Map<String, dynamic> json) => Exams(
        id: json["id"],
        typeId: json["type_id"],
        categoryId: json["category_id"],
        subCategoryId: json["sub_category_id"],
        title: json["title"],
        image: json["image"],
        startDate: json["start_date"] == null ? null : DateTime.parse(json["start_date"]),
        endDate: json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        prize: json["prize"],
        point: json["point"],
        description: json["description"] ?? "",
        levelId: json["level_id"],
        examStartTime: json["exam_start_time"],
        examEndTime: json["exam_end_time"],
        examDuration: json["exam_duration"],
        examKey: json["exam_key"],
        enrolledPlayer: json["enrolled_player"],
        status: json["status"],
        winningmark: json["winning_mark"].toString(),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type_id": typeId,
        "category_id": categoryId,
        "sub_category_id": subCategoryId,
        "title": title,
        "image": image,
        "start_date": "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
        "end_date": "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
        "prize": prize,
        "point": point,
        "description": description,
        "level_id": levelId,
        "exam_start_time": examStartTime,
        "exam_end_time": examEndTime,
        "exam_duration": examDuration,
        "exam_key": examKey,
        "enrolled_player": enrolledPlayer,
        "status": status,
        "winning_mark": winningmark,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class QuizType {
  int? id;
  String? name;
  String? act;
  String? image;
  String? isCategorise;
  String? status;
  String? shortDescription;
  DateTime? createdAt;
  DateTime? updatedAt;

  QuizType({
    this.id,
    this.name,
    this.act,
    this.image,
    this.isCategorise,
    this.status,
    this.shortDescription,
    this.createdAt,
    this.updatedAt,
  });

  factory QuizType.fromJson(Map<String, dynamic> json) => QuizType(
        id: json["id"],
        name: json["name"],
        act: json["act"],
        image: json["image"] ?? "",
        isCategorise: json["is_categorise"],
        status: json["status"],
        shortDescription: json["short_description"] ?? "",
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "act": act,
        "image": image,
        "is_categorise": isCategorise,
        "status": status,
        "short_description": shortDescription,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class Rank {
  String? userRank;

  Rank({
    this.userRank,
  });

  factory Rank.fromJson(Map<String, dynamic> json) => Rank(
        userRank: json["user_rank"],
      );

  Map<String, dynamic> toJson() => {
        "user_rank": userRank,
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
  String? coins;
  String? score;
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
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class Address {
  String? address;
  String? city;
  String? state;
  String? zip;
  String? country;

  Address({
    this.address,
    this.city,
    this.state,
    this.zip,
    this.country,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        address: json["address"],
        city: json["city"],
        state: json["state"],
        zip: json["zip"],
        country: json["country"],
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "city": city,
        "state": state,
        "zip": zip,
        "country": country,
      };
}
