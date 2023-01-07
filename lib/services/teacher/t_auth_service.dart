import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/api.dart';
import '../../models/login_model.dart';
import '../../models/teacher/t_teacher_model.dart';

class TAuthService {
  final Dio _dio = Dio();

  String _errorsOnLogin = "";
  String get errorsOnLogin => _errorsOnLogin;
  
  Future<bool> login(String txtUsername, String txtPassword) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    final response = await _dio.post(Api.tLogin, 
      data: {
        "username": txtUsername,
        "password": txtPassword
      },
    );
    
    if(response.statusCode == 200) {
      LoginModel loginModel = LoginModel.fromJson(response.data);

      _dio.options.headers['authorization'] = 'Bearer ${loginModel.accessToken}';
      final getUser = await _dio.get(Api.tGetUser);

      TTeacherModel teacherModel = TTeacherModel.fromJson(getUser.data);

      preferences.setString("token", loginModel.accessToken);
      preferences.setInt("id", teacherModel.id);
      preferences.setString("name", teacherModel.name);
      preferences.setString("username", teacherModel.username);
      preferences.setString("role", teacherModel.role);

      return true;
    }else{
      _errorsOnLogin = response.data["error"];
      return false;
    }
  }
}