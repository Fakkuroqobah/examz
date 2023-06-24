import 'dart:convert';

import 'answer_essay_model.dart';
import 'answer_option_model.dart';

QuestionModel questionModelFromJson(String str) => QuestionModel.fromJson(json.decode(str));

String questionModelToJson(QuestionModel data) => json.encode(data.toJson());

class QuestionModel {
  int id;
  int examId;
  String subject;
  String type;
  int? answer;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<AnswerOptionModel>? answerOption;
  AnswerEssayModel? answerEssay;

  QuestionModel({
    required this.id,
    required this.examId,
    required this.subject,
    required this.type,
    this.answer,
    required this.createdAt,
    required this.updatedAt,
    this.answerOption,
    this.answerEssay,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) => QuestionModel(
    id: json["id"],
    examId: json["exam_id"],
    subject: json["subject"],
    type: json["type"],
    answer: json["answer"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    answerOption: json["answer_option"] == null ? null : List<AnswerOptionModel>.from(json["answer_option"].map((x) => AnswerOptionModel.fromJson(x))),
    answerEssay: json["answer_essay"] == null ? null : AnswerEssayModel.fromJson(json["answer_essay"])
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "exam_id": examId,
    "subject": subject,
    "type": type,
    "answer": answer,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "answer_option": List<dynamic>.from(answerOption!.map((x) => x.toJson())),
    "answerEssay": answerEssay?.toJson()
  };
}