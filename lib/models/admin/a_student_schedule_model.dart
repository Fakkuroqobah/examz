import 'dart:convert';

List<AStudentScheduleModel> aStudentScheduleModelFromJson(String str) => List<AStudentScheduleModel>.from(json.decode(str).map((x) => AStudentScheduleModel.fromJson(x)));

String aStudentScheduleModelToJson(List<AStudentScheduleModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AStudentScheduleModel {
  int id;
  int scheduleId;
  int studentId;
  int status;
  int block;
  dynamic startTime;
  dynamic endTime;

  AStudentScheduleModel({
    required this.id,
    required this.scheduleId,
    required this.studentId,
    required this.status,
    required this.block,
    this.startTime,
    this.endTime,
  });

  factory AStudentScheduleModel.fromJson(Map<String, dynamic> json) => AStudentScheduleModel(
    id: json["id"],
    scheduleId: json["schedule_id"],
    studentId: json["student_id"],
    status: json["status"],
    block: json["block"],
    startTime: json["start_time"],
    endTime: json["end_time"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "schedule_id": scheduleId,
    "student_id": studentId,
    "status": status,
    "block": block,
    "start_time": startTime,
    "end_time": endTime,
  };
}