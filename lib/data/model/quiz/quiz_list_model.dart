// To parse this JSON data, do
//
//     final quizListModel = quizListModelFromJson(jsonString);

import 'dart:convert';

QuizListModel quizListModelFromJson(String str) =>
    QuizListModel.fromJson(json.decode(str));

String quizListModelToJson(QuizListModel data) => json.encode(data.toJson());

class QuizListModel {
  String remark;
  String status;
  Message message;
  Data data;

  QuizListModel({
    required this.remark,
    required this.status,
    required this.message,
    required this.data,
  });

  factory QuizListModel.fromJson(Map<String, dynamic> json) => QuizListModel(
        remark: json["remark"],
        status: json["status"],
        message: Message.fromJson(json["message"]),
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "remark": remark,
        "status": status,
        "message": message.toJson(),
        "data": data.toJson(),
      };
}

class Data {
  QuizInfo quizInfo;
  List<Question> questions;
  FlipQuestion flipQuestion;
  String questionImagePath;

  Data({
    required this.quizInfo,
    required this.questions,
    required this.flipQuestion,
    required this.questionImagePath,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        quizInfo: QuizInfo.fromJson(json["quizInfo"]),
        questions: List<Question>.from(
            json["questions"].map((x) => Question.fromJson(x))),
        flipQuestion: FlipQuestion.fromJson(json["flipQuestion"]),
        questionImagePath: json["question_image_path"],
      );

  Map<String, dynamic> toJson() => {
        "quizInfo": quizInfo.toJson(),
        "questions": List<dynamic>.from(questions.map((x) => x.toJson())),
        "flipQuestion": flipQuestion.toJson(),
        "question_image_path": questionImagePath,
      };
}

class FlipQuestion {
  int id;
  String question;
  dynamic image;
  String code;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  List<Option> options;

  FlipQuestion({
    required this.id,
    required this.question,
    required this.image,
    required this.code,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.options,
  });

  factory FlipQuestion.fromJson(Map<String, dynamic> json) => FlipQuestion(
        id: json["id"],
        question: json["question"],
        image: json["image"],
        code: json["code"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        options:
            List<Option>.from(json["options"].map((x) => Option.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "question": question,
        "image": image,
        "code": code,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "options": List<dynamic>.from(options.map((x) => x.toJson())),
      };
}

class Option {
  int id;
  String questionId;
  String option;
  String isAnswer;
  String? audience;
  DateTime createdAt;
  DateTime updatedAt;

  Option({
    required this.id,
    required this.questionId,
    required this.option,
    required this.isAnswer,
    required this.audience,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Option.fromJson(Map<String, dynamic> json) => Option(
        id: json["id"],
        questionId: json["question_id"],
        option: json["option"],
        isAnswer: json["is_answer"],
        audience: json["audience"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "question_id": questionId,
        "option": option,
        "is_answer": isAnswer,
        "audience": audience,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Question {
  int id;
  String question;
  dynamic image;
  String code;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  Pivot pivot;
  List<Option> options;

  Question({
    required this.id,
    required this.question,
    required this.image,
    required this.code,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.pivot,
    required this.options,
  });

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        id: json["id"],
        question: json["question"],
        image: json["image"],
        code: json["code"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        pivot: Pivot.fromJson(json["pivot"]),
        options:
            List<Option>.from(json["options"].map((x) => Option.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "question": question,
        "image": image,
        "code": code,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "pivot": pivot.toJson(),
        "options": List<dynamic>.from(options.map((x) => x.toJson())),
      };
}

class Pivot {
  String quizInfoId;
  String questionId;

  Pivot({
    required this.quizInfoId,
    required this.questionId,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
        quizInfoId: json["quiz_info_id"],
        questionId: json["question_id"],
      );

  Map<String, dynamic> toJson() => {
        "quiz_info_id": quizInfoId,
        "question_id": questionId,
      };
}

class QuizInfo {
  int id;
  String typeId;
  String categoryId;
  String subCategoryId;
  dynamic title;
  dynamic image;
  dynamic startDate;
  dynamic endDate;
  dynamic prize;
  dynamic point;
  dynamic description;
  String levelId;
  String examStartTime;
  String examEndTime;
  dynamic examDuration;
  dynamic examKey;
  int winningMark;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic playInfo;

  QuizInfo({
    required this.id,
    required this.typeId,
    required this.categoryId,
    required this.subCategoryId,
    required this.title,
    required this.image,
    required this.startDate,
    required this.endDate,
    required this.prize,
    required this.point,
    required this.description,
    required this.levelId,
    required this.examStartTime,
    required this.examEndTime,
    required this.examDuration,
    required this.examKey,
    required this.winningMark,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.playInfo,
  });

  factory QuizInfo.fromJson(Map<String, dynamic> json) => QuizInfo(
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
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        playInfo: json["play_info"],
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
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "play_info": playInfo,
      };
}

class Message {
  List<String> success;

  Message({
    required this.success,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        success: List<String>.from(json["success"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "success": List<dynamic>.from(success.map((x) => x)),
      };
}
