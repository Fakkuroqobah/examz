import 'dart:convert';

TeacherModel teacherModelFromJson(String str) => TeacherModel.fromJson(json.decode(str));

String teacherModelToJson(TeacherModel data) => json.encode(data.toJson());

class TeacherModel {
  TeacherModel({
    required this.id,
    required this.code,
    required this.name,
    required this.username,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String code;
  String name;
  String username;
  String role;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory TeacherModel.fromJson(Map<String, dynamic> json) => TeacherModel(
    id: json["id"],
    code: json["code"],
    name: json["name"],
    username: json["username"],
    role: json["role"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "code": code,
    "name": name,
    "username": username,
    "role": role,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}