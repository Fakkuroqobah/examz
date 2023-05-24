import 'dart:convert';

import '../exam_model.dart';

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

  List<ExamModel> examInActive;
  List<ExamModel> examLaunched;
  List<ExamModel> examFinished;
  int sumExamInActive;
  int sumExamLaunched;
  int sumExamFinished;

  factory TExamModel.fromJson(Map<String, dynamic> json) => TExamModel(
    examInActive: List<ExamModel>.from(json["examInActive"].map((x) => ExamModel.fromJson(x))),
    examLaunched: List<ExamModel>.from(json["examLaunched"].map((x) => ExamModel.fromJson(x))),
    examFinished: List<ExamModel>.from(json["examFinished"].map((x) => ExamModel.fromJson(x))),
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