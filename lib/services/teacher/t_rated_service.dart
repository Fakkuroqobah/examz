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
}