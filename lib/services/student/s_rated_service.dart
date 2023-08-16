import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../configs/api.dart';
import '../../configs/utils.dart';
import '../../models/rated_model.dart';

class SRatedService {
  final Dio _dio = Dio();
  final Utils _utils = Utils();

  SRatedService() {
    _utils.interceptor(_dio, 'student');
  }

  Future<RatedModel> getRated(int examId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    _dio.options.headers['authorization'] = 'Bearer ${preferences.getString("token")}';
    final response = await _dio.get("${Api.sRated}/$examId");

    return RatedModel.fromJson(response.data['data']);
  }
}