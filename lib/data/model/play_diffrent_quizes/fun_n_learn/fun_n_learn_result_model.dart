// To parse this JSON data, do
//
//     final funNLearnResultModel = funNLearnResultModelFromJson(jsonString);

import 'dart:convert';

FunNLearnResultModel funNLearnResultModelFromJson(String str) => FunNLearnResultModel.fromJson(json.decode(str));

String funNLearnResultModelToJson(FunNLearnResultModel data) => json.encode(data.toJson());

class FunNLearnResultModel {
    String? remark;
    String? status;
    Message? message;
    Data? data;

    FunNLearnResultModel({
        this.remark,
        this.status,
        this.message,
        this.data,
    });

    factory FunNLearnResultModel.fromJson(Map<String, dynamic> json) => FunNLearnResultModel(
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
    int? winingScore;
    int? totalScore;

    Data({
        this.totalQuestion,
        this.correctAnswer,
        this.wrongAnswer,
        this.winingScore,
        this.totalScore,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        totalQuestion: json["totalQuestion"],
        correctAnswer: json["correctAnswer"],
        wrongAnswer: json["wrongAnswer"],
        winingScore: json["winingScore"],
        totalScore: json["totalScore"],
    );

    Map<String, dynamic> toJson() => {
        "totalQuestion": totalQuestion,
        "correctAnswer": correctAnswer,
        "wrongAnswer": wrongAnswer,
        "winingScore": winingScore,
        "totalScore": totalScore,
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
