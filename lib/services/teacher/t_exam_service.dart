import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../configs/api.dart';
import '../../models/teacher/t_exam_model.dart';

class TExamService {
  final Dio _dio = Dio();

  Future<TExamModel> getExam() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    _dio.options.headers['authorization'] = 'Bearer ${preferences.getString("token")}';
    final response = await _dio.get(Api.tExam);

    TExamModel data = TExamModel.fromJson(response.data['data']);

    return data;
  }

  Future<Either<String, Exam>> addExam(String txtName, String txtClass, String txtDescription, String thumbnailByte, String thumbnailExtension, bool? isRandom, int time) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    final data = {
      "name": txtName,
      "class": txtClass,
      "description": txtDescription,
      "thumbnail": {"extension": thumbnailExtension, "byte": thumbnailByte},
      "is_random": isRandom,
      "time": time,
    };

    try {
      _dio.options.headers['authorization'] = 'Bearer ${preferences.getString("token")}';
      _dio.options.headers['accept'] = 'application/json';
      final response = await _dio.post(Api.tExamAdd, 
        data: data,
      );

      if (response.statusCode == 201) {
        return Right(Exam.fromJson(response.data['data']));
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

  Future<Either<String, Exam>> editExam(int id, String txtName, String txtClass, String txtDescription, String? thumbnailByte, String? thumbnailExtension, bool? isRandom, int time) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    Map<String, dynamic> data = {};
    if(thumbnailByte == null) {
      data = {
        "name": txtName,
        "class": txtClass,
        "description": txtDescription,
        "is_random": isRandom,
        "time": time,
      };
    }else{
      data = {
        "name": txtName,
        "class": txtClass,
        "description": txtDescription,
        "thumbnail": {"extension": thumbnailExtension, "byte": thumbnailByte},
        "is_random": isRandom,
        "time": time,
      };
    }

    try {
      _dio.options.headers['authorization'] = 'Bearer ${preferences.getString("token")}';
      _dio.options.headers['accept'] = 'application/json';
      final response = await _dio.post("${Api.tExamEdit}/$id", 
        data: data,
      );

      if (response.statusCode == 200) {
        return Right(Exam.fromJson(response.data['data']));
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

  Future<bool> deleteExam(int id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    _dio.options.headers['authorization'] = 'Bearer ${preferences.getString("token")}';
    await _dio.delete("${Api.tExamDelete}/$id");
    
    return true;
  }
}