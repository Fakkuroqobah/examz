import 'dart:convert';

List<AExamModel> aExamModelFromJson(String str) => List<AExamModel>.from(json.decode(str).map((x) => AExamModel.fromJson(x)));

String aExamModelToJson(List<AExamModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AExamModel {
  int id;
  String aExamModelClass;
  String name;
  String status;
  int isRandom;
  String thumbnail;
  String? description;
  int time;
  DateTime? createdAt;
  DateTime? updatedAt;

  AExamModel({
    required this.id,
    required this.aExamModelClass,
    required this.name,
    required this.status,
    required this.isRandom,
    required this.thumbnail,
    required this.description,
    required this.time,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AExamModel.fromJson(Map<String, dynamic> json) => AExamModel(
    id: json["id"],
    aExamModelClass: json["class"],
    name: json["name"],
    status: json["status"],
    isRandom: json["is_random"],
    thumbnail: json["thumbnail"],
    description: json["description"],
    time: json["time"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "class": aExamModelClass,
    "name": name,
    "status": status,
    "is_random": isRandom,
    "thumbnail": thumbnail,
    "description": description,
    "time": time,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}