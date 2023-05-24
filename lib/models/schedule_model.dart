import 'dart:convert';

import 'exam_model.dart';

List<ScheduleModel> scheduleModelFromJson(String str) => List<ScheduleModel>.from(json.decode(str).map((x) => ScheduleModel.fromJson(x)));

String scheduleModelToJson(List<ScheduleModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ScheduleModel {
  int id;
  int roomId;
  int supervisorId;
  int examId;
  String? token;
  DateTime? createdAt;
  DateTime? updatedAt;
  ExamModel exam;

  ScheduleModel({
    required this.id,
    required this.roomId,
    required this.supervisorId,
    required this.examId,
    required this.token,
    required this.createdAt,
    required this.updatedAt,
    required this.exam,
  });

  factory ScheduleModel.fromJson(Map<String, dynamic> json) => ScheduleModel(
    id: json["id"],
    roomId: json["room_id"],
    supervisorId: json["supervisor_id"],
    examId: json["exam_id"],
    token: json["token"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
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
    "exam": exam.toJson(),
  };
}