class AnswerStudentModel {
  int id;
  int studentId;
  int questionId;
  int answerOptionId;
  DateTime? createdAt;
  DateTime? updatedAt;

  AnswerStudentModel({
    required this.id,
    required this.studentId,
    required this.questionId,
    required this.answerOptionId,
    this.createdAt,
    this.updatedAt,
  });

  factory AnswerStudentModel.fromJson(Map<String, dynamic> json) => AnswerStudentModel(
    id: json["id"],
    studentId: json["student_id"],
    questionId: json["question_id"],
    answerOptionId: json["answer_option_id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "student_id": studentId,
    "question_id": questionId,
    "answer_option_id": answerOptionId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}