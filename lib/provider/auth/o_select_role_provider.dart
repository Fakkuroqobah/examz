import 'package:flutter/material.dart';

class OSelectRoleProvider with ChangeNotifier {
  String _selectedItem = 'Student';
  final List<String> _items = ['Student', 'Admin', 'Teacher', 'Supervisor'];

  String get selectedItem => _selectedItem;
  List<String> get items => _items;

  void setSelectedItem(String item) {
    _selectedItem = item;
    notifyListeners();
  }
}