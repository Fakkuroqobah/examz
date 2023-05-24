import 'package:flutter/material.dart';

import '../../models/exam_model.dart';
import '../../services/admin/a_exam_service.dart';

class AExamProvider extends ChangeNotifier {
  List<ExamModel> _examList = [];

  bool _isLoading = false;
  bool _hasError = false;
  
  List<ExamModel> get examList => _examList;

  bool get isLoading => _isLoading;
  bool get hasError => _hasError;

  Future<void> getExam() async {
    _isLoading = true;
    notifyListeners();

    try {
      AExamService aExamService = AExamService();
      _examList = await aExamService.getExam();

      _hasError = false;
    } catch (e) {
      _hasError = true;
    }

    _isLoading = false;
    notifyListeners();
  }

  void triggerExam(ExamModel data) {
    ExamModel el = ExamModel(
      id: data.id, 
      examClass: data.examClass,
      name: data.name, 
      status: data.status, 
      isRandom: data.isRandom, 
      thumbnail: data.thumbnail, 
      description: data.description, 
      time: data.time,
      isRated: data.isRated,
      teacherId: data.teacherId,
      createdAt: data.createdAt, 
      updatedAt: data.updatedAt
    );

    _examList[_examList.indexWhere((el) => el.id == data.id)] = el;
    notifyListeners();
  }
}