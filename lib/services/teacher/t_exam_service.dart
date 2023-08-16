import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http_parser/http_parser.dart';

import '../../configs/api.dart';
import '../../configs/utils.dart';
import '../../models/exam_group_model.dart';
import '../../models/exam_model.dart';

class TExamService {
  final Dio _dio = Dio();
  final Utils _utils = Utils();

  TExamService() {
    _utils.interceptor(_dio, 'teacher');
  }

  Future<ExamGroupModel> getExam() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    _dio.options.headers['authorization'] = 'Bearer ${preferences.getString("token")}';
    final response = await _dio.get(Api.tExam);

    ExamGroupModel data = ExamGroupModel.fromJson(response.data['data']);

    return data;
  }

  Future<Either<String, ExamModel>> addExam(String txtName, String txtClass, String txtDescription, List<int> thumbnailByte, String thumbnailExtension, bool? isRandom, int time) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    final data = FormData.fromMap({
      "name": txtName,
      "class": txtClass,
      "description": txtDescription,
      "thumbnail": MultipartFile.fromBytes(
        thumbnailByte,
        filename: "image",
        contentType: MediaType('image', thumbnailExtension)
      ),
      "is_random": isRandom,
      "time": time,
    });

    try {
      _dio.options.headers['authorization'] = 'Bearer ${preferences.getString("token")}';
      _dio.options.headers['accept'] = 'application/json';
      _dio.options.headers['Content-Type'] = 'multipart/form-data';
      final response = await _dio.post(Api.tExamAdd, 
        data: data,
      );

      if (response.statusCode == 201) {
        return Right(ExamModel.fromJson(response.data['data']));
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

  Future<Either<String, ExamModel>> editExam(int id, String txtName, String txtClass, String txtDescription, List<int>? thumbnailByte, String? thumbnailExtension, bool? isRandom, int time) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    FormData data;
    if(thumbnailByte == null) {
      data = FormData.fromMap({
        "name": txtName,
        "class": txtClass,
        "description": txtDescription,
        "is_random": isRandom,
        "time": time,
      });
    }else{
      data = FormData.fromMap({
        "name": txtName,
        "class": txtClass,
        "description": txtDescription,
        "thumbnail": MultipartFile.fromBytes(
          thumbnailByte,
          filename: "image",
          contentType: MediaType('image', thumbnailExtension!)
        ),
        "is_random": isRandom,
        "time": time,
      });
    }

    try {
      _dio.options.headers['authorization'] = 'Bearer ${preferences.getString("token")}';
      _dio.options.headers['accept'] = 'application/json';
      _dio.options.headers['Content-Type'] = 'multipart/form-data';
      final response = await _dio.post("${Api.tExamEdit}/$id", 
        data: data,
      );

      if (response.statusCode == 200) {
        return Right(ExamModel.fromJson(response.data['data']));
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