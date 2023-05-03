import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'provider/admin/a_exam_provider.dart';
import 'provider/admin/a_import_provider.dart';
import 'provider/auth/o_select_role_provider.dart';
import 'provider/loading_provider.dart';
import 'provider/teacher/t_exam_provider.dart';
import 'provider/teacher/t_is_correct_answer_provider.dart';
import 'provider/teacher/t_is_random_provider.dart';
import 'provider/teacher/t_question_provider.dart';
import 'provider/teacher/t_select_class_provider.dart';
import 'provider/teacher/t_thumbnail_provider.dart';

import 'screens/auth/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
       statusBarColor: Colors.green
    ));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoadingProvider>(create: (_) => LoadingProvider()),
        ChangeNotifierProvider<OSelectRoleProvider>(create: (_) => OSelectRoleProvider()),
        
        ChangeNotifierProvider<TSelectClassProvider>(create: (_) => TSelectClassProvider()),
        ChangeNotifierProvider<TThumbnailProvider>(create: (_) => TThumbnailProvider()),
        ChangeNotifierProvider<TIsRandomProvider>(create: (_) => TIsRandomProvider()),
        ChangeNotifierProvider<TExamProvider>(create: (_) => TExamProvider()),
        ChangeNotifierProvider<TQuestionProvider>(create: (_) => TQuestionProvider()),
        ChangeNotifierProvider<TIsCorrectAnswerProvider>(create: (_) => TIsCorrectAnswerProvider()),
        
        ChangeNotifierProvider<AImportProvider>(create: (_) => AImportProvider()),
        ChangeNotifierProvider<AExamProvider>(create: (_) => AExamProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Examz',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: const Login(),
      ),
    );
  }
}