import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_html/html.dart' as html;
import 'package:flutter/foundation.dart' show kIsWeb;

import '../../configs/api.dart';
import '../../configs/utils.dart';
import '../../models/room_model.dart';
import '../../models/schedule_model.dart';
import '../../models/student_model.dart';
import '../../models/supervisor_model.dart';
import '../../models/teacher_model.dart';

class AImportService {
  final Dio _dio = Dio();
  final Utils _utils = Utils();

  AImportService() {
    _utils.interceptor(_dio, 'admin');
  }
  
  Future<List<TeacherModel>> getTeacher() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    _dio.options.headers['authorization'] = 'Bearer ${preferences.getString("token")}';
    final response = await _dio.get(Api.aTeachers);
    
    List<TeacherModel> data = <TeacherModel>[];
    response.data['data'].forEach((val) {
      data.add(TeacherModel.fromJson(val));
    });

    return data;
  }
  
  Future<List<StudentModel>> getStudent() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    _dio.options.headers['authorization'] = 'Bearer ${preferences.getString("token")}';
    final response = await _dio.get(Api.aStudents);
    
    List<StudentModel> data = <StudentModel>[];
    response.data['data'].forEach((val) {
      data.add(StudentModel.fromJson(val));
    });

    return data;
  }

  Future<List<SupervisorModel>> getSupervisor() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    _dio.options.headers['authorization'] = 'Bearer ${preferences.getString("token")}';
    final response = await _dio.get(Api.aSupervisors);
    
    List<SupervisorModel> data = <SupervisorModel>[];
    response.data['data'].forEach((val) {
      data.add(SupervisorModel.fromJson(val));
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

  Future<List<ScheduleModel>> getSchedule() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    _dio.options.headers['authorization'] = 'Bearer ${preferences.getString("token")}';
    final response = await _dio.get(Api.aSchedules);
    
    List<ScheduleModel> data = <ScheduleModel>[];
    response.data['data'].forEach((val) {
      data.add(ScheduleModel.fromJson(val));
    });

    return data;
  }

  Future<Either<String, List<RoomModel>>> roomsImport(Uint8List excel) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    
    FormData data = FormData.fromMap({
      "excel": MultipartFile.fromBytes(excel, filename: "file.xlsx"),
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

  Future<Either<String, List<TeacherModel>>> teachersImport(Uint8List excel) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    
    FormData data = FormData.fromMap({
      "excel": MultipartFile.fromBytes(excel, filename: "file.xlsx"),
    });

    try {
      _dio.options.headers['authorization'] = 'Bearer ${preferences.getString("token")}';
      final response = await _dio.post(Api.aTeachersImport, 
        data: data,
      );

      if (response.statusCode == 201) {
        List<TeacherModel> data = <TeacherModel>[];
        response.data['data'].forEach((val) {
          data.add(TeacherModel.fromJson(val));
        });
        return Right(data);
      }

      return const Left('Terjadi kesalahan');
    } on DioError catch (_) {
      return const Left('Terjadi kesalahan pada server');
    }
  }
  
  Future<Either<String, List<StudentModel>>> studentsImport(Uint8List excel) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    
    FormData data = FormData.fromMap({
      "excel": MultipartFile.fromBytes(excel, filename: "file.xlsx"),
    });

    try {
      _dio.options.headers['authorization'] = 'Bearer ${preferences.getString("token")}';
      final response = await _dio.post(Api.aStudentsImport, 
        data: data,
      );

      if (response.statusCode == 201) {
        List<StudentModel> data = <StudentModel>[];
        response.data['data'].forEach((val) {
          data.add(StudentModel.fromJson(val));
        });
        return Right(data);
      }

      return const Left('Terjadi kesalahan');
    } on DioError catch (e) {
      if(e.response != null) {
        if(e.response!.statusCode == 404) {
          return const Left('Terdapat nama ruangan yang salah');
        }
      }
      return const Left('Terjadi kesalahan pada server');
    }
  }

  Future<Either<String, List<SupervisorModel>>> supervisorsImport(Uint8List excel) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    
    FormData data = FormData.fromMap({
      "excel": MultipartFile.fromBytes(excel, filename: "file.xlsx"),
    });

    try {
      _dio.options.headers['authorization'] = 'Bearer ${preferences.getString("token")}';
      final response = await _dio.post(Api.aSupervisorsImport, 
        data: data,
      );

      if (response.statusCode == 201) {
        List<SupervisorModel> data = <SupervisorModel>[];
        response.data['data'].forEach((val) {
          data.add(SupervisorModel.fromJson(val));
        });
        return Right(data);
      }

      return const Left('Terjadi kesalahan');
    } on DioError catch (_) {
      return const Left('Terjadi kesalahan pada server');
    }
  }

  Future<Either<String, List<ScheduleModel>>> schedulesImport(Uint8List excel) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    
    FormData data = FormData.fromMap({
      "excel": MultipartFile.fromBytes(excel, filename: "file.xlsx"),
    });

    try {
      _dio.options.headers['authorization'] = 'Bearer ${preferences.getString("token")}';
      final response = await _dio.post(Api.aSchedulesImport, 
        data: data,
      );

      if (response.statusCode == 201) {
        List<ScheduleModel> data = <ScheduleModel>[];
        response.data['data'].forEach((val) {
          data.add(ScheduleModel.fromJson(val));
        });
        return Right(data);
      }

      return const Left('Terjadi kesalahan');
    } on DioError catch (e) {
      if(e.response != null) {
        if(e.response!.statusCode == 404) {
          return const Left('Terdapat data yang salah');
        }
      }
      return const Left('Terjadi kesalahan pada server');
    }
  }

  Future<Either<String, String>> downloadFormat(String type) async {
    try {
      if (kIsWeb) {
        html.AnchorElement(href: "${Api.baseUrl}/import/$type.xlsx")
            ..setAttribute('download', '$type.xlsx')
            ..click();

        return const Right("Download format import berhasil");
      } else {
        return const Right("Download hanya tersedia pada web");
      }
    } catch (e) {
      return const Left('Terjadi kesalahan pada server');
    }
  }
}