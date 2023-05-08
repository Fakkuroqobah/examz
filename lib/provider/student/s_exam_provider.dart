import 'package:flutter/material.dart';

import '../../models/student/s_exam_model.dart';
import '../../models/student/s_question_model.dart';
import '../../services/student/s_exam_service.dart';

class SExamProvider extends ChangeNotifier {
  List<SExamModel> _examLaunchedList = [];
  List<SExamModel> _examFinishedList = [];
  
  final List<SQuestionModel> _questionList = [];
  final List _questionAnswer = [];
  int _activePage = 0;

  bool _isLoading = false;
  bool _hasError = false;
  
  List<SExamModel> get examLaunchedList => _examLaunchedList;
  List<SExamModel> get examFinishedList => _examFinishedList;
  int get activePage => _activePage;

  List<SQuestionModel> get questionList => _questionList;
  List get questionAnswer => _questionAnswer;

  bool get isLoading => _isLoading;
  bool get hasError => _hasError;

  Future<void> getExamLaunched() async {
    _isLoading = true;
    notifyListeners();

    try {
      SExamService sExamService = SExamService();
      _examLaunchedList = await sExamService.getExamLaunched();

      _hasError = false;
    } catch (e) {
      _hasError = true;
    }

    _isLoading = false;
    notifyListeners();
  }
  
  Future<void> getExamFinished() async {
    _isLoading = true;
    notifyListeners();

    try {
      SExamService sExamService = SExamService();
      _examFinishedList = await sExamService.getExamFinished();

      _hasError = false;
    } catch (e) {
      _hasError = true;
    }

    _isLoading = false;
    notifyListeners();
  }

  void token(List<SQuestionModel> data) {
    _questionList.addAll(data);
    notifyListeners();
  }

  void answer(int id, int answer) {
    for (int i = 0; i < _questionAnswer.length; i++) {
      if(_questionAnswer[i][0] == id) {
        _questionAnswer[i][1] = answer;
      }
    }
    notifyListeners();
  }

  int answerChecked(int id) {
    for (int i = 0; i < _questionAnswer.length; i++) {
      if(_questionAnswer[i][0] == id) {
        return _questionAnswer[i][1];
      }
    }

    return 0;
  }

  void setActivePage(int page) {
    _activePage = page;
    notifyListeners();
  }
}