import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../configs/api.dart';
import '../../models/rated_model.dart';
import '../../models/teacher/t_exam_model.dart';
import '../../models/teacher/t_rated_model.dart';

class TRatedService {
  final Dio _dio = Dio();

  Future<List<Exam>> getExam() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    _dio.options.headers['authorization'] = 'Bearer ${preferences.getString("token")}';
    final response = await _dio.get(Api.tRatedExam);

    List<Exam> data = <Exam>[];
    response.data['data'].forEach((val) {
      data.add(Exam.fromJson(val));
    });

    return data;
  }

  Future<List<TRatedModel>> getStudent(int examId, String classExam) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    _dio.options.headers['authorization'] = 'Bearer ${preferences.getString("token")}';
    final response = await _dio.get("${Api.tRatedStudent}/$examId/$classExam");

    List<TRatedModel> data = <TRatedModel>[];
    response.data['data'].forEach((val) {
      data.add(TRatedModel.fromJson(val));
    });

    return data;
  }

  Future<RatedModel> getRated(int studentId, int examId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    _dio.options.headers['authorization'] = 'Bearer ${preferences.getString("token")}';
    final response = await _dio.get("${Api.tRatedStudentDetail}/$studentId/$examId");

    return RatedModel.fromJson(response.data['data']);
  }
}