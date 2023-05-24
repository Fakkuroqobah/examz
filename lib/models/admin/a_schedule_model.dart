import 'dart:convert';

import '../exam_model.dart';
import '../room_model.dart';
import '../supervisor_model.dart';

List<AScheduleModel> aScheduleModelFromJson(String str) => List<AScheduleModel>.from(json.decode(str).map((x) => AScheduleModel.fromJson(x)));

String aScheduleModelToJson(List<AScheduleModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AScheduleModel {
  int id;
  int roomId;
  int supervisorId;
  int examId;
  String? token;
  DateTime? createdAt;
  DateTime? updatedAt;
  RoomModel room;
  SupervisorModel supervisor;
  ExamModel exam;

  AScheduleModel({
    required this.id,
    required this.roomId,
    required this.supervisorId,
    required this.examId,
    required this.token,
    required this.createdAt,
    required this.updatedAt,
    required this.room,
    required this.supervisor,
    required this.exam,
  });

  factory AScheduleModel.fromJson(Map<String, dynamic> json) => AScheduleModel(
    id: json["id"],
    roomId: json["room_id"],
    supervisorId: json["supervisor_id"],
    examId: json["exam_id"],
    token: json["token"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    room: RoomModel.fromJson(json["room"]),
    supervisor: SupervisorModel.fromJson(json["supervisor"]),
    exam: ExamModel.fromJson(json["exam"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "room_id": roomId,
    "supervisor_id": supervisorId,
    "exam_id": examId,
    "token": token,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "room": room.toJson(),
    "supervisor": supervisor.toJson(),
    "exam": exam.toJson(),
  };
}