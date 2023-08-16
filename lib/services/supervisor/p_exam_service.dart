import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../configs/api.dart';
import '../../configs/utils.dart';
import '../../models/schedule_model.dart';

class PExamService {
  final Dio _dio = Dio();
  final Utils _utils = Utils();

  PExamService() {
    _utils.interceptor(_dio, 'supervisor');
  }

  Future<List<ScheduleModel>> getExam() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    _dio.options.headers['authorization'] = 'Bearer ${preferences.getString("token")}';
    final response = await _dio.get(Api.pExam);
    
    List<ScheduleModel> data = <ScheduleModel>[];
    response.data['data'].forEach((val) {
      data.add(ScheduleModel.fromJson(val));
    });

    return data;
  }

  Future<Either<String, ScheduleModel>> triggerExam(int id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    try {
      _dio.options.headers['authorization'] = 'Bearer ${preferences.getString("token")}';
      _dio.options.headers['accept'] = 'application/json';
      final response = await _dio.post("${Api.pStart}/$id");

      if (response.statusCode == 200) {
        return Right(ScheduleModel.fromJson(response.data['data']));
      }

      return const Left('Terjadi kesalahan');
    } on DioError catch (_) {
      return const Left('Terjadi kesalahan pada server');
    }
  }
}