import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../configs/api.dart';
import '../../models/room_model.dart';
import '../../models/student_model.dart';
import '../../models/supervisor_model.dart';
import '../../models/teacher_model.dart';

class AEditService {
  final Dio _dio = Dio();
  
  Future<Either<String, TeacherModel>> editTeacher(int id, String txtCode, String txtName, String txtUsername, String txtPassword) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    final data = FormData.fromMap({
      "code": txtCode,
      "name": txtName,
      "username": txtUsername,
      "password": txtPassword,
    });

    try {
      _dio.options.headers['authorization'] = 'Bearer ${preferences.getString("token")}';
      _dio.options.headers['accept'] = 'application/json';
      final response = await _dio.post("${Api.aEditTeacher}/$id", 
        data: data,
      );

      if (response.statusCode == 200) {
        return Right(TeacherModel.fromJson(response.data['data']));
      }

      return const Left('Terjadi kesalahan');
    } on DioError catch (e) {
      if (e.response != null) {
        String errMsg = "";
        int first = 0;
        e.response!.data['errors'].forEach((key, val) {
          if(first == 0) {errMsg += val[0];}
          else {errMsg += val[0] + "\n";}
          first++;
        });

        return Left(errMsg);
      }
      return const Left('Terjadi kesalahan pada server');
    }
  }

  Future<Either<String, StudentModel>> editStudent(int id, String txtNis, String txtName, String txtUsername, String txtClass, String txtPassword) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    final data = FormData.fromMap({
      "nis": txtNis,
      "name": txtName,
      "class": txtClass,
      "username": txtUsername,
      "password": txtPassword,
    });

    try {
      _dio.options.headers['authorization'] = 'Bearer ${preferences.getString("token")}';
      _dio.options.headers['accept'] = 'application/json';
      final response = await _dio.post("${Api.aEditStudent}/$id", 
        data: data,
      );

      if (response.statusCode == 200) {
        return Right(StudentModel.fromJson(response.data['data']));
      }

      return const Left('Terjadi kesalahan');
    } on DioError catch (e) {
      if (e.response != null) {
        String errMsg = "";
        int first = 0;
        e.response!.data['errors'].forEach((key, val) {
          if(first == 0) {errMsg += val[0];}
          else {errMsg += val[0] + "\n";}
          first++;
        });

        return Left(errMsg);
      }
      return const Left('Terjadi kesalahan pada server');
    }
  }

  Future<Either<String, SupervisorModel>> editSupervisor(int id, String txtCode, String txtName, String txtUsername, String txtPassword) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    final data = FormData.fromMap({
      "code": txtCode,
      "name": txtName,
      "username": txtUsername,
      "password": txtPassword,
    });

    try {
      _dio.options.headers['authorization'] = 'Bearer ${preferences.getString("token")}';
      _dio.options.headers['accept'] = 'application/json';
      final response = await _dio.post("${Api.aEditSupervisor}/$id", 
        data: data,
      );

      if (response.statusCode == 200) {
        return Right(SupervisorModel.fromJson(response.data['data']));
      }

      return const Left('Terjadi kesalahan');
    } on DioError catch (e) {
      if (e.response != null) {
        String errMsg = "";
        int first = 0;
        e.response!.data['errors'].forEach((key, val) {
          if(first == 0) {errMsg += val[0];}
          else {errMsg += val[0] + "\n";}
          first++;
        });

        return Left(errMsg);
      }
      return const Left('Terjadi kesalahan pada server');
    }
  }

  Future<Either<String, RoomModel>> editRoom(int id, String txtName) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    final data = FormData.fromMap({
      "name": txtName,
    });

    try {
      _dio.options.headers['authorization'] = 'Bearer ${preferences.getString("token")}';
      _dio.options.headers['accept'] = 'application/json';
      final response = await _dio.post("${Api.aEditRoom}/$id", 
        data: data,
      );

      if (response.statusCode == 200) {
        return Right(RoomModel.fromJson(response.data['data']));
      }

      return const Left('Terjadi kesalahan');
    } on DioError catch (e) {
      if (e.response != null) {
        String errMsg = "";
        int first = 0;
        e.response!.data['errors'].forEach((key, val) {
          if(first == 0) {errMsg += val[0];}
          else {errMsg += val[0] + "\n";}
          first++;
        });

        return Left(errMsg);
      }
      return const Left('Terjadi kesalahan pada server');
    }
  }
}