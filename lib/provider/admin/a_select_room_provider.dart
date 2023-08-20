import 'package:flutter/material.dart';

import '../../models/room_model.dart';
import '../../services/admin/a_import_service.dart';

class ASelectRoomProvider with ChangeNotifier {
  String _selectedItem = '1';
  final List<List<String>> _items = [];

  bool _isLoading = false;
  bool _hasError = false;

  String get selectedItem => _selectedItem;
  List<List<String>> get items => _items;

  bool get isLoading => _isLoading;
  bool get hasError => _hasError;

  Future<void> setItems() async {
    _isLoading = true;
    notifyListeners();

    try {
      AImportService aImportService = AImportService();
      List<RoomModel> roomModel = await aImportService.getRoom();

      _items.clear();
      for (var value in roomModel) {
        _items.add([value.id.toString(), value.name]);
      }

      _hasError = false;
    } catch (e) {
      _hasError = true;
    }

    _isLoading = false;
    notifyListeners();
  }

  void setSelectedItem(String item) {
    _selectedItem = item;
    notifyListeners();
  }
}