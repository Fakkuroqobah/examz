import 'dart:convert';

TExamModel tExamModelFromJson(String str) => TExamModel.fromJson(json.decode(str));

String tExamModelToJson(TExamModel data) => json.encode(data.toJson());

class TExamModel {
  TExamModel({
    required this.examInActive,
    required this.examLaunched,
    required this.examFinished,
    required this.sumExamInActive,
    required this.sumExamLaunched,
    required this.sumExamFinished,
  });

  List<Exam> examInActive;
  List<Exam> examLaunched;
  List<Exam> examFinished;
  int sumExamInActive;
  int sumExamLaunched;
  int sumExamFinished;

  factory TExamModel.fromJson(Map<String, dynamic> json) => TExamModel(
    examInActive: List<Exam>.from(json["examInActive"].map((x) => Exam.fromJson(x))),
    examLaunched: List<Exam>.from(json["examLaunched"].map((x) => Exam.fromJson(x))),
    examFinished: List<Exam>.from(json["examFinished"].map((x) => Exam.fromJson(x))),
    sumExamInActive: json["sumExamInActive"],
    sumExamLaunched: json["sumExamLaunched"],
    sumExamFinished: json["sumExamFinished"],
  );

  Map<String, dynamic> toJson() => {
    "examInActive": List<dynamic>.from(examInActive.map((x) => x.toJson())),
    "examLaunched": List<dynamic>.from(examLaunched.map((x) => x.toJson())),
    "examFinished": List<dynamic>.from(examFinished.map((x) => x.toJson())),
    "sumExamInActive": sumExamInActive,
    "sumExamLaunched": sumExamLaunched,
    "sumExamFinished": sumExamFinished,
  };
}

class Exam {
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

  int id;
  String examClass;
  String name;
  String status;
  int isRandom;
  String thumbnail;
  String? description;
  int? time;
  DateTime createdAt;
  DateTime updatedAt;

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
