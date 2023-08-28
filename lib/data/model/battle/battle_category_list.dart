// To parse this JSON data, do
//
//     final battleCategoryList = battleCategoryListFromJson(jsonString);

import 'dart:convert';

BattleCategoryList battleCategoryListFromJson(String str) => BattleCategoryList.fromJson(json.decode(str));

String battleCategoryListToJson(BattleCategoryList data) => json.encode(data.toJson());

class BattleCategoryList {
    String remark;
    String status;
    Message message;
    Data data;

    BattleCategoryList({
        required this.remark,
        required this.status,
        required this.message,
        required this.data,
    });

    factory BattleCategoryList.fromJson(Map<String, dynamic> json) => BattleCategoryList(
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
    List<BattleCategory> categories;
    String entryCoin;

    Data({
        required this.categories,
        required this.entryCoin,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        categories: List<BattleCategory>.from(json["categories"].map((x) => BattleCategory.fromJson(x))),
        entryCoin: json["entryCoin"],
    );

    Map<String, dynamic> toJson() => {
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
        "entryCoin": entryCoin,
    };
}

class BattleCategory {
    int id;
    String name;
    String image;
    String status;
    DateTime createdAt;
    DateTime updatedAt;

    BattleCategory({
        required this.id,
        required this.name,
        required this.image,
        required this.status,
        required this.createdAt,
        required this.updatedAt,
    });

    factory BattleCategory.fromJson(Map<String, dynamic> json) => BattleCategory(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
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
