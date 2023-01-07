import 'dart:convert';

TTeacherModel tTeacherModelFromJson(String str) => TTeacherModel.fromJson(json.decode(str));

String tTeacherModelToJson(TTeacherModel data) => json.encode(data.toJson());

class TTeacherModel {
  TTeacherModel({
    required this.id,
    required this.name,
    required this.username,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String name;
  String username;
  String role;
  DateTime createdAt;
  DateTime updatedAt;

  factory TTeacherModel.fromJson(Map<String, dynamic> json) => TTeacherModel(
    id: json["id"],
    name: json["name"],
    username: json["username"],
    role: json["role"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "username": username,
    "role": role,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}