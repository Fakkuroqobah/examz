import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../configs/api.dart';
import '../../models/exam_model.dart';

class AExamService {
  final Dio _dio = Dio();

  Future<List<ExamModel>> getExam() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    _dio.options.headers['authorization'] = 'Bearer ${preferences.getString("token")}';
    final response = await _dio.get(Api.aExam);
    
    List<ExamModel> data = <ExamModel>[];
    response.data['data'].forEach((val) {
      data.add(ExamModel.fromJson(val));
    });

    return data;
  }

  Future<Either<String, ExamModel>> triggerExam(int id, String type) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    final data = {
      "id": id,
    };

    try {
      _dio.options.headers['authorization'] = 'Bearer ${preferences.getString("token")}';
      _dio.options.headers['accept'] = 'application/json';
      final response = await _dio.post("${Api.aTrigger}/$type", 
        data: data,
      );

      if (response.statusCode == 200) {
        return Right(ExamModel.fromJson(response.data['data']));
      }

      return const Left('Terjadi kesalahan');
    } on DioError catch (_) {
      return const Left('Terjadi kesalahan pada server');
    }
  }

  Future<Either<String, ExamModel>> triggerRated(int id, int type) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    final data = {
      "id": id,
    };

    try {
      _dio.options.headers['authorization'] = 'Bearer ${preferences.getString("token")}';
      _dio.options.headers['accept'] = 'application/json';
      final response = await _dio.post("${Api.aTriggerRated}/$type", 
        data: data,
      );

      if (response.statusCode == 200) {
        return Right(ExamModel.fromJson(response.data['data']));
      }

      return const Left('Terjadi kesalahan');
    } on DioError catch (_) {
      return const Left('Terjadi kesalahan pada server');
    }
  }
}