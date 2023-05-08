import 'dart:convert';

PSupervisorModel? pSupervisorModelFromJson(String str) => PSupervisorModel.fromJson(json.decode(str));

String pSupervisorModelToJson(PSupervisorModel? data) => json.encode(data!.toJson());

class PSupervisorModel {
  PSupervisorModel({
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
  DateTime? createdAt;
  DateTime? updatedAt;

  factory PSupervisorModel.fromJson(Map<String, dynamic> json) => PSupervisorModel(
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
