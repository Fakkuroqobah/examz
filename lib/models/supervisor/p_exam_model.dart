import 'dart:convert';

List<PExamModel> pExamModelFromJson(String str) => List<PExamModel>.from(json.decode(str).map((x) => PExamModel.fromJson(x)));

String pExamModelToJson(List<PExamModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PExamModel {
  int id;
  int roomId;
  int supervisorId;
  int examId;
  String? token;
  DateTime createdAt;
  DateTime updatedAt;
  Exam exam;

  PExamModel({
    required this.id,
    required this.roomId,
    required this.supervisorId,
    required this.examId,
    required this.token,
    required this.createdAt,
    required this.updatedAt,
    required this.exam,
  });

  factory PExamModel.fromJson(Map<String, dynamic> json) => PExamModel(
    id: json["id"],
    roomId: json["room_id"],
    supervisorId: json["supervisor_id"],
    examId: json["exam_id"],
    token: json["token"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    exam: Exam.fromJson(json["exam"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "room_id": roomId,
    "supervisor_id": supervisorId,
    "exam_id": examId,
    "token": token,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
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
  String description;
  int time;
  DateTime createdAt;
  DateTime updatedAt;

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
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
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
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}