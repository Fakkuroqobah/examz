import 'dart:convert';

import '../room_model.dart';

List<AStudentScheduleModel> aStudentScheduleModelFromJson(String str) => List<AStudentScheduleModel>.from(json.decode(str).map((x) => AStudentScheduleModel.fromJson(x)));

String aStudentScheduleModelToJson(List<AStudentScheduleModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AStudentScheduleModel {
  int id;
  int roomId;
  int studentId;
  int status;
  int block;
  DateTime? startTime;
  DateTime? endTime;
  RoomModel room;
  Student student;

  AStudentScheduleModel({
    required this.id,
    required this.roomId,
    required this.studentId,
    required this.status,
    required this.block,
    required this.startTime,
    required this.endTime,
    required this.room,
    required this.student,
  });

  factory AStudentScheduleModel.fromJson(Map<String, dynamic> json) => AStudentScheduleModel(
    id: json["id"],
    roomId: json["room_id"],
    studentId: json["student_id"],
    status: json["status"],
    block: json["block"],
    startTime: json["start_time"] == null ? null : DateTime.parse(json["start_time"]),
    endTime: json["end_time"] == null ? null : DateTime.parse(json["end_time"]),
    room: RoomModel.fromJson(json["room"]),
    student: Student.fromJson(json["student"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "room_id": roomId,
    "student_id": studentId,
    "status": status,
    "block": block,
    "start_time": startTime?.toIso8601String(),
    "end_time": endTime?.toIso8601String(),
    "room": room.toJson(),
    "student": student.toJson(),
  };
}

class Student {
  int id;
  String name;
  String studentClass;
  String username;
  String role;
  DateTime? createdAt;
  DateTime? updatedAt;

  Student({
    required this.id,
    required this.name,
    required this.studentClass,
    required this.username,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Student.fromJson(Map<String, dynamic> json) => Student(
    id: json["id"],
    name: json["name"],
    studentClass: json["class"],
    username: json["username"],
    role: json["role"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "class": studentClass,
    "username": username,
    "role": role,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
