class AnswerOptionModel {
  AnswerOptionModel({
    required this.id,
    required this.questionId,
    required this.subject,
    required this.correct,
  });

  int id;
  int questionId;
  String subject;
  int correct;

  factory AnswerOptionModel.fromJson(Map<String, dynamic> json) => AnswerOptionModel(
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