import 'dart:convert';

TExamModel tExamModelFromJson(String str) => TExamModel.fromJson(json.decode(str));

String tExamModelToJson(TExamModel data) => json.encode(data.toJson());

class TExamModel {
  TExamModel({
      required  this.examInActive,
      required  this.examActive,
      required  this.examLaunched,
      required  this.examFinished,
      required  this.sumExamInActive,
      required  this.sumExamActive,
      required  this.sumExamLaunched,
      required  this.sumExamFinished,
  });

  List<Exam> examInActive;
  List<Exam> examActive;
  List<Exam> examLaunched;
  List<Exam> examFinished;
  int sumExamInActive;
  int sumExamActive;
  int sumExamLaunched;
  int sumExamFinished;

  factory TExamModel.fromJson(Map<String, dynamic> json) => TExamModel(
    examInActive: List<Exam>.from(json["examInActive"].map((x) => Exam.fromJson(x))),
    examActive: List<Exam>.from(json["examActive"].map((x) => Exam.fromJson(x))),
    examLaunched: List<Exam>.from(json["examLaunched"].map((x) => Exam.fromJson(x))),
    examFinished: List<Exam>.from(json["examFinished"].map((x) => Exam.fromJson(x))),
    sumExamInActive: json["sumExamInActive"],
    sumExamActive: json["sumExamActive"],
    sumExamLaunched: json["sumExamLaunched"],
    sumExamFinished: json["sumExamFinished"],
  );

  Map<String, dynamic> toJson() => {
    "examInActive": List<dynamic>.from(examInActive.map((x) => x.toJson())),
    "examActive": List<dynamic>.from(examActive.map((x) => x.toJson())),
    "examLaunched": List<dynamic>.from(examLaunched.map((x) => x.toJson())),
    "examFinished": List<dynamic>.from(examFinished.map((x) => x.toJson())),
    "sumExamInActive": sumExamInActive,
    "sumExamActive": sumExamActive,
    "sumExamLaunched": sumExamLaunched,
    "sumExamFinished": sumExamFinished,
  };
}

class Exam {
  Exam({
      required  this.id,
      required  this.examClass,
      required  this.name,
      required  this.starts,
      required  this.due,
      required  this.hours,
      required  this.minutes,
      required  this.isRandom,
      required  this.thumbnail,
      required  this.description,
      required  this.createdAt,
      required  this.updatedAt,
  });

  int id;
  String examClass;
  String name;
  DateTime? starts;
  DateTime? due;
  int? hours;
  int? minutes;
  int isRandom;
  String thumbnail;
  String? description;
  DateTime createdAt;
  DateTime updatedAt;

  factory Exam.fromJson(Map<String, dynamic> json) => Exam(
    id: json["id"],
    examClass: json["class"],
    name: json["name"],
    starts: json["starts"] == null ? null : DateTime.parse(json["starts"]),
    due: json["due"] == null ? null : DateTime.parse(json["due"]),
    hours: json["hours"],
    minutes: json["minutes"],
    isRandom: json["is_random"],
    thumbnail: json["thumbnail"],
    description: json["description"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "class": examClass,
    "name": name,
    "starts": starts == null ? null : starts!.toIso8601String(),
    "due": due == null ? null : due!.toIso8601String(),
    "hours": hours,
    "minutes": minutes,
    "is_random": isRandom,
    "thumbnail": thumbnail,
    "description": description,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
