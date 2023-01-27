import 'dart:io';

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

  Future<Exam> detailExam(int id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    _dio.options.headers['authorization'] = 'Bearer ${preferences.getString("token")}';
    final response = await _dio.get("${Api.tExamDetail}/$id");

    Exam data = Exam.fromJson(response.data['data']);

    return data;
  }

  Future<bool> addExam(String txtName, String txtClass, String txtDescription, File thumbnailPath, String thumbnailName) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    FormData data = FormData.fromMap({
      "name": txtName,
      "class": txtClass,
      "description": txtDescription,
      "thumbnail": await MultipartFile.fromFile(
        thumbnailPath.path,
        filename: thumbnailName,
      ),
    });

    _dio.options.headers['authorization'] = 'Bearer ${preferences.getString("token")}';
    await _dio.post(Api.tExamAdd, 
      data: data,
      options: Options(
        contentType: 'multipart/form-data',
        followRedirects: false,
      )
    );
    
    return true;
  }

  Future<bool> editExam(int id, String txtName, String txtClass, String txtDescription, File? thumbnailPath, String? thumbnailName) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    FormData data;
    if(thumbnailPath != null) {
      data = FormData.fromMap({
        "name": txtName,
        "class": txtClass,
        "description": txtDescription,
        "thumbnail": await MultipartFile.fromFile(
          thumbnailPath.path,
          filename: thumbnailName,
        ),
      });
    }else{
      data = FormData.fromMap({
        "name": txtName,
        "class": txtClass,
        "description": txtDescription,
      });
    }

    _dio.options.headers['authorization'] = 'Bearer ${preferences.getString("token")}';
    await _dio.post("${Api.tExamEdit}/$id", 
      data: data,
      options: Options(
        contentType: 'multipart/form-data',
        followRedirects: false,
      )
    );
    
    return true;
  }

  Future<bool> deleteExam(int id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    _dio.options.headers['authorization'] = 'Bearer ${preferences.getString("token")}';
    await _dio.delete("${Api.tExamDelete}/$id");
    
    return true;
  }
}