class ExamModel {
  int id;
  String examClass;
  String name;
  String status;
  int isRandom;
  String thumbnail;
  String? description;
  int time;
  int isRated;
  int teacherId;
  DateTime? createdAt;
  DateTime? updatedAt;

  ExamModel({
    required this.id,
    required this.examClass,
    required this.name,
    required this.status,
    required this.isRandom,
    required this.thumbnail,
    required this.description,
    required this.time,
    required this.isRated,
    required this.teacherId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ExamModel.fromJson(Map<String, dynamic> json) => ExamModel(
    id: json["id"],
    examClass: json["class"],
    name: json["name"],
    status: json["status"],
    isRandom: json["is_random"],
    thumbnail: json["thumbnail"],
    description: json["description"],
    time: json["time"],
    isRated: json["is_rated"],
    teacherId: json["teacher_id"],
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
    "is_rated": isRated,
    "teacher_id": teacherId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}