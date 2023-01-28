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

  Future<bool> addQuestion(int id, String txtSubject, Map<String, dynamic> answer) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    FormData data = FormData.fromMap({
      "exam_id": id,
      "subject": txtSubject,
      "answer": answer,
    });

    try {
      _dio.options.headers['authorization'] = 'Bearer ${preferences.getString("token")}';
      await _dio.post(Api.tQuestionAdd, data: data);
      
      return true;
    }on DioError catch (e) {
      e.response?.data.toString();
      // print(e.response?.data.toString());
      return false;
    }
  }
}