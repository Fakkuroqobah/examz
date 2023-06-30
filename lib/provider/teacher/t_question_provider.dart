import 'package:flutter/material.dart';

import '../../models/question_model.dart';
import '../../services/teacher/t_question_service.dart';

class TQuestionProvider extends ChangeNotifier {
  List<QuestionModel> _questionList = [];
  bool _isLoading = false;
  bool _hasError = false;
  
  List<QuestionModel> get questionList => _questionList;
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;

  Future<void> getQuestion(int id) async {
    _isLoading = true;
    notifyListeners();

    try {
      TQuestionService tQuestionService = TQuestionService();
      _questionList = await tQuestionService.getQuestion(id);

      _hasError = false;
    } catch (e) {
      _hasError = true;
    }

    _isLoading = false;
    notifyListeners();
  }

  void addQuestion(QuestionModel data) {
    _questionList.add(data);
    notifyListeners();
  }

  void updateQuestion(QuestionModel data) {
    QuestionModel el = QuestionModel(
      id: data.id, 
      examId: data.examId, 
      subject: data.subject, 
      type: data.type, 
      createdAt: data.createdAt, 
      updatedAt: data.updatedAt, 
      answerOption: data.answerOption,
      answerEssay: data.answerEssay,
      score: data.score
    );
    _questionList[_questionList.indexWhere((el) => el.id == data.id)] = el;
    notifyListeners();
  }

  void deleteQuestion(int id) {
    _questionList.removeWhere((el) => el.id == id);
    notifyListeners();
  }
}