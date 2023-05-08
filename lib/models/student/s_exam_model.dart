import 'dart:convert';

SExamModel sExamModelFromJson(String str) => SExamModel.fromJson(json.decode(str));

String sExamModelToJson(SExamModel data) => json.encode(data.toJson());

class SExamModel {
  int id;
  int roomId;
  int studentId;
  String? block;
  DateTime? startTime;
  DateTime? endTime;
  Schedule schedule;

  SExamModel({
    required this.id,
    required this.roomId,
    required this.studentId,
    required this.block,
    required this.startTime,
    required this.endTime,
    required this.schedule,
  });

  factory SExamModel.fromJson(Map<String, dynamic> json) => SExamModel(
    id: json["id"],
    roomId: json["room_id"],
    studentId: json["student_id"],
    block: json["block"],
    startTime: json["start_time"] == null ? null : DateTime.parse(json["start_time"]),
    endTime: json["end_time"] == null ? null : DateTime.parse(json["end_time"]),
    schedule: Schedule.fromJson(json["schedule"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "room_id": roomId,
    "student_id": studentId,
    "block": block,
    "start_time": startTime,
    "end_time": endTime,
    "schedule": schedule.toJson(),
  };
}

class Schedule {
  int id;
  int roomId;
  int supervisorId;
  int examId;
  String? token;
  DateTime? createdAt;
  DateTime? updatedAt;
  Exam exam;

  Schedule({
    required this.id,
    required this.roomId,
    required this.supervisorId,
    required this.examId,
    required this.token,
    required this.createdAt,
    required this.updatedAt,
    required this.exam,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
    id: json["id"],
    roomId: json["room_id"],
    supervisorId: json["supervisor_id"],
    examId: json["exam_id"],
    token: json["token"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    exam: Exam.fromJson(json["exam"]),
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

class Exam {
  int id;
  String examClass;
  String name;
  String status;
  int isRandom;
  String thumbnail;
  String? description;
  int time;
  DateTime? createdAt;
  DateTime? updatedAt;

  Exam({
    required this.id,
    required this.examClass,
    required this.name,
    required this.status,
    required this.isRandom,
    required this.thumbnail,
    required this.description,
    required this.time,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Exam.fromJson(Map<String, dynamic> json) => Exam(
    id: json["id"],
    examClass: json["class"],
    name: json["name"],
    status: json["status"],
    isRandom: json["is_random"],
    thumbnail: json["thumbnail"],
    description: json["description"],
    time: json["time"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "class": examClass,
    "name": name,
    "status": status,
    "is_random": isRandom,
    "thumbnail": thumbnail,
    "description": description,
    "time": time,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}