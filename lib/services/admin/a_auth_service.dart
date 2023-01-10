import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../configs/api.dart';
import '../../models/login_model.dart';
import '../../models/admin/a_admin_model.dart';

class AAuthService {
  final Dio _dio = Dio();
  
  Future<bool> login(String txtUsername, String txtPassword) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    
    final response = await _dio.post(Api.aLogin, 
      data: {
        "username": txtUsername,
        "password": txtPassword
      },
    );

    LoginModel loginModel = LoginModel.fromJson(response.data);

    _dio.options.headers['authorization'] = 'Bearer ${loginModel.accessToken}';
    final getUser = await _dio.get(Api.aGetUser);

    AAdminModel adminModel = AAdminModel.fromJson(getUser.data);

    preferences.setString("token", loginModel.accessToken);
    preferences.setInt("id", adminModel.id);
    preferences.setString("username", adminModel.username);
    preferences.setString("role", adminModel.role);

    return true;
  }

  Future<bool> logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    
    _dio.options.headers['authorization'] = 'Bearer ${preferences.getString("token")}';
    await _dio.get(Api.aLogout);

    return true;
  }
}