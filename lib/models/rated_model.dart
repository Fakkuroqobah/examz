import 'dart:convert';

import 'answer_student_model.dart';
import 'question_model.dart';

RatedModel ratedModelFromJson(String str) => RatedModel.fromJson(json.decode(str));

String ratedModelToJson(RatedModel data) => json.encode(data.toJson());

class RatedModel {
  int scoreChoice;
  int scoreEssai;
  List<AnswerStudentModel> answerStudent;
  List<QuestionModel> questions;

  RatedModel({
    required this.scoreChoice,
    required this.scoreEssai,
    required this.answerStudent,
    required this.questions,
  });

  factory RatedModel.fromJson(Map<String, dynamic> json) => RatedModel(
    scoreChoice: json["score_choice"],
    scoreEssai: json["score_essai"],
    answerStudent: List<AnswerStudentModel>.from(json["answer_student"].map((x) => AnswerStudentModel.fromJson(x))),
    questions: List<QuestionModel>.from(json["questions"].map((x) => QuestionModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "score_choice": scoreChoice,
    "score_essai": scoreEssai,
    "answer_student": List<dynamic>.from(answerStudent.map((x) => x.toJson())),
    "questions": List<dynamic>.from(questions.map((x) => x.toJson())),
  };
}