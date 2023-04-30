import 'dart:convert';

TQuestionModel tQuestionModelFromJson(String str) => TQuestionModel.fromJson(json.decode(str));

String tQuestionModelToJson(TQuestionModel data) => json.encode(data.toJson());

class TQuestionModel {
  TQuestionModel({
    required this.id,
    required this.examId,
    required this.subject,
    required this.createdAt,
    required this.updatedAt,
    required this.answerOption,
  });

  int id;
  int examId;
  String subject;
  DateTime createdAt;
  DateTime updatedAt;
  List<AnswerOption> answerOption;

  factory TQuestionModel.fromJson(Map<String, dynamic> json) => TQuestionModel(
    id: json["id"],
    examId: json["exam_id"],
    subject: json["subject"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    answerOption: List<AnswerOption>.from(json["answer_option"].map((x) => AnswerOption.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "exam_id": examId,
    "subject": subject,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "answer_option": List<dynamic>.from(answerOption.map((x) => x.toJson())),
  };
}

class AnswerOption {
  AnswerOption({
    required this.id,
    required this.questionId,
    required this.subject,
    this.correct,
  });

  int id;
  int questionId;
  String subject;
  String? correct;

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
