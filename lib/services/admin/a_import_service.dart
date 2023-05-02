import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../configs/api.dart';
import '../../models/admin/a_room_model.dart';


class AImportService {
  final Dio _dio = Dio();
  
  Future<List<ARoomModel>> getTeacher() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    _dio.options.headers['authorization'] = 'Bearer ${preferences.getString("token")}';
    final response = await _dio.get(Api.aRooms);
    
    List<ARoomModel> data = <ARoomModel>[];
    response.data['data'].forEach((val) {
      data.add(ARoomModel.fromJson(val));
    });

    return data;
  }

  Future<List<ARoomModel>> getRoom() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    _dio.options.headers['authorization'] = 'Bearer ${preferences.getString("token")}';
    final response = await _dio.get(Api.aRooms);
    
    List<ARoomModel> data = <ARoomModel>[];
    response.data['data'].forEach((val) {
      data.add(ARoomModel.fromJson(val));
    });

    return data;
  }

  Future<Either<String, List<ARoomModel>>> roomsImport(File excel) async {
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
        List<ARoomModel> data = <ARoomModel>[];
        response.data['data'].forEach((val) {
          data.add(ARoomModel.fromJson(val));
        });
        return Right(data);
      }

      return const Left('Terjadi kesalahan');
    } on DioError catch (_) {
      return const Left('Terjadi kesalahan pada server');
    }
  }
}