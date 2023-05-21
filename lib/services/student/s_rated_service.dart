import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../configs/api.dart';
import '../../models/rated_model.dart';

class SRatedService {
  final Dio _dio = Dio();

  Future<RatedModel> getRated(int examId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    _dio.options.headers['authorization'] = 'Bearer ${preferences.getString("token")}';
    final response = await _dio.get("${Api.sRated}/$examId");

    return RatedModel.fromJson(response.data['data']);
  }
}