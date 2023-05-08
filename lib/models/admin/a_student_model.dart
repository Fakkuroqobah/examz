import 'dart:convert';

List<AStudentModel> aStudentModelFromJson(String str) => List<AStudentModel>.from(json.decode(str).map((x) => AStudentModel.fromJson(x)));

String aStudentModelToJson(List<AStudentModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AStudentModel {
  int id;
  String name;
  String aStudentModelClass;
  String username;
  String role;
  DateTime? createdAt;
  DateTime? updatedAt;

  AStudentModel({
    required this.id,
    required this.name,
    required this.aStudentModelClass,
    required this.username,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AStudentModel.fromJson(Map<String, dynamic> json) => AStudentModel(
    id: json["id"],
    name: json["name"],
    aStudentModelClass: json["class"],
    username: json["username"],
    role: json["role"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "class": aStudentModelClass,
    "username": username,
    "role": role,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}