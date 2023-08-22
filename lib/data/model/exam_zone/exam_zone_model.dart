// To parse this JSON data, do
//
//     final examZoneModel = examZoneModelFromJson(jsonString);

import 'dart:convert';

ExamZoneModel examZoneModelFromJson(String str) => ExamZoneModel.fromJson(json.decode(str));

String examZoneModelToJson(ExamZoneModel data) => json.encode(data.toJson());

class ExamZoneModel {
    String? remark;
    String? status;
    Message? message;
    Data? data;

    ExamZoneModel({
        this.remark,
        this.status,
        this.message,
        this.data,
    });

    factory ExamZoneModel.fromJson(Map<String, dynamic> json) => ExamZoneModel(
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
    List<Exam>? exams;

    Data({
        this.exams,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        exams: json["exams"] == null ? [] : List<Exam>.from(json["exams"]!.map((x) => Exam.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "exams": exams == null ? [] : List<dynamic>.from(exams!.map((x) => x.toJson())),
    };
}

class Exam {
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
    String? winningMark;
    String? status;
    DateTime? createdAt;
    DateTime? updatedAt;

    Exam({
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
    });

    factory Exam.fromJson(Map<String, dynamic> json) => Exam(
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
        description: json["description"],
        levelId: json["level_id"],
        examStartTime: json["exam_start_time"],
        examEndTime: json["exam_end_time"],
        examDuration: json["exam_duration"],
        examKey: json["exam_key"],
        winningMark: json["winning_mark"].toString(),
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
        "end_date": "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
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
