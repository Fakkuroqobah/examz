import 'package:flutter/material.dart';

import '../../models/teacher/t_question_model.dart';

class TIsCorrectAnswerProvider with ChangeNotifier {
  List<bool> _isChecked = [false, false, false, false, false];

  List<bool> get isChecked => _isChecked;

  void setChecked(int index, bool? value) {
    for(int i = 0; i < _isChecked.length; i++) {
      if(i == index) {
        _isChecked[i] = value ?? false;
      }else{
        _isChecked[i] = false;
      }
    }
    notifyListeners();
  }

  void setFalse() {
    _isChecked = [false, false, false, false, false];
    notifyListeners();
  }

  void setCheckedEdit(List<AnswerOption> value) {
    for(int i = 0; i < value.length; i++) {
      _isChecked[i] = (value[i].correct == 1) ? true : false;
    }
    notifyListeners();
  }
}