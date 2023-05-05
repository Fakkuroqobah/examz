import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../configs/api.dart';
import '../../models/supervisor/p_exam_model.dart';

class PExamService {
  final Dio _dio = Dio();

  Future<List<PExamModel>> getExam() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    _dio.options.headers['authorization'] = 'Bearer ${preferences.getString("token")}';
    final response = await _dio.get(Api.pExam);
    
    List<PExamModel> data = <PExamModel>[];
    response.data['data'].forEach((val) {
      data.add(PExamModel.fromJson(val));
    });

    return data;
  }

  Future<Either<String, PExamModel>> triggerExam(int id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    try {
      _dio.options.headers['authorization'] = 'Bearer ${preferences.getString("token")}';
      _dio.options.headers['accept'] = 'application/json';
      final response = await _dio.post("${Api.pStart}/$id");

      if (response.statusCode == 200) {
        return Right(PExamModel.fromJson(response.data['data']));
      }

      return const Left('Terjadi kesalahan');
    } on DioError catch (_) {
      return const Left('Terjadi kesalahan pada server');
    }
  }
}