import 'package:flutter/material.dart';

import '../../models/teacher/t_question_model.dart';
import '../../services/teacher/t_question_service.dart';

class TQuestionProvider extends ChangeNotifier {
  List<TQuestionModel> _questionList = [];
  bool _isLoading = false;
  bool _hasError = false;
  
  List<TQuestionModel> get questionList => _questionList;
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

  void addQuestion(TQuestionModel data) {
    _questionList.add(data);
    notifyListeners();
  }

  void updateQuestion(TQuestionModel data) {
    TQuestionModel el = TQuestionModel(
      id: data.id, 
      examId: data.examId, 
      subject: data.subject, 
      createdAt: data.createdAt, 
      updatedAt: data.updatedAt, 
      answerOption: data.answerOption
    );
    _questionList[_questionList.indexWhere((el) => el.id == data.id)] = el;
    notifyListeners();
  }

  void deleteQuestion(int id) {
    _questionList.removeWhere((el) => el.id == id);
    notifyListeners();
  }
}