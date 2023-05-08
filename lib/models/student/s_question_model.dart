import 'dart:convert';

List<SQuestionModel> sQuestionModelFromJson(String str) => List<SQuestionModel>.from(json.decode(str).map((x) => SQuestionModel.fromJson(x)));

String sQuestionModelToJson(List<SQuestionModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SQuestionModel {
  int id;
  int examId;
  String subject;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<AnswerOption> answerOption;

  SQuestionModel({
    required this.id,
    required this.examId,
    required this.subject,
    required this.createdAt,
    required this.updatedAt,
    required this.answerOption,
  });

  factory SQuestionModel.fromJson(Map<String, dynamic> json) => SQuestionModel(
    id: json["id"],
    examId: json["exam_id"],
    subject: json["subject"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    answerOption: List<AnswerOption>.from(json["answer_option"].map((x) => AnswerOption.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "exam_id": examId,
    "subject": subject,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "answer_option": List<dynamic>.from(answerOption.map((x) => x.toJson())),
  };
}

class AnswerOption {
  int id;
  int questionId;
  String subject;
  int correct;

  AnswerOption({
    required this.id,
    required this.questionId,
    required this.subject,
    required this.correct,
  });

  factory AnswerOption.fromJson(Map<String, dynamic> json) => AnswerOption(
    id: json["id"],
    questionId: json["question_id"],
    subject: json["subject"],
    correct: json["correct"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "question_id": questionId,
    "subject": subject,
    "correct": correct,
  };
}