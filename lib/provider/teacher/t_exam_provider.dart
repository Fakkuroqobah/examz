// import 'package:flutter/material.dart';

// import '../../models/teacher/t_exam_model.dart';
// import '../../services/teacher/t_exam_service.dart';

// class TExamProvider extends ChangeNotifier {
//   TExamModel _examList;
//   TExamModel get examList => _examList;

//   TExamService tExamService = new TExamService();

//   void getInactive(BuildContext context) async {
//     _examList = await tExamService.getExam();
//     notifyListeners();
//   }
// }