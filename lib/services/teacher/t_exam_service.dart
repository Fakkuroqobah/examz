import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/api.dart';
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

  Future<bool> addExam(String txtName, String txtClass, File thumbnailPath, String thumbnailName) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    FormData data = FormData.fromMap({
      "name": txtName,
      "class": txtClass,
      "thumbnail": await MultipartFile.fromFile(
        thumbnailPath.path,
        filename: thumbnailName,
      ),
    });

    try{
      _dio.options.headers['authorization'] = 'Bearer ${preferences.getString("token")}';
      final response = await _dio.post(Api.tExamAdd, 
        data: data,
        options: Options(
          contentType: 'multipart/form-data',
          followRedirects: false,
        )
      );
      
      if(response.statusCode == 200) {
        return true;
      }else{
        return false;
      }
    } catch(error){
      return false;
    }
  }

  Future<bool> deleteExam(int id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    _dio.options.headers['authorization'] = 'Bearer ${preferences.getString("token")}';
    final response = await _dio.delete("${Api.tExamDelete}/$id");
    
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}