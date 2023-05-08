import 'dart:convert';

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
  Room room;
  Supervisor supervisor;
  Exam exam;

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
    room: Room.fromJson(json["room"]),
    supervisor: Supervisor.fromJson(json["supervisor"]),
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
    "room": room.toJson(),
    "supervisor": supervisor.toJson(),
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
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
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

class Room {
  int id;
  String name;
  DateTime? createdAt;
  DateTime? updatedAt;

  Room({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Room.fromJson(Map<String, dynamic> json) => Room(
    id: json["id"],
    name: json["name"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class Supervisor {
  int id;
  String name;
  String username;
  String role;
  DateTime? createdAt;
  DateTime? updatedAt;

  Supervisor({
    required this.id,
    required this.name,
    required this.username,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Supervisor.fromJson(Map<String, dynamic> json) => Supervisor(
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