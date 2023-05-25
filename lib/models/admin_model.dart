import 'dart:convert';

AdminModel? adminModelFromJson(String str) => AdminModel.fromJson(json.decode(str));

String adminModelToJson(AdminModel? data) => json.encode(data!.toJson());

class AdminModel {
  AdminModel({
    required this.id,
    required this.username,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String username;
  String role;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory AdminModel.fromJson(Map<String, dynamic> json) => AdminModel(
    id: json["id"],
    username: json["username"],
    role: json["role"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "role": role,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}