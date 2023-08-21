import 'package:flutter/material.dart';

import '../../models/rated_model.dart';
import '../../services/teacher/t_rated_service.dart';

class TRatedProvider extends ChangeNotifier {
  RatedModel _ratedModel = RatedModel(scoreChoice: 0, scoreEssai: 0, answerStudent: [], questions: []);
  bool _isLoading = false;
  bool _hasError = false;
  
  RatedModel get ratedModel => _ratedModel;
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;

  Future<void> getRated(int studentId, int examId) async {
    _isLoading = true;
    notifyListeners();

    try {
      TRatedService tRatedService = TRatedService();
      _ratedModel = await tRatedService.getRated(studentId, examId);

      _hasError = false;
    } catch (_) {
      _hasError = true;
    }

    _isLoading = false;
    notifyListeners();
  }

  void updateRated(RatedModel data) {
    RatedModel el = RatedModel(
      scoreChoice: data.scoreChoice,
      scoreEssai: data.scoreEssai,
      answerStudent: data.answerStudent,
      questions: data.questions
    );
    _ratedModel = el;
    notifyListeners();
  }
}