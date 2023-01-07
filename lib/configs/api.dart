class Api {
  static const String tBaseUrl = "http://192.168.43.147/examz/public/api/teacher";
  String get tBaseUrlAsset => "http://192.168.43.147/examz/public/storage/";
  
  // TEACHER
  static const String tLogin = "$tBaseUrl/login";
  static const String tGetUser = "$tBaseUrl/get-user";
  static const String tRefresh = "$tBaseUrl/refresh";
  static const String tLogout = "$tBaseUrl/logout";

  static const String tExam = "$tBaseUrl/exam";
  static const String tExamDetail = "$tBaseUrl/exam/detail";
  static const String tExamAdd = "$tBaseUrl/exam/add";
  static const String tExamEdit = "$tBaseUrl/exam/edit";
  static const String tExamDelete = "$tBaseUrl/exam/delete";
}