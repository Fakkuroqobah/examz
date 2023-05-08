import 'dart:convert';

AAdminModel? aAdminModelFromJson(String str) => AAdminModel.fromJson(json.decode(str));

String aAdminModelToJson(AAdminModel? data) => json.encode(data!.toJson());

class AAdminModel {
  AAdminModel({
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

  factory AAdminModel.fromJson(Map<String, dynamic> json) => AAdminModel(
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