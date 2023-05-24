import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../configs/api.dart';
import '../../models/admin/a_schedule_model.dart';
import '../../models/admin/a_student_model.dart';
import '../../models/admin/a_student_schedule_model.dart';
import '../../models/admin/a_supervisor_model.dart';
import '../../models/admin/a_teacher_model.dart';
import '../../models/room_model.dart';


class AImportService {
  final Dio _dio = Dio();
  
  Future<List<ATeacherModel>> getTeacher() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    _dio.options.headers['authorization'] = 'Bearer ${preferences.getString("token")}';
    final response = await _dio.get(Api.aTeachers);
    
    List<ATeacherModel> data = <ATeacherModel>[];
    response.data['data'].forEach((val) {
      data.add(ATeacherModel.fromJson(val));
    });

    return data;
  }
  
  Future<List<AStudentModel>> getStudent() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    _dio.options.headers['authorization'] = 'Bearer ${preferences.getString("token")}';
    final response = await _dio.get(Api.aStudents);
    
    List<AStudentModel> data = <AStudentModel>[];
    response.data['data'].forEach((val) {
      data.add(AStudentModel.fromJson(val));
    });

    return data;
  }

  Future<List<ASupervisorModel>> getSupervisor() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    _dio.options.headers['authorization'] = 'Bearer ${preferences.getString("token")}';
    final response = await _dio.get(Api.aSupervisors);
    
    List<ASupervisorModel> data = <ASupervisorModel>[];
    response.data['data'].forEach((val) {
      data.add(ASupervisorModel.fromJson(val));
    });

    return data;
  }

  Future<List<RoomModel>> getRoom() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    _dio.options.headers['authorization'] = 'Bearer ${preferences.getString("token")}';
    final response = await _dio.get(Api.aRooms);
    
    List<RoomModel> data = <RoomModel>[];
    response.data['data'].forEach((val) {
      data.add(RoomModel.fromJson(val));
    });

    return data;
  }

  Future<List<AScheduleModel>> getSchedule() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    _dio.options.headers['authorization'] = 'Bearer ${preferences.getString("token")}';
    final response = await _dio.get(Api.aSchedules);
    
    List<AScheduleModel> data = <AScheduleModel>[];
    response.data['data'].forEach((val) {
      data.add(AScheduleModel.fromJson(val));
    });

    return data;
  }

  Future<List<AStudentScheduleModel>> getStudentSchedule() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    _dio.options.headers['authorization'] = 'Bearer ${preferences.getString("token")}';
    final response = await _dio.get(Api.aStudentSchedule);
    
    List<AStudentScheduleModel> data = <AStudentScheduleModel>[];
    response.data['data'].forEach((val) {
      data.add(AStudentScheduleModel.fromJson(val));
    });

    return data;
  }

  Future<Either<String, List<RoomModel>>> roomsImport(File excel) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    
    FormData data = FormData.fromMap({
      "excel": await MultipartFile.fromFile(excel.path, filename: "file.xlsx"),
    });

    try {
      _dio.options.headers['authorization'] = 'Bearer ${preferences.getString("token")}';
      final response = await _dio.post(Api.aRoomsImport, 
        data: data,
      );

      if (response.statusCode == 201) {
        List<RoomModel> data = <RoomModel>[];
        response.data['data'].forEach((val) {
          data.add(RoomModel.fromJson(val));
        });
        return Right(data);
      }

      return const Left('Terjadi kesalahan');
    } on DioError catch (_) {
      return const Left('Terjadi kesalahan pada server');
    }
  }

  Future<Either<String, List<ATeacherModel>>> teachersImport(File excel) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    
    FormData data = FormData.fromMap({
      "excel": await MultipartFile.fromFile(excel.path, filename: "file.xlsx"),
    });

    try {
      _dio.options.headers['authorization'] = 'Bearer ${preferences.getString("token")}';
      final response = await _dio.post(Api.aTeachersImport, 
        data: data,
      );

      if (response.statusCode == 201) {
        List<ATeacherModel> data = <ATeacherModel>[];
        response.data['data'].forEach((val) {
          data.add(ATeacherModel.fromJson(val));
        });
        return Right(data);
      }

      return const Left('Terjadi kesalahan');
    } on DioError catch (_) {
      return const Left('Terjadi kesalahan pada server');
    }
  }
  
  Future<Either<String, List<AStudentModel>>> studentsImport(File excel) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    
    FormData data = FormData.fromMap({
      "excel": await MultipartFile.fromFile(excel.path, filename: "file.xlsx"),
    });

    try {
      _dio.options.headers['authorization'] = 'Bearer ${preferences.getString("token")}';
      final response = await _dio.post(Api.aStudentsImport, 
        data: data,
      );

      if (response.statusCode == 201) {
        List<AStudentModel> data = <AStudentModel>[];
        response.data['data'].forEach((val) {
          data.add(AStudentModel.fromJson(val));
        });
        return Right(data);
      }

      return const Left('Terjadi kesalahan');
    } on DioError catch (_) {
      return const Left('Terjadi kesalahan pada server');
    }
  }

  Future<Either<String, List<ASupervisorModel>>> supervisorsImport(File excel) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    
    FormData data = FormData.fromMap({
      "excel": await MultipartFile.fromFile(excel.path, filename: "file.xlsx"),
    });

    try {
      _dio.options.headers['authorization'] = 'Bearer ${preferences.getString("token")}';
      final response = await _dio.post(Api.aSupervisorsImport, 
        data: data,
      );

      if (response.statusCode == 201) {
        List<ASupervisorModel> data = <ASupervisorModel>[];
        response.data['data'].forEach((val) {
          data.add(ASupervisorModel.fromJson(val));
        });
        return Right(data);
      }

      return const Left('Terjadi kesalahan');
    } on DioError catch (_) {
      return const Left('Terjadi kesalahan pada server');
    }
  }

  Future<Either<String, List<AScheduleModel>>> schedulesImport(File excel) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    
    FormData data = FormData.fromMap({
      "excel": await MultipartFile.fromFile(excel.path, filename: "file.xlsx"),
    });

    try {
      _dio.options.headers['authorization'] = 'Bearer ${preferences.getString("token")}';
      final response = await _dio.post(Api.aSchedulesImport, 
        data: data,
      );

      if (response.statusCode == 201) {
        List<AScheduleModel> data = <AScheduleModel>[];
        response.data['data'].forEach((val) {
          data.add(AScheduleModel.fromJson(val));
        });
        return Right(data);
      }

      return const Left('Terjadi kesalahan');
    } on DioError catch (_) {
      return const Left('Terjadi kesalahan pada server');
    }
  }

  Future<Either<String, List<AStudentScheduleModel>>> studentScheduleImport(File excel) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    
    FormData data = FormData.fromMap({
      "excel": await MultipartFile.fromFile(excel.path, filename: "file.xlsx"),
    });

    try {
      _dio.options.headers['authorization'] = 'Bearer ${preferences.getString("token")}';
      final response = await _dio.post(Api.aStudentScheduleImport, 
        data: data,
      );

      if (response.statusCode == 201) {
        List<AStudentScheduleModel> data = <AStudentScheduleModel>[];
        response.data['data'].forEach((val) {
          data.add(AStudentScheduleModel.fromJson(val));
        });
        return Right(data);
      }

      return const Left('Terjadi kesalahan');
    } on DioError catch (_) {
      return const Left('Terjadi kesalahan pada server');
    }
  }
}