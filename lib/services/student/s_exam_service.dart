import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../configs/api.dart';
import '../../models/question_model.dart';
import '../../models/schedule_model.dart';
import '../../models/student_schedule_model.dart';

class SExamService {
  final Dio _dio = Dio();

  Future<List<ScheduleModel>> getExamLaunched() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    _dio.options.headers['authorization'] = 'Bearer ${preferences.getString("token")}';
    final response = await _dio.get(Api.sExamLaunched);
    
    List<ScheduleModel> data = <ScheduleModel>[];
    response.data['data'].forEach((val) {
      data.add(ScheduleModel.fromJson(val));
    });

    return data;
  }

  Future<List<StudentScheduleModel>> getExamFinished() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    _dio.options.headers['authorization'] = 'Bearer ${preferences.getString("token")}';
    final response = await _dio.get(Api.sExamFinished);
    
    List<StudentScheduleModel> data = <StudentScheduleModel>[];
    response.data['data'].forEach((val) {
      data.add(StudentScheduleModel.fromJson(val));
    });

    return data;
  }

  Future<Either<String, List<dynamic>>> token(int id, String token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    final data = {
      "token": token,
    };

    try {
      _dio.options.headers['authorization'] = 'Bearer ${preferences.getString("token")}';
      _dio.options.headers['accept'] = 'application/json';
      final response = await _dio.post("${Api.sToken}/$id", 
        data: data
      );

      if (response.statusCode == 200) {
        int remainingTime = response.data['data']['remaining_time'];
        List<QuestionModel> data = <QuestionModel>[];
        response.data['data']['question'].forEach((val) {
          data.add(QuestionModel.fromJson(val));
        });

        return Right([remainingTime, data]);
      }
      return const Left('Terjadi kesalahan');
    } on DioError catch (e) {
      if (e.response != null) {
        if(e.response!.statusCode == 422) {
          String errMsg = "";
          int first = 0;
          e.response!.data['errors'].forEach((key, val) {
            if(first == 0) {errMsg += val[0];}
            else {errMsg += val[0] + "\n";}
            first++;
          });

          return Left(errMsg);
        }

        if(e.response!.statusCode == 404) {
          return const Left('Token yang kamu masukan salah');
        }
      }

      return const Left('Terjadi kesalahan pada server');
    }
  }

  Future<Either<String, String>> answer(int id, String type, dynamic answer) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    final Map<String, dynamic> data;
    if(type == 'choice') {
      data = {
        "question_id": id,
        "answer_option_id": answer,
        "type": type
      };
    }else{
      data = {
        "question_id": id,
        "answer_essay": answer,
        "type": type
      };
    }

    try {
      _dio.options.headers['authorization'] = 'Bearer ${preferences.getString("token")}';
      _dio.options.headers['accept'] = 'application/json';
      final response = await _dio.post(Api.sAnswer, 
        data: data
      );

      if (response.statusCode == 200) {
        return const Right("Berhasil");
      }
      return const Left('Terjadi kesalahan');
    } on DioError catch (_) {
      return const Left('Terjadi kesalahan pada server');
    }
  }

  Future<Either<String, String>> endExam(int id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    final data = {
      "exam_id": id
    };

    try {
      _dio.options.headers['authorization'] = 'Bearer ${preferences.getString("token")}';
      _dio.options.headers['accept'] = 'application/json';
      final response = await _dio.post(Api.sEndExam, 
        data: data
      );

      if (response.statusCode == 200) {
        return const Right("Berhasil");
      }
      return const Left('Terjadi kesalahan');
    } on DioError catch (_) {
      return const Left('Terjadi kesalahan pada server');
    }
  }

  Future<Either<String, String>> block(int id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    final data = {
      "exam_id": id
    };

    try {
      _dio.options.headers['authorization'] = 'Bearer ${preferences.getString("token")}';
      _dio.options.headers['accept'] = 'application/json';
      final response = await _dio.post(Api.sBlock, 
        data: data
      );

      if (response.statusCode == 200) {
        return const Right("Berhasil");
      }
      return const Left('Terjadi kesalahan');
    } on DioError catch (_) {
      return const Left('Terjadi kesalahan pada server');
    }
  }

  Future<Either<String, String>> openBlock(int id, String block) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    final data = {
      "exam_id": id,
      "block": block
    };

    try {
      _dio.options.headers['authorization'] = 'Bearer ${preferences.getString("token")}';
      _dio.options.headers['accept'] = 'application/json';
      final response = await _dio.post(Api.sOpenBlock, 
        data: data
      );

      if (response.statusCode == 200) {
        return const Right("Berhasil");
      }
      return const Left('Terjadi kesalahan');
    } on DioError catch (e) {
      if (e.response != null) {
        if(e.response!.statusCode == 404) {
          return const Left('Token akses tidak tepat');
        }
      }

      return const Left('Terjadi kesalahan pada server');
    }
  }
}