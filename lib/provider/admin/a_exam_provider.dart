import 'package:flutter/material.dart';

import '../../models/admin/a_exam_model.dart';
import '../../services/admin/a_exam_service.dart';

class AExamProvider extends ChangeNotifier {
  List<AExamModel> _examList = [];

  bool _isLoading = false;
  bool _hasError = false;
  
  List<AExamModel> get examList => _examList;

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

  void triggerExam(AExamModel data) {
    AExamModel el = AExamModel(
      id: data.id, 
      aExamModelClass: data.aExamModelClass,
      name: data.name, 
      status: data.status, 
      isRandom: data.isRandom, 
      thumbnail: data.thumbnail, 
      description: data.description, 
      time: data.time,
      createdAt: data.createdAt, 
      updatedAt: data.updatedAt
    );

    _examList[_examList.indexWhere((el) => el.id == data.id)] = el;
    notifyListeners();
  }
}