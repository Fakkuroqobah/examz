import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api.dart';

class Utils {
  final Dio _dio = Dio();
  
  static String getFormatedDate(DateTime? date) {
    var outputFormat = DateFormat('dd-MM-yyyy');

    if(date != null) {
      return outputFormat.format(date);
    }else{
      return '';
    }
  }

  Future<String> refreshToken(String role) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    String url = '';
    if(role == 'teacher') {
      url = Api.tRefresh;
    }else if(role == 'student') {
      url = Api.sRefresh;
    }else if(role == 'supervisor') {
      url = Api.pRefresh;
    }else{
      url = Api.aRefresh;
    }

    _dio.options.headers['authorization'] = 'Bearer ${preferences.getString("token")}';
    final response = await _dio.get(url);

    preferences.setString("token", response.data['access_token']);

    return response.data['access_token'];
  }

  void interceptor(Dio dio, String role) async {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
          return handler.next(options);
        },
        onResponse: (Response response, ResponseInterceptorHandler handler) {
          return handler.next(response);
        },
        onError: (DioError e, handler) async {
          if (e.response?.statusCode == 401) {
            String newAccessToken = await refreshToken(role);
            e.requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';

            return handler.resolve(await dio.fetch(e.requestOptions));
          }
          return handler.next(e);
        },
      )
    );
  }
}