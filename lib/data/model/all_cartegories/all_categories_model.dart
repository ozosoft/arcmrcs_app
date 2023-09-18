// To parse this JSON data, do
//
//     final allcategoriesModel = allcategoriesModelFromJson(jsonString);

import 'dart:convert';

import '../model/message_model/message_model.dart';

AllcategoriesModel allcategoriesModelFromJson(String str) => AllcategoriesModel.fromJson(json.decode(str));

String allcategoriesModelToJson(AllcategoriesModel data) => json.encode(data.toJson());

class AllcategoriesModel {
  String? remark;
  String? status;
  Message? message;
  Data? data;

  AllcategoriesModel({
    this.remark,
    this.status,
    this.message,
    this.data,
  });

  factory AllcategoriesModel.fromJson(Map<String, dynamic> json) => AllcategoriesModel(
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
  List<Category>? categories;
  String? imagePath;

  Data({
    this.categories,
    this.imagePath,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        categories: json["categories"] == null ? [] : List<Category>.from(json["categories"]!.map((x) => Category.fromJson(x))),
        imagePath: json["image_path"],
      );

  Map<String, dynamic> toJson() => {
        "categories": categories == null ? [] : List<dynamic>.from(categories!.map((x) => x.toJson())),
        "image_path": imagePath,
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
  String? subcategoriesCount;
  List<QuizInfo>? quizInfos;

  Category({
    this.id,
    this.name,
    this.image,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.questionsCount,
    this.subcategoriesCount,
    this.quizInfos,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        status: json["status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        questionsCount: json["questions_count"],
        subcategoriesCount: json["subcategories_count"],
        quizInfos: json["quiz_infos"] == null ? [] : List<QuizInfo>.from(json["quiz_infos"]!.map((x) => QuizInfo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "questions_count": questionsCount,
        "subcategories_count": subcategoriesCount,
        "quiz_infos": quizInfos == null ? [] : List<dynamic>.from(quizInfos!.map((x) => x.toJson())),
      };
}

class QuizInfo {
  int? id;
  String? typeId;
  String? categoryId;
  String? subCategoryId;
  dynamic title;
  dynamic image;
  dynamic startDate;
  dynamic endDate;
  dynamic prize;
  dynamic point;
  dynamic description;
  String? levelId;
  ExamTime? examStartTime;
  ExamTime? examEndTime;
  dynamic examDuration;
  dynamic examKey;
  double? winningMark;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  PlayInfo? playInfo;
  Level? level;

  QuizInfo({
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
    this.winningMark,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.playInfo,
    this.level,
  });

  factory QuizInfo.fromJson(Map<String, dynamic> json) {
    return QuizInfo(
      id: json["id"],
      typeId: json["type_id"],
      categoryId: json["category_id"],
      subCategoryId: json["sub_category_id"] ?? "",
      title: json["title"],
      image: json["image"],
      startDate: json["start_date"],
      endDate: json["end_date"],
      prize: json["prize"],
      point: json["point"],
      description: json["description"],
      levelId: json["level_id"],
      examStartTime: examTimeValues.map[json["exam_start_time"]],
      examEndTime: examTimeValues.map[json["exam_end_time"]],
      examDuration: json["exam_duration"],
      examKey: json["exam_key"],
      winningMark: double.parse(json["winning_mark"].toString()),
      status: json["status"],
      createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
      updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
      playInfo: json["play_info"] == null ? null : PlayInfo.fromJson(json["play_info"]),
      level: json["level"] == null ? null : Level.fromJson(json["level"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "type_id": typeId,
        "category_id": categoryId,
        "sub_category_id": subCategoryId,
        "title": title,
        "image": image,
        "start_date": startDate,
        "end_date": endDate,
        "prize": prize,
        "point": point,
        "description": description,
        "level_id": levelId,
        "exam_start_time": examTimeValues.reverse[examStartTime],
        "exam_end_time": examTimeValues.reverse[examEndTime],
        "exam_duration": examDuration,
        "exam_key": examKey,
        "winning_mark": winningMark,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "play_info": playInfo?.toJson(),
        "level": level?.toJson(),
      };
}

enum ExamTime { THE_0918_AM }

final examTimeValues = EnumValues({"09:18 am": ExamTime.THE_0918_AM});

class Level {
  int? id;
  String? title;
  String? level;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  Level({
    this.id,
    this.title,
    this.level,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Level.fromJson(Map<String, dynamic> json) => Level(
        id: json["id"],
        title: json["title"],
        level: json["level"],
        status: json["status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "level": level,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class PlayInfo {
  int? id;
  String? userId;
  String? quizInfoId;
  dynamic roomId;
  dynamic singleBattleId;
  String? isWin;
  String? fiftyFifty;
  String? audiencePoll;
  String? timeReset;
  String? flipQuestion;
  DateTime? createdAt;
  DateTime? updatedAt;

  PlayInfo({
    this.id,
    this.userId,
    this.quizInfoId,
    this.roomId,
    this.singleBattleId,
    this.isWin,
    this.fiftyFifty,
    this.audiencePoll,
    this.timeReset,
    this.flipQuestion,
    this.createdAt,
    this.updatedAt,
  });

  factory PlayInfo.fromJson(Map<String, dynamic> json) => PlayInfo(
        id: json["id"],
        userId: json["user_id"],
        quizInfoId: json["quiz_info_id"],
        roomId: json["room_id"],
        singleBattleId: json["single_battle_id"],
        isWin: json["is_win"],
        fiftyFifty: json["fifty_fifty"],
        audiencePoll: json["audience_poll"],
        timeReset: json["time_reset"],
        flipQuestion: json["flip_question"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "quiz_info_id": quizInfoId,
        "room_id": roomId,
        "single_battle_id": singleBattleId,
        "is_win": isWin,
        "fifty_fifty": fiftyFifty,
        "audience_poll": audiencePoll,
        "time_reset": timeReset,
        "flip_question": flipQuestion,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
