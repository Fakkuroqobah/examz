import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../configs/api.dart';
import '../../models/login_model.dart';
import '../../models/supervisor_model.dart';

class PAuthService {
  final Dio _dio = Dio();
  
  Future<bool> login(String txtUsername, String txtPassword) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    
    final response = await _dio.post(Api.pLogin, 
      data: {
        "username": txtUsername,
        "password": txtPassword
      },
    );

    LoginModel loginModel = LoginModel.fromJson(response.data);

    _dio.options.headers['authorization'] = 'Bearer ${loginModel.accessToken}';
    final getUser = await _dio.get(Api.pGetUser);

    SupervisorModel supervisorModel = SupervisorModel.fromJson(getUser.data);

    preferences.setString("token", loginModel.accessToken);
    preferences.setInt("id", supervisorModel.id);
    preferences.setString("code", supervisorModel.code);
    preferences.setString("name", supervisorModel.name);
    preferences.setString("username", supervisorModel.username);
    preferences.setString("role", supervisorModel.role);

    return true;
  }

  Future<bool> logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    
    _dio.options.headers['authorization'] = 'Bearer ${preferences.getString("token")}';
    await _dio.get(Api.pLogout);

    return true;
  }
}