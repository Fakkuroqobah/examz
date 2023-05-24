import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../configs/api.dart';
import '../../models/login_model.dart';
import '../../models/student_model.dart';

class SAuthService {
  final Dio _dio = Dio();
  
  Future<bool> login(String txtUsername, String txtPassword) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    
    final response = await _dio.post(Api.sLogin, 
      data: {
        "username": txtUsername,
        "password": txtPassword
      },
    );

    LoginModel loginModel = LoginModel.fromJson(response.data);

    _dio.options.headers['authorization'] = 'Bearer ${loginModel.accessToken}';
    final getUser = await _dio.get(Api.sGetUser);

    StudentModel studentModel = StudentModel.fromJson(getUser.data);

    preferences.setString("token", loginModel.accessToken);
    preferences.setInt("id", studentModel.id);
    preferences.setString("name", studentModel.name);
    preferences.setString("username", studentModel.username);
    preferences.setString("studentModelClass", studentModel.studentModelClass);
    preferences.setString("role", studentModel.role);

    return true;
  }

  Future<bool> logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    
    _dio.options.headers['authorization'] = 'Bearer ${preferences.getString("token")}';
    await _dio.get(Api.sLogout);

    return true;
  }
}