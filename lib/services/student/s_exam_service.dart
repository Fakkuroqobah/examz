import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../configs/api.dart';
import '../../models/student/s_exam_model.dart';
import '../../models/student/s_question_model.dart';

class SExamService {
  final Dio _dio = Dio();

  Future<List<SExamModel>> getExamLaunched() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    _dio.options.headers['authorization'] = 'Bearer ${preferences.getString("token")}';
    final response = await _dio.get(Api.sExamLaunched);
    
    List<SExamModel> data = <SExamModel>[];
    response.data['data'].forEach((val) {
      data.add(SExamModel.fromJson(val));
    });

    return data;
  }

  Future<List<SExamModel>> getExamFinished() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    _dio.options.headers['authorization'] = 'Bearer ${preferences.getString("token")}';
    final response = await _dio.get(Api.sExamFinished);
    
    List<SExamModel> data = <SExamModel>[];
    response.data['data'].forEach((val) {
      data.add(SExamModel.fromJson(val));
    });

    return data;
  }

  Future<Either<String, List<SQuestionModel>>> token(int id, String token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    final data = {
      "token": token,
    };

    try {
      _dio.options.headers['authorization'] = 'Bearer ${preferences.getString("token")}';
      _dio.options.headers['accept'] = 'application/json';
      final response = await _dio.post("${Api.sToken}/$id", 
        data: data
      );

      if (response.statusCode == 200) {
        List<SQuestionModel> data = <SQuestionModel>[];
        response.data['data']['question'].forEach((val) {
          data.add(SQuestionModel.fromJson(val));
        });

        return Right(data);
      }
      return const Left('Terjadi kesalahan');
    } on DioError catch (err) {
      if(err.response?.statusCode == 404) {
        return const Left('Token yang kamu masukan salah');
      }

      return const Left('Terjadi kesalahan pada server');
    }
  }
}