import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../configs/api.dart';
import '../../models/login_model.dart';
import '../../models/teacher_model.dart';

class TAuthService {
  final Dio _dio = Dio();
  
  Future<bool> login(String txtUsername, String txtPassword) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    
    final response = await _dio.post(Api.tLogin, 
      data: {
        "username": txtUsername,
        "password": txtPassword
      },
    );

    LoginModel loginModel = LoginModel.fromJson(response.data);

    _dio.options.headers['authorization'] = 'Bearer ${loginModel.accessToken}';
    final getUser = await _dio.get(Api.tGetUser);

    TeacherModel teacherModel = TeacherModel.fromJson(getUser.data);

    preferences.setString("token", loginModel.accessToken);
    preferences.setInt("id", teacherModel.id);
    preferences.setString("name", teacherModel.name);
    preferences.setString("username", teacherModel.username);
    preferences.setString("role", teacherModel.role);

    return true;
  }

  Future<bool> logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    
    _dio.options.headers['authorization'] = 'Bearer ${preferences.getString("token")}';
    await _dio.get(Api.tLogout);

    return true;
  }
}