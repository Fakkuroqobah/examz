import 'package:flutter/material.dart';

import '../../models/question_model.dart';
import '../../models/schedule_model.dart';
import '../../models/student_schedule_model.dart';
import '../../services/student/s_exam_service.dart';

class SExamProvider extends ChangeNotifier {
  List<ScheduleModel> _examLaunchedList = [];
  List<StudentScheduleModel> _examFinishedList = [];
  
  final List<QuestionModel> _questionList = [];
  final List _questionAnswer = [];
  int _activePage = 0;

  bool _isLoading = false;
  bool _hasError = false;
  
  List<ScheduleModel> get examLaunchedList => _examLaunchedList;
  List<StudentScheduleModel> get examFinishedList => _examFinishedList;
  int get activePage => _activePage;

  List<QuestionModel> get questionList => _questionList;
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

  void token(List<QuestionModel> data) {
    _questionList.clear();
    _questionAnswer.clear();
    _activePage = 0;
    if(_questionList.isEmpty) {
      _questionList.addAll(data);
      notifyListeners();
    }
  }

  void answer(int id, dynamic answer) {
    for (int i = 0; i < _questionAnswer.length; i++) {
      if(_questionAnswer[i][0] == id) {
        _questionAnswer[i][1] = answer;
      }
    }
    notifyListeners();
  }

  dynamic getAnswer(int id, String type) {
    for (int i = 0; i < _questionAnswer.length; i++) {
      if(_questionAnswer[i][0] == id) {
        return _questionAnswer[i][1];
      }
    }

    if(type == 'choice') {
      return 0;
    }else{
      return '';
    }
  }

  void setActivePage(int page) {
    _activePage = page;
    notifyListeners();
  }
}