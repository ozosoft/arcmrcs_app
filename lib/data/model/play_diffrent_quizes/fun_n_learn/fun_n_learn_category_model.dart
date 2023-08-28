// To parse this JSON data, do
//
//     final funNLearncategoryModel = funNLearncategoryModelFromJson(jsonString);

import 'dart:convert';

FunNLearncategoryModel funNLearncategoryModelFromJson(String str) => FunNLearncategoryModel.fromJson(json.decode(str));

String funNLearncategoryModelToJson(FunNLearncategoryModel data) => json.encode(data.toJson());

class FunNLearncategoryModel {
    String? remark;
    String? status;
    Message? message;
    Data? data;

    FunNLearncategoryModel({
        this.remark,
        this.status,
        this.message,
        this.data,
    });

    factory FunNLearncategoryModel.fromJson(Map<String, dynamic> json) => FunNLearncategoryModel(
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
    String? categoryImagePath;

    Data({
        this.categories,
        this.categoryImagePath,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        categories: json["categories"] == null ? [] : List<Category>.from(json["categories"]!.map((x) => Category.fromJson(x))),
        categoryImagePath: json["category_image_path"],
    );

    Map<String, dynamic> toJson() => {
        "categories": categories == null ? [] : List<dynamic>.from(categories!.map((x) => x.toJson())),
        "category_image_path": categoryImagePath,
    };
}

class Category {
    int? id;
    String? name;
    String? image;
    String? status;
    DateTime? createdAt;
    DateTime? updatedAt;
    String? subcategoriesCount;
    String? quizInfosCount;

    Category({
        this.id,
        this.name,
        this.image,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.subcategoriesCount,
        this.quizInfosCount,
    });

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        status: json["status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        subcategoriesCount: json["subcategories_count"].toString(),
        quizInfosCount: json["quiz_infos_count"].toString(),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "subcategories_count": subcategoriesCount,
        "quiz_infos_count": quizInfosCount,
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
