import 'dart:convert';

import 'room_model.dart';

StudentModel? studentModelFromJson(String str) => StudentModel.fromJson(json.decode(str));

String studentModelToJson(StudentModel? data) => json.encode(data!.toJson());

class StudentModel {
  StudentModel({
    required this.id,
    required this.nis,
    required this.name,
    required this.studentModelClass,
    required this.username,
    required this.role,
    required this.roomId,
    required this.room,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String nis;
  String name;
  String studentModelClass;
  String username;
  String role;
  int roomId;
  RoomModel? room;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory StudentModel.fromJson(Map<String, dynamic> json) => StudentModel(
    id: json["id"],
    nis: json["nis"],
    name: json["name"],
    studentModelClass: json["class"],
    username: json["username"],
    role: json["role"],
    roomId: json["room_id"],
    room: json["room"] == null ? null : RoomModel.fromJson(json["room"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nis": nis,
    "name": name,
    "class": studentModelClass,
    "username": username,
    "role": role,
    "room_id": roomId,
    "room": room?.toJson(),
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
