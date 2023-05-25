import 'dart:convert';

import 'exam_model.dart';

ExamGroupModel examGroupModelFromJson(String str) => ExamGroupModel.fromJson(json.decode(str));

String examGroupModelToJson(ExamGroupModel data) => json.encode(data.toJson());

class ExamGroupModel {
  ExamGroupModel({
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

  factory ExamGroupModel.fromJson(Map<String, dynamic> json) => ExamGroupModel(
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