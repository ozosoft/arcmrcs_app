// To parse this JSON data, do
//
//     final battleAnswerSubmitModelData = battleAnswerSubmitModelFromJson(jsonString);

import 'dart:convert';

BattleAnswerSubmitModel battleAnswerSubmitModelFromJson(String str) => BattleAnswerSubmitModel.fromJson(json.decode(str));

String battleAnswerSubmitModelToJson(BattleAnswerSubmitModel data) => json.encode(data.toJson());

class BattleAnswerSubmitModel {
  final String remark;
  final String status;
  final Map<String, dynamic> message;
  final Map<String, dynamic> data;

  BattleAnswerSubmitModel({
    required this.remark,
    required this.status,
    required this.message,
    required this.data,
  });

  factory BattleAnswerSubmitModel.fromJson(Map<String, dynamic> json) {
    return BattleAnswerSubmitModel(
      remark: json['remark'],
      status: json['status'],
      message: json['message'],
      data: json['data'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'remark': remark,
      'status': status,
      'message': message,
      'data': data,
    };
  }
}
