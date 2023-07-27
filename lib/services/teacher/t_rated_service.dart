import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../configs/api.dart';
import '../../models/exam_model.dart';
import '../../models/rated_model.dart';
import '../../models/student_schedule_model.dart';

class TRatedService {
  final Dio _dio = Dio();

  Future<List<ExamModel>> getExam() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    _dio.options.headers['authorization'] = 'Bearer ${preferences.getString("token")}';
    final response = await _dio.get(Api.tRatedExam);

    List<ExamModel> data = <ExamModel>[];
    response.data['data'].forEach((val) {
      data.add(ExamModel.fromJson(val));
    });

    return data;
  }

  Future<List<StudentScheduleModel>> getStudent(int examId, String classExam) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    _dio.options.headers['authorization'] = 'Bearer ${preferences.getString("token")}';
    final response = await _dio.get("${Api.tRatedStudent}/$examId/$classExam");

    List<StudentScheduleModel> data = <StudentScheduleModel>[];
    response.data['data'].forEach((val) {
      data.add(StudentScheduleModel.fromJson(val));
    });

    return data;
  }

  Future<RatedModel> getRated(int studentId, int examId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    _dio.options.headers['authorization'] = 'Bearer ${preferences.getString("token")}';
    final response = await _dio.get("${Api.tRatedStudentDetail}/$studentId/$examId");

    return RatedModel.fromJson(response.data['data']);
  }

  Future<Either<String, RatedModel>> update(int id, int studentId, int examId, String score) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    final Map<String, dynamic> data;
    data = {
      "score": score,
      "studentId": studentId,
      "examId": examId
    };

    try {
      _dio.options.headers['authorization'] = 'Bearer ${preferences.getString("token")}';
      _dio.options.headers['accept'] = 'application/json';
      final response = await _dio.post("${Api.tRatedStudentUpdate}/$id", 
        data: data
      );

      if (response.statusCode == 200) {
        return Right(RatedModel.fromJson(response.data['data']));
      }
      return const Left('Terjadi kesalahan');
    } on DioError catch (_) {
      return const Left('Terjadi kesalahan pada server');
    }
  }
}