import 'package:flutter/material.dart';

class TSelectClassProvider with ChangeNotifier {
  String _selectedItem = '1';
  final List<List<String>> _items = [['1', 'Kelas 1'], ['2', 'Kelas 2'], ['3', 'Kelas 3']];

  String get selectedItem => _selectedItem;
  List<List<String>> get items => _items;

  void setSelectedItem(String item) {
    _selectedItem = item;
    notifyListeners();
  }
}