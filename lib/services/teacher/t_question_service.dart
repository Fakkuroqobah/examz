import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../configs/api.dart';
import '../../models/teacher/t_question_model.dart';

class TQuestionService {
  final Dio _dio = Dio();

  Future<List<TQuestionModel>> getQuestion(int id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    _dio.options.headers['authorization'] = 'Bearer ${preferences.getString("token")}';
    final response = await _dio.get("${Api.tQuestion}/$id");

    List<TQuestionModel> data = <TQuestionModel>[];
    response.data['data'].forEach((val) {
      data.add(TQuestionModel.fromJson(val));
    });

    return data;
  }
}