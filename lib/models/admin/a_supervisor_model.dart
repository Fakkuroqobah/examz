import 'dart:convert';

List<ASupervisorModel> aSupervisorModelFromJson(String str) => List<ASupervisorModel>.from(json.decode(str).map((x) => ASupervisorModel.fromJson(x)));

String aSupervisorModelToJson(List<ASupervisorModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ASupervisorModel {
  int id;
  String name;
  String username;
  String role;
  DateTime? createdAt;
  DateTime? updatedAt;

  ASupervisorModel({
    required this.id,
    required this.name,
    required this.username,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ASupervisorModel.fromJson(Map<String, dynamic> json) => ASupervisorModel(
    id: json["id"],
    name: json["name"],
    username: json["username"],
    role: json["role"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "username": username,
    "role": role,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}