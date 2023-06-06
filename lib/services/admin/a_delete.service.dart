import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../configs/api.dart';

class ADeleteService {
  final Dio _dio = Dio();
  
  Future<Either<String, String>> deleteData(int id, String type) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String urlApi = '';

    switch (type) {
      case "teacher":
        urlApi = Api.aDeleteTeacher;
        break;
      case "supervisor":
        urlApi = Api.aDeleteSupervisor;
        break;
      case "student":
        urlApi = Api.aDeleteStudent;
        break;
      case "room":
        urlApi = Api.aDeleteRoom;
        break;
      case "schedule":
        urlApi = Api.aDeleteSchedule;
        break;
      default:
    }

    try {
      _dio.options.headers['authorization'] = 'Bearer ${preferences.getString("token")}';
      final response = await _dio.delete("$urlApi/$id");
      
      if (response.statusCode == 200) {
        return const Right("Hapus data berhasil");
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
}