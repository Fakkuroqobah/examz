import 'dart:convert';

SStudentModel? sStudentModelFromJson(String str) => SStudentModel.fromJson(json.decode(str));

String sStudentModelToJson(SStudentModel? data) => json.encode(data!.toJson());

class SStudentModel {
  SStudentModel({
    required this.id,
    required this.name,
    required this.sStudentModelClass,
    required this.username,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String name;
  String sStudentModelClass;
  String username;
  String role;
  DateTime createdAt;
  DateTime updatedAt;

  factory SStudentModel.fromJson(Map<String, dynamic> json) => SStudentModel(
    id: json["id"],
    name: json["name"],
    sStudentModelClass: json["class"],
    username: json["username"],
    role: json["role"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "class": sStudentModelClass,
    "username": username,
    "role": role,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
