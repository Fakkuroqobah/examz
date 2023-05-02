import 'dart:convert';

List<AScheduleModel> aScheduleModelFromJson(String str) => List<AScheduleModel>.from(json.decode(str).map((x) => AScheduleModel.fromJson(x)));

String aScheduleModelToJson(List<AScheduleModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AScheduleModel {
  int id;
  int roomId;
  int supervisorId;
  int examId;
  dynamic token;
  DateTime createdAt;
  DateTime updatedAt;

  AScheduleModel({
    required this.id,
    required this.roomId,
    required this.supervisorId,
    required this.examId,
    this.token,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AScheduleModel.fromJson(Map<String, dynamic> json) => AScheduleModel(
    id: json["id"],
    roomId: json["room_id"],
    supervisorId: json["supervisor_id"],
    examId: json["exam_id"],
    token: json["token"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "room_id": roomId,
    "supervisor_id": supervisorId,
    "exam_id": examId,
    "token": token,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}