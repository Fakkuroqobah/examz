import 'package:dartz/dartz.dart';
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

  Future<Either<String, TQuestionModel>> addOrEditQuestion(int id, String txtSubject, Map<String, dynamic> answer, String type, {int? examId}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    final data = {
      "exam_id": (type == 'add') ? id : examId,
      "subject": txtSubject,
      "answer": answer,
    };

    try {
      _dio.options.headers['authorization'] = 'Bearer ${preferences.getString("token")}';
      _dio.options.headers['accept'] = 'application/json';

      final response = await _dio.post((type == 'add') ? Api.tQuestionAdd : "${Api.tQuestionEdit}/$id", 
        data: data,
      );

      if (response.statusCode == 201) {
        return Right(TQuestionModel.fromJson(response.data['data']));
      }

      return const Left('Terjadi kesalahan');
    } on DioError catch (e) {
      if (e.response != null) {
        String errMsg = "";
        int first = 0;
        e.response!.data['errors'].forEach((key, val) {
          if(first == 0) {errMsg += val[0];}
          else {errMsg += val[0] + "\n";}
          first++;
        });

        return Left(errMsg);
      }
      return const Left('Terjadi kesalahan pada server');
    }
  }

  Future<bool> deleteQuestion(int id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    _dio.options.headers['authorization'] = 'Bearer ${preferences.getString("token")}';
    await _dio.delete("${Api.tQuestionDelete}/$id");
    
    return true;
  }
}