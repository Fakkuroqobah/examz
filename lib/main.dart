import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'provider/auth/o_select_role_provider.dart';
import 'provider/loading_provider.dart';
import 'screens/auth/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
       statusBarColor: Colors.green
    ));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoadingProvider>(create: (_) => LoadingProvider()),
        ChangeNotifierProvider<OSelectRoleProvider>(create: (_) => OSelectRoleProvider())
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