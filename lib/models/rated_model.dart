import 'dart:convert';

RatedModel ratedModelFromJson(String str) => RatedModel.fromJson(json.decode(str));

String ratedModelToJson(RatedModel data) => json.encode(data.toJson());

class RatedModel {
  int total;
  List<AnswerStudent> answerStudent;
  List<Question> questions;

  RatedModel({
    required this.total,
    required this.answerStudent,
    required this.questions,
  });

  factory RatedModel.fromJson(Map<String, dynamic> json) => RatedModel(
    total: json["total"],
    answerStudent: List<AnswerStudent>.from(json["answer_student"].map((x) => AnswerStudent.fromJson(x))),
    questions: List<Question>.from(json["questions"].map((x) => Question.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "answer_student": List<dynamic>.from(answerStudent.map((x) => x.toJson())),
    "questions": List<dynamic>.from(questions.map((x) => x.toJson())),
  };
}

class AnswerStudent {
  int id;
  int studentId;
  int questionId;
  int answerOptionId;
  dynamic createdAt;
  dynamic updatedAt;

  AnswerStudent({
    required this.id,
    required this.studentId,
    required this.questionId,
    required this.answerOptionId,
    this.createdAt,
    this.updatedAt,
  });

  factory AnswerStudent.fromJson(Map<String, dynamic> json) => AnswerStudent(
    id: json["id"],
    studentId: json["student_id"],
    questionId: json["question_id"],
    answerOptionId: json["answer_option_id"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "student_id": studentId,
    "question_id": questionId,
    "answer_option_id": answerOptionId,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}

class Question {
  int id;
  int examId;
  String subject;
  DateTime createdAt;
  DateTime updatedAt;
  int answer;
  List<AnswerOption> answerOption;

  Question({
    required this.id,
    required this.examId,
    required this.subject,
    required this.createdAt,
    required this.updatedAt,
    required this.answer,
    required this.answerOption,
  });

  factory Question.fromJson(Map<String, dynamic> json) => Question(
    id: json["id"],
    examId: json["exam_id"],
    subject: json["subject"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    answer: json["answer"],
    answerOption: List<AnswerOption>.from(json["answer_option"].map((x) => AnswerOption.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "exam_id": examId,
    "subject": subject,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "answer": answer,
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
