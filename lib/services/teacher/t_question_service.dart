import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../configs/api.dart';
import '../../configs/utils.dart';
import '../../models/question_model.dart';

class TQuestionService {
  final Dio _dio = Dio();
  final Utils _utils = Utils();

  TQuestionService() {
    _utils.interceptor(_dio, 'teacher');
  }

  Future<List<QuestionModel>> getQuestion(int id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    _dio.options.headers['authorization'] = 'Bearer ${preferences.getString("token")}';
    final response = await _dio.get("${Api.tQuestion}/$id");

    List<QuestionModel> data = <QuestionModel>[];
    response.data['data'].forEach((val) {
      // print(val);
      data.add(QuestionModel.fromJson(val));
    });

    return data;
  }

  Future<Either<String, QuestionModel>> addOrEditQuestion(int id, String type, String txtSubject, Map<String, dynamic> answer, String addOrEdit, {int? examId}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    final Map<String, dynamic> data;
    if(type == 'choice') {
      data = {
        "exam_id": (addOrEdit == 'add') ? id : examId,
        "subject": txtSubject,
        "answer": answer,
        "type": type
      };
    }else{
      data = {
        "exam_id": (addOrEdit == 'add') ? id : examId,
        "subject": txtSubject,
        "answer": answer['essay'],
        "type": type
      };
    }

    try {
      _dio.options.headers['authorization'] = 'Bearer ${preferences.getString("token")}';
      _dio.options.headers['accept'] = 'application/json';

      final response = await _dio.post((addOrEdit == 'add') ? Api.tQuestionAdd : "${Api.tQuestionEdit}/$id", 
        data: data,
      );

      if (response.statusCode == 201) {
        return Right(QuestionModel.fromJson(response.data['data']));
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