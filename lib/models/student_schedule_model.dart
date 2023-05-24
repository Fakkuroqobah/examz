import 'dart:convert';

import 'student_model.dart';

StudentScheduleModel studentScheduleModelFromJson(String str) => StudentScheduleModel.fromJson(json.decode(str));

String studentScheduleModelToJson(StudentScheduleModel data) => json.encode(data.toJson());

class StudentScheduleModel {
  int id;
  int scheduleId;
  int studentId;
  String? block;
  DateTime? startTime;
  DateTime? endTime;
  StudentModel student;

  StudentScheduleModel({
    required this.id,
    required this.scheduleId,
    required this.studentId,
    required this.block,
    required this.startTime,
    required this.endTime,
    required this.student,
  });

  factory StudentScheduleModel.fromJson(Map<String, dynamic> json) => StudentScheduleModel(
    id: json["id"],
    scheduleId: json["schedule_id"],
    studentId: json["student_id"],
    block: json["block"],
    startTime: json["start_time"] == null ? null : DateTime.parse(json["start_time"]),
    endTime: json["end_time"] == null ? null : DateTime.parse(json["end_time"]),
    student: StudentModel.fromJson(json["student"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "schedule_id": scheduleId,
    "student_id": studentId,
    "block": block,
    "start_time": startTime?.toIso8601String(),
    "end_time": endTime?.toIso8601String(),
    "student": student.toJson(),
  };
}