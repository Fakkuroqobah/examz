import 'package:flutter/material.dart';

class TIsRandomProvider with ChangeNotifier {
  bool? _isChecked = false;

  bool? get isChecked => _isChecked;

  void setChecked(bool? value) {
    _isChecked = value;
    notifyListeners();
  }
}