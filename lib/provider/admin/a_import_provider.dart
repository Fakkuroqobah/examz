import 'package:flutter/material.dart';

import '../../models/room_model.dart';
import '../../models/schedule_model.dart';
import '../../models/student_model.dart';
import '../../models/supervisor_model.dart';
import '../../models/teacher_model.dart';
import '../../services/admin/a_import_service.dart';

class AImportProvider extends ChangeNotifier {
  List<RoomModel> _roomList = [];
  List<TeacherModel> _teacherList = [];
  List<StudentModel> _studentList = [];
  List<SupervisorModel> _supervisorList = [];
  List<ScheduleModel> _scheduleList = [];

  bool _isLoading = false;
  bool _hasError = false;
  
  List<RoomModel> get roomList => _roomList;
  List<TeacherModel> get teacherList => _teacherList;
  List<StudentModel> get studentList => _studentList;
  List<SupervisorModel> get supervisorList => _supervisorList;
  List<ScheduleModel> get scheduleList => _scheduleList;

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

  void addRoom(List<RoomModel> data) {
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

  void addTeacher(List<TeacherModel> data) {
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

  void addStudent(List<StudentModel> data) {
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

  void addSupervisor(List<SupervisorModel> data) {
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

  void addSchedule(List<ScheduleModel> data) {
    _scheduleList.addAll(data);
    notifyListeners();
  }

  // Edit
  void updateTeacher(TeacherModel data) {
    TeacherModel el = TeacherModel(
      id: data.id, 
      code: data.code, 
      name: data.name, 
      username: data.username, 
      role: data.role, 
      createdAt: data.createdAt, 
      updatedAt: data.updatedAt
    );

    _teacherList[_teacherList.indexWhere((el) => el.id == data.id)] = el;
    notifyListeners();
  }

  void updateStudent(StudentModel data) {
    StudentModel el = StudentModel(
      id: data.id, 
      nis: data.nis, 
      name: data.name, 
      studentModelClass: data.studentModelClass, 
      username: data.username, 
      role: data.role, 
      roomId: data.roomId, 
      room: data.room,
      createdAt: data.createdAt, 
      updatedAt: data.updatedAt
    );

    _studentList[_studentList.indexWhere((el) => el.id == data.id)] = el;
    notifyListeners();
  }

  void updateSupervisor(SupervisorModel data) {
    SupervisorModel el = SupervisorModel(
      id: data.id, 
      code: data.code, 
      name: data.name, 
      username: data.username, 
      role: data.role, 
      createdAt: data.createdAt, 
      updatedAt: data.updatedAt
    );

    _supervisorList[_supervisorList.indexWhere((el) => el.id == data.id)] = el;
    notifyListeners();
  }

  void updateRoom(RoomModel data) {
    RoomModel el = RoomModel(
      id: data.id, 
      name: data.name, 
      createdAt: data.createdAt, 
      updatedAt: data.updatedAt
    );

    _roomList[_roomList.indexWhere((el) => el.id == data.id)] = el;
    notifyListeners();
  }

  void deleteTeacher(int id) {
    _teacherList.removeWhere((el) => el.id == id);
    notifyListeners();
  }

  void deleteStudent(int id) {
    _studentList.removeWhere((el) => el.id == id);
    notifyListeners();
  }

  void deleteSupervisor(int id) {
    _supervisorList.removeWhere((el) => el.id == id);
    notifyListeners();
  }

  void deleteRoom(int id) {
    _roomList.removeWhere((el) => el.id == id);
    notifyListeners();
  }

  void deleteSchedule(int id) {
    _scheduleList.removeWhere((el) => el.id == id);
    notifyListeners();
  }
}