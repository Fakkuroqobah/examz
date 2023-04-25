import 'package:flutter/material.dart';

class TThumbnailProvider with ChangeNotifier {
  Map<String, dynamic> _thumbnail = {};

  Map<String, dynamic> get thumbnails => _thumbnail;

  void setItem(Map<String, dynamic> item) {
    _thumbnail = item;
    notifyListeners();
  }
}