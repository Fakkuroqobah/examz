import 'package:flutter/material.dart';

import '../../models/admin/a_room_model.dart';
import '../../services/admin/a_import_service.dart';

class AImportProvider extends ChangeNotifier {
  List<ARoomModel> _roomList = [];
  bool _isLoading = false;
  bool _hasError = false;
  
  List<ARoomModel> get roomList => _roomList;
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;

  Future<void> getRoom() async {
    _isLoading = true;
    notifyListeners();

    try {
      AImportService aImportService = AImportService();
      _roomList = await aImportService.getRoom();

      _hasError = false;
    } catch (e) {
      _hasError = true;
    }

    _isLoading = false;
    notifyListeners();
  }

  void addRoom(List<ARoomModel> data) {
    _roomList.addAll(data);
    notifyListeners();
  }
}