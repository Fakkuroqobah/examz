import 'dart:convert';

List<ATeacherModel> aTeacherModelFromJson(String str) => List<ATeacherModel>.from(json.decode(str).map((x) => ATeacherModel.fromJson(x)));

String aTeacherModelToJson(List<ATeacherModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ATeacherModel {
  int id;
  String name;
  String username;
  String role;
  DateTime createdAt;
  DateTime updatedAt;

  ATeacherModel({
    required this.id,
    required this.name,
    required this.username,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ATeacherModel.fromJson(Map<String, dynamic> json) => ATeacherModel(
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