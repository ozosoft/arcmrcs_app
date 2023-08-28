// To parse this JSON data, do
//
//     final funNLearnQuestionsModel = funNLearnQuestionsModelFromJson(jsonString);

import 'dart:convert';

FunNLearnQuestionsModel funNLearnQuestionsModelFromJson(String str) => FunNLearnQuestionsModel.fromJson(json.decode(str));

String funNLearnQuestionsModelToJson(FunNLearnQuestionsModel data) => json.encode(data.toJson());

class FunNLearnQuestionsModel {
    String? remark;
    String? status;
    Message? message;
    Data? data;

    FunNLearnQuestionsModel({
        this.remark,
        this.status,
        this.message,
        this.data,
    });

    factory FunNLearnQuestionsModel.fromJson(Map<String, dynamic> json) => FunNLearnQuestionsModel(
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
    QuizInfo? quizInfo;
    List<Question>? questions;
    String? questionImagePath;

    Data({
        this.quizInfo,
        this.questions,
        this.questionImagePath,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        quizInfo: json["quizInfo"] == null ? null : QuizInfo.fromJson(json["quizInfo"]),
        questions: json["questions"] == null ? [] : List<Question>.from(json["questions"]!.map((x) => Question.fromJson(x))),
        questionImagePath: json["question_image_path"],
    );

    Map<String, dynamic> toJson() => {
        "quizInfo": quizInfo?.toJson(),
        "questions": questions == null ? [] : List<dynamic>.from(questions!.map((x) => x.toJson())),
        "question_image_path": questionImagePath,
    };
}

class Question {
    int? id;
    String? question;
    dynamic image;
    String? code;
    String? status;
    DateTime? createdAt;
    DateTime? updatedAt;
      String? selectedOptionId;
    Pivot? pivot;
    List<Option>? options;

    Question({
        this.id,
        this.question,
        this.image,
        this.code,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.selectedOptionId = '',
        this.pivot,
        this.options,
    });

    factory Question.fromJson(Map<String, dynamic> json) => Question(
        id: json["id"],
        question: json["question"],
        image: json["image"],
        code: json["code"],
        status: json["status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        pivot: json["pivot"] == null ? null : Pivot.fromJson(json["pivot"]),
        options: json["options"] == null ? [] : List<Option>.from(json["options"]!.map((x) => Option.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "question": question,
        "image": image,
        "code": code,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "pivot": pivot?.toJson(),
        "options": options == null ? [] : List<dynamic>.from(options!.map((x) => x.toJson())),
    };
      void setSelectedOptionId(String optionId) {
    selectedOptionId = optionId;
  }
}

class Option {
    int? id;
    String? questionId;
    String? option;
    String? isAnswer;
    dynamic audience;
    DateTime? createdAt;
    DateTime? updatedAt;

    Option({
        this.id,
        this.questionId,
        this.option,
        this.isAnswer,
        this.audience,
        this.createdAt,
        this.updatedAt,
    });

    factory Option.fromJson(Map<String, dynamic> json) => Option(
        id: json["id"],
        questionId: json["question_id"],
        option: json["option"],
        isAnswer: json["is_answer"],
        audience: json["audience"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "question_id": questionId,
        "option": option,
        "is_answer": isAnswer,
        "audience": audience,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}

class Pivot {
    String? quizInfoId;
    String? questionId;

    Pivot({
        this.quizInfoId,
        this.questionId,
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
    int? id;
    String? typeId;
    String? categoryId;
    String? subCategoryId;
    String? title;
    dynamic image;
    dynamic startDate;
    dynamic endDate;
    String? prize;
    String? point;
    String? description;
    dynamic levelId;
    String? examStartTime;
    String? examEndTime;
    dynamic examDuration;
    dynamic examKey;
    int? winningMark;
    String? status;
    DateTime? createdAt;
    DateTime? updatedAt;
    PlayInfo? playInfo;

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
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        playInfo: json["play_info"] == null ? null : PlayInfo.fromJson(json["play_info"]),
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
        "play_info": playInfo?.toJson(),
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
