// To parse this JSON data, do
//
//     final submitAnswerModel = submitAnswerModelFromJson(jsonString);

import 'dart:convert';

SubmitAnswerModel submitAnswerModelFromJson(String str) => SubmitAnswerModel.fromJson(json.decode(str));

String submitAnswerModelToJson(SubmitAnswerModel data) => json.encode(data.toJson());

class SubmitAnswerModel {
    String? remark;
    String? status;
    Message? message;
    Data? data;

    SubmitAnswerModel({
        this.remark,
        this.status,
        this.message,
        this.data,
    });

    factory SubmitAnswerModel.fromJson(Map<String, dynamic> json) => SubmitAnswerModel(
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
    String? totalQuestion;
    String? correctAnswer;
    String? wrongAnswer;
    String? winingScore;
    String? totalScore;
    NextLevelQuizInfo? nextLevelQuizInfo;

    Data({
        this.totalQuestion,
        this.correctAnswer,
        this.wrongAnswer,
        this.winingScore,
        this.totalScore,
        this.nextLevelQuizInfo,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        totalQuestion: json["totalQuestion"].toString(),
        correctAnswer: json["correctAnswer"].toString(),
        wrongAnswer: json["wrongAnswer"],
        winingScore: json["winingScore"],
        totalScore: json["totalScore"],
        nextLevelQuizInfo: json["nextLevelQuizInfo"] == null ? null : NextLevelQuizInfo.fromJson(json["nextLevelQuizInfo"]),
    );

    Map<String, dynamic> toJson() => {
        "totalQuestion": totalQuestion,
        "correctAnswer": correctAnswer,
        "wrongAnswer": wrongAnswer,
        "winingScore": winingScore,
        "totalScore": totalScore,
        "nextLevelQuizInfo": nextLevelQuizInfo?.toJson(),
    };
}

class NextLevelQuizInfo {
    int? id;
    String? typeId;
    String? categoryId;
    dynamic subCategoryId;
    dynamic title;
    dynamic image;
    dynamic startDate;
    dynamic endDate;
    dynamic prize;
    dynamic point;
    dynamic description;
    String? levelId;
    String? examStartTime;
    String? examEndTime;
    dynamic examDuration;
    dynamic examKey;
    String? winningMark;
    String? status;
    DateTime? createdAt;
    DateTime? updatedAt;
    Level? level;

    NextLevelQuizInfo({
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
        this.level,
    });

    factory NextLevelQuizInfo.fromJson(Map<String, dynamic> json) => NextLevelQuizInfo(
        id: json["id"],
        typeId: json["type_id"],
        categoryId: json["category_id"],
        subCategoryId: json["sub_category_id"],
        title: json["title"],
        image: json["image"],
        startDate: json["start_date"],
        endDate: json["end_date"],
        prize: json["prize"],
        point: json["point"],
        description: json["description"],
        levelId: json["level_id"],
        examStartTime: json["exam_start_time"],
        examEndTime: json["exam_end_time"],
        examDuration: json["exam_duration"],
        examKey: json["exam_key"],
        winningMark: json["winning_mark"],
        status: json["status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        level: json["level"] == null ? null : Level.fromJson(json["level"]),
    );

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
        "exam_start_time": examStartTime,
        "exam_end_time": examEndTime,
        "exam_duration": examDuration,
        "exam_key": examKey,
        "winning_mark": winningMark,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "level": level?.toJson(),
    };
}

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
