import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../configs/api.dart';
import '../../models/admin/a_exam_model.dart';

class AExamService {
  final Dio _dio = Dio();

  Future<List<AExamModel>> getExam() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    _dio.options.headers['authorization'] = 'Bearer ${preferences.getString("token")}';
    final response = await _dio.get(Api.aExam);
    
    List<AExamModel> data = <AExamModel>[];
    response.data['data'].forEach((val) {
      data.add(AExamModel.fromJson(val));
    });

    return data;
  }

  Future<Either<String, AExamModel>> triggerExam(int id, String type) async {
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
        return Right(AExamModel.fromJson(response.data['data']));
      }

      return const Left('Terjadi kesalahan');
    } on DioError catch (e) {
      return const Left('Terjadi kesalahan pada server');
    }
  }
}