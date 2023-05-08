import 'package:flutter/material.dart';

import '../../models/student/s_exam_model.dart';
import '../../services/student/s_exam_service.dart';

class SExamProvider extends ChangeNotifier {
  List<SExamModel> _examLaunchedList = [];
  List<SExamModel> _examFinishedList = [];

  bool _isLoading = false;
  bool _hasError = false;
  
  List<SExamModel> get examLaunchedList => _examLaunchedList;
  List<SExamModel> get examFinishedList => _examFinishedList;

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
}