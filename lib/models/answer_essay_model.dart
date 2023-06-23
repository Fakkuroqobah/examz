class AnswerEssayModel {
  AnswerEssayModel({
    required this.id,
    required this.questionId,
    required this.defaultAnswer,
  });

  int id;
  int questionId;
  String defaultAnswer;

  factory AnswerEssayModel.fromJson(Map<String, dynamic> json) => AnswerEssayModel(
    id: json["id"],
    questionId: json["question_id"],
    defaultAnswer: json["default_answer"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "question_id": questionId,
    "default_answer": defaultAnswer,
  };
}