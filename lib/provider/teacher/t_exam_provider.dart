import 'package:flutter/material.dart';

import '../../models/teacher/t_exam_model.dart';
import '../../services/teacher/t_exam_service.dart';

class TExamProvider extends ChangeNotifier {
  TExamModel _examList = TExamModel(examInActive: [], examLaunched: [], examFinished: [], sumExamInActive: 0, sumExamLaunched: 0, sumExamFinished: 0);
  bool _isLoading = false;
  bool _hasError = false;
  
  TExamModel get examList => _examList;
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;

  Future<void> getExamInactive() async {
    _isLoading = true;
    notifyListeners();

    try {
      TExamService tExamService = TExamService();
      _examList = await tExamService.getExam();

      _hasError = false;
    } catch (e) {
      _hasError = true;
    }

    _isLoading = false;
    notifyListeners();
  }

  void addExamInactive(Exam data) {
    _examList.examInActive.add(data);
    _examList.sumExamInActive++;
    notifyListeners();
  }

  void updateExamInactive(Exam data) {
    Exam el = Exam(
      id: data.id, 
      examClass: data.examClass, 
      name: data.name, 
      status: data.status, 
      isRandom: data.isRandom, 
      thumbnail: data.thumbnail, 
      description: data.description, 
      time: data.time,
      createdAt: data.createdAt, 
      updatedAt: data.updatedAt
    );
    _examList.examInActive[_examList.examInActive.indexWhere((el) => el.id == data.id)] = el;
    notifyListeners();
  }

  void deleteExamInactive(int id) {
    _examList.examInActive.removeWhere((el) => el.id == id);
    _examList.sumExamInActive--;
    notifyListeners();
  }
}