class Api {
  // static const String baseUrl = "http://192.168.43.147/examz/public";
  static const String baseUrl = "https://sekolahdrwahidinmlati.online";
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

  static const String tRatedExam = "$tBaseUrl/rated";
  static const String tRatedStudent = "$tBaseUrl/rated/student";
  static const String tRatedStudentDetail = "$tBaseUrl/rated/student-detail";
  static const String tRatedStudentUpdate = "$tBaseUrl/rated/student-rated";
  static const String tRatedExport = "$tBaseUrl/rated/export";

  // STUDENT
  static const String sLogin = "$sBaseUrl/login";
  static const String sGetUser = "$sBaseUrl/get-user";
  static const String sRefresh = "$sBaseUrl/refresh";
  static const String sLogout = "$sBaseUrl/logout";

  static const String sExamLaunched = "$sBaseUrl/exam-launched";
  static const String sExamFinished = "$sBaseUrl/exam-finished";
  static const String sToken = "$sBaseUrl/token";
  static const String sAnswer = "$sBaseUrl/answer";
  static const String sEndExam = "$sBaseUrl/end-exam";
  static const String sBlock = "$sBaseUrl/block";
  static const String sOpenBlock = "$sBaseUrl/open-block";

  static const String sRated = "$sBaseUrl/rated";

  // SUPERVISOR
  static const String pLogin = "$pBaseUrl/login";
  static const String pGetUser = "$pBaseUrl/get-user";
  static const String pRefresh = "$pBaseUrl/refresh";
  static const String pLogout = "$pBaseUrl/logout";
  
  static const String pExam = "$pBaseUrl/exam";
  static const String pStart = "$pBaseUrl/exam/start";
  static const String pStop = "$pBaseUrl/exam/stop";

  static const String pStudent = "$pBaseUrl/student";

  // ADMIN
  static const String aLogin = "$aBaseUrl/login";
  static const String aGetUser = "$aBaseUrl/get-user";
  static const String aRefresh = "$aBaseUrl/refresh";
  static const String aLogout = "$aBaseUrl/logout";

  static const String aExam = "$aBaseUrl/exam";
  static const String aTrigger = "$aBaseUrl/exam/trigger";
  static const String aTriggerRated = "$aBaseUrl/exam/trigger-rated";

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

  static const String aEditTeacher = "$aBaseUrl/edit/teacher";
  static const String aEditStudent = "$aBaseUrl/edit/student";
  static const String aEditSupervisor = "$aBaseUrl/edit/supervisor";
  static const String aEditRoom = "$aBaseUrl/edit/room";

  static const String aDeleteTeacher = "$aBaseUrl/delete/teacher";
  static const String aDeleteStudent = "$aBaseUrl/delete/student";
  static const String aDeleteSupervisor = "$aBaseUrl/delete/supervisor";
  static const String aDeleteRoom = "$aBaseUrl/delete/room";
  static const String aDeleteSchedule = "$aBaseUrl/delete/schedule";
}