import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../configs/api.dart';
import '../../configs/utils.dart';
import '../../models/student_schedule_model.dart';

class PStudentService {
  final Dio _dio = Dio();
  final Utils _utils = Utils();

  PStudentService() {
    _utils.interceptor(_dio, 'supervisor');
  }

  Future<List<StudentScheduleModel>> getStudent(int id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    _dio.options.headers['authorization'] = 'Bearer ${preferences.getString("token")}';
    final response = await _dio.get("${Api.pStudent}/$id");
    
    List<StudentScheduleModel> data = <StudentScheduleModel>[];
    response.data['data'].forEach((val) {
      data.add(StudentScheduleModel.fromJson(val));
    });

    return data;
  }
}