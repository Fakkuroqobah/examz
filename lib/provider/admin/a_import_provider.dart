import 'package:flutter/material.dart';

import '../../models/admin/a_room_model.dart';
import '../../models/admin/a_schedule_model.dart';
import '../../models/admin/a_student_model.dart';
import '../../models/admin/a_student_schedule_model.dart';
import '../../models/admin/a_supervisor_model.dart';
import '../../models/admin/a_teacher_model.dart';
import '../../services/admin/a_import_service.dart';

class AImportProvider extends ChangeNotifier {
  List<ARoomModel> _roomList = [];
  List<ATeacherModel> _teacherList = [];
  List<AStudentModel> _studentList = [];
  List<ASupervisorModel> _supervisorList = [];
  List<AScheduleModel> _scheduleList = [];
  List<AStudentScheduleModel> _studentScheduleList = [];

  bool _isLoading = false;
  bool _hasError = false;
  
  List<ARoomModel> get roomList => _roomList;
  List<ATeacherModel> get teacherList => _teacherList;
  List<AStudentModel> get studentList => _studentList;
  List<ASupervisorModel> get supervisorList => _supervisorList;
  List<AScheduleModel> get scheduleList => _scheduleList;
  List<AStudentScheduleModel> get studentScheduleList => _studentScheduleList;

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


  Future<void> getTeacher() async {
    _isLoading = true;
    notifyListeners();

    try {
      AImportService aImportService = AImportService();
      _teacherList = await aImportService.getTeacher();

      _hasError = false;
    } catch (e) {
      _hasError = true;
    }

    _isLoading = false;
    notifyListeners();
  }

  void addTeacher(List<ATeacherModel> data) {
    _teacherList.addAll(data);
    notifyListeners();
  }


  Future<void> getStudent() async {
    _isLoading = true;
    notifyListeners();

    try {
      AImportService aImportService = AImportService();
      _studentList = await aImportService.getStudent();

      _hasError = false;
    } catch (e) {
      _hasError = true;
    }

    _isLoading = false;
    notifyListeners();
  }

  void addStudent(List<AStudentModel> data) {
    _studentList.addAll(data);
    notifyListeners();
  }


  Future<void> getSupervisor() async {
    _isLoading = true;
    notifyListeners();

    try {
      AImportService aImportService = AImportService();
      _supervisorList = await aImportService.getSupervisor();

      _hasError = false;
    } catch (e) {
      _hasError = true;
    }

    _isLoading = false;
    notifyListeners();
  }

  void addSupervisor(List<ASupervisorModel> data) {
    _supervisorList.addAll(data);
    notifyListeners();
  }


  Future<void> getSchedule() async {
    _isLoading = true;
    notifyListeners();

    try {
      AImportService aImportService = AImportService();
      _scheduleList = await aImportService.getSchedule();

      _hasError = false;
    } catch (e) {
      _hasError = true;
    }

    _isLoading = false;
    notifyListeners();
  }

  void addSchedule(List<AScheduleModel> data) {
    _scheduleList.addAll(data);
    notifyListeners();
  }


  Future<void> getStudentSchedule() async {
    _isLoading = true;
    notifyListeners();

    try {
      AImportService aImportService = AImportService();
      _studentScheduleList = await aImportService.getStudentSchedule();

      _hasError = false;
    } catch (e) {
      _hasError = true;
    }

    _isLoading = false;
    notifyListeners();
  }

  void addStudentSchedule(List<AStudentScheduleModel> data) {
    _studentScheduleList.addAll(data);
    notifyListeners();
  }
}