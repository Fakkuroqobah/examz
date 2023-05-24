import 'dart:convert';

import 'answer_student_model.dart';
import 'question_model.dart';

RatedModel ratedModelFromJson(String str) => RatedModel.fromJson(json.decode(str));

String ratedModelToJson(RatedModel data) => json.encode(data.toJson());

class RatedModel {
  int total;
  List<AnswerStudentModel> answerStudent;
  List<QuestionModel> questions;

  RatedModel({
    required this.total,
    required this.answerStudent,
    required this.questions,
  });

  factory RatedModel.fromJson(Map<String, dynamic> json) => RatedModel(
    total: json["total"],
    answerStudent: List<AnswerStudentModel>.from(json["answer_student"].map((x) => AnswerStudentModel.fromJson(x))),
    questions: List<QuestionModel>.from(json["questions"].map((x) => QuestionModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "answer_student": List<dynamic>.from(answerStudent.map((x) => x.toJson())),
    "questions": List<dynamic>.from(questions.map((x) => x.toJson())),
  };
}