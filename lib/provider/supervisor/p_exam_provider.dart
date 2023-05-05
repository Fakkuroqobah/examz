import 'package:flutter/material.dart';

import '../../models/supervisor/p_exam_model.dart';
import '../../services/supervisor/p_exam_service.dart';

class PExamProvider extends ChangeNotifier {
  List<PExamModel> _examList = [];

  bool _isLoading = false;
  bool _hasError = false;
  
  List<PExamModel> get examList => _examList;

  bool get isLoading => _isLoading;
  bool get hasError => _hasError;

  Future<void> getExam() async {
    _isLoading = true;
    notifyListeners();

    try {
      PExamService pExamService = PExamService();
      _examList = await pExamService.getExam();

      _hasError = false;
    } catch (e) {
      _hasError = true;
    }

    _isLoading = false;
    notifyListeners();
  }

  void triggerExam(PExamModel data) {
    PExamModel el = PExamModel(
      id: data.id, 
      roomId: data.roomId, 
      supervisorId: data.supervisorId, 
      examId: data.examId, 
      token: data.token,
      createdAt: data.createdAt, 
      updatedAt: data.updatedAt, 
      exam: Exam(
        id: data.exam.id, 
        examClass: data.exam.examClass, 
        name: data.exam.name, 
        status: data.exam.status, 
        isRandom: data.exam.isRandom, 
        thumbnail: data.exam.thumbnail, 
        description: data.exam.description, 
        time: data.exam.time,
        createdAt: data.exam.createdAt, 
        updatedAt: data.exam.updatedAt
      )
    );

    _examList[_examList.indexWhere((el) => el.id == data.id)] = el;
    notifyListeners();
  }
}