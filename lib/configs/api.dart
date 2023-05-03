class Api {
  static const String baseUrl = "http://192.168.43.148/examz/public";
  static const String tBaseUrl = "$baseUrl/api/teacher";
  static const String sBaseUrl = "$baseUrl/api/student";
  static const String pBaseUrl = "$baseUrl/api/supervisor";
  static const String aBaseUrl = "$baseUrl/api/admin";
  String get tBaseUrlAsset => "$baseUrl/storage/";
  
  // TEACHER
  static const String tLogin = "$tBaseUrl/login";
  static const String tGetUser = "$tBaseUrl/get-user";
  static const String tRefresh = "$tBaseUrl/refresh";
  static const String tLogout = "$tBaseUrl/logout";

  static const String tExam = "$tBaseUrl/exam";
  static const String tExamAdd = "$tBaseUrl/exam/add";
  static const String tExamEdit = "$tBaseUrl/exam/edit";
  static const String tExamDelete = "$tBaseUrl/exam/delete";

  static const String tQuestion = "$tBaseUrl/exam/question";
  static const String tQuestionEdit = "$tBaseUrl/exam/question/edit";
  static const String tQuestionAdd = "$tBaseUrl/exam/question/add";
  static const String tQuestionDelete = "$tBaseUrl/exam/question/delete";

  // STUDENT
  static const String sLogin = "$sBaseUrl/login";
  static const String sGetUser = "$sBaseUrl/get-user";
  static const String sRefresh = "$sBaseUrl/refresh";
  static const String sLogout = "$sBaseUrl/logout";

  // SUPERVISOR
  static const String pLogin = "$pBaseUrl/login";
  static const String pGetUser = "$pBaseUrl/get-user";
  static const String pRefresh = "$pBaseUrl/refresh";
  static const String pLogout = "$pBaseUrl/logout";

  // ADMIN
  static const String aLogin = "$aBaseUrl/login";
  static const String aGetUser = "$aBaseUrl/get-user";
  static const String aRefresh = "$aBaseUrl/refresh";
  static const String aLogout = "$aBaseUrl/logout";

  static const String aExam = "$aBaseUrl/exam";
  static const String aTrigger = "$aBaseUrl/exam/trigger";

  static const String aRooms = "$aBaseUrl/rooms";
  static const String aSchedules = "$aBaseUrl/schedules";
  static const String aStudentSchedule = "$aBaseUrl/student-schedule";
  static const String aStudents = "$aBaseUrl/students";
  static const String aSupervisors = "$aBaseUrl/supervisors";
  static const String aTeachers = "$aBaseUrl/teachers";
  
  static const String aRoomsImport = "$aBaseUrl/import/rooms";
  static const String aSchedulesImport = "$aBaseUrl/import/schedules";
  static const String aStudentScheduleImport = "$aBaseUrl/import/student-schedule";
  static const String aStudentsImport = "$aBaseUrl/import/students";
  static const String aSupervisorsImport = "$aBaseUrl/import/supervisors";
  static const String aTeachersImport = "$aBaseUrl/import/teachers";
}