import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../services/admin/a_auth_service.dart';
import '../../services/student/s_auth_service.dart';
import '../../services/supervisor/p_auth_service.dart';
import '../../services/teacher/t_auth_service.dart';

import '../student/s_exam.dart';
import '../supervisor/p_exam.dart';
import '../teacher/t_exam.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TAuthService _tAuthService = TAuthService();
  final SAuthService _sAuthService = SAuthService();
  final AAuthService _aAuthService = AAuthService();
  final PAuthService _pAuthService = PAuthService();
  
  bool _isLoading = false;
  String _valRole = "supervisor";

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController txtUsername = TextEditingController();
  final TextEditingController txtPassword = TextEditingController();
  final FocusNode focusUsername = FocusNode();
  final FocusNode focusPassword = FocusNode();
  final FocusNode focusLogin = FocusNode();
  
  @override
  Widget build(BuildContext context) {
    txtUsername.text = "supervisor";
    txtPassword.text = "password";

    return Scaffold(
      appBar: AppBar(
        title: const Text("Masuk"),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 44.0, vertical: 0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Selamat Datang Di Examz", style: TextStyle(
                fontSize: 20.0
              )),
              
              const SizedBox(height: 22.0),
              FormAuth(
                hint: "Username",
                action: TextInputAction.next, 
                textEditingController: txtUsername,
                focusNow: focusUsername,
                focusNext: focusPassword
              ),
      
              const SizedBox(height: 18.0),
              FormAuth(
                hint: "Password",
                action: TextInputAction.next, 
                textEditingController: txtPassword,
                obsecure: true,
                focusNow: focusPassword,
                focusNext: focusLogin
              ),

              const SizedBox(height: 18.0),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0))
                ),
                child: DropdownButton<String>(
                  isExpanded: true,
                  hint: const Text("Pilih Role"),
                  value: _valRole,
                  underline: Container(
                    height: 1.0,
                    decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.transparent, width: 0.0))
                    ),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'student', child: Text('student')),
                    DropdownMenuItem(value: 'admin', child: Text('admin')),
                    DropdownMenuItem(value: 'teacher', child: Text('teacher')),
                    DropdownMenuItem(value: 'supervisor', child: Text('supervisor'))
                  ],
                  onChanged: (String? value) {
                    setState(() {
                      _valRole = value!;
                    });
                  }
                ),
              ),
              
              const SizedBox(height: 18.0),
              ElevatedButton(
                onPressed: () {
                  setState(() => _isLoading = true);
                  
                  String email = txtUsername.text.toString();
                  String password= txtPassword.text.toString();

                  if(_valRole == "teacher") {
                    _tAuthService.login(email, password).then((value) {
                      setState(() => _isLoading = false);
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => const TExam()));
                    }).catchError((err) {
                      setState(() => _isLoading = false);
                      if (err is DioError) {
                        SnackBar snackBar = SnackBar(content: Text(err.response?.data['error']));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }else{
                        SnackBar snackBar = const SnackBar(content: Text("Terjadi kesalahan"));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    });
                  }else if(_valRole == 'student') {
                    _sAuthService.login(email, password).then((value) {
                      setState(() => _isLoading = false);
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => const SExam()));
                    }).catchError((err) {
                      setState(() => _isLoading = false);
                      if (err is DioError) {
                        SnackBar snackBar = SnackBar(content: Text(err.response?.data['error']));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }else{
                        SnackBar snackBar = const SnackBar(content: Text("Terjadi kesalahan"));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    });
                  }else if(_valRole == 'admin') {
                    _aAuthService.login(email, password).then((value) {
                      setState(() => _isLoading = false);
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => const SExam()));
                    }).catchError((err) {
                      setState(() => _isLoading = false);
                      if (err is DioError) {
                        SnackBar snackBar = SnackBar(content: Text(err.response?.data['error']));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }else{
                        SnackBar snackBar = const SnackBar(content: Text("Terjadi kesalahan"));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    });
                  }else if(_valRole == 'supervisor') {
                    _pAuthService.login(email, password).then((value) {
                      setState(() => _isLoading = false);
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => const PExam()));
                    }).catchError((err) {
                      setState(() => _isLoading = false);
                      if (err is DioError) {
                        SnackBar snackBar = SnackBar(content: Text(err.response?.data['error']));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }else{
                        SnackBar snackBar = const SnackBar(content: Text("Terjadi kesalahan"));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    });
                  }else{
                    setState(() => _isLoading = false);
                    SnackBar snackBar = const SnackBar(content: Text("Role tidak valid"));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                style: const ButtonStyle(
                  elevation: MaterialStatePropertyAll(0),
                  padding: MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0))
                ),
                child: _isLoading ? const CircularProgressIndicator(color: Colors.white) : const Text("Login")
              )
            ],
          ),
        ),
      ),
    );
  }
}

class FormAuth extends StatelessWidget {
  final String hint;
  final TextInputAction action;
  final TextEditingController textEditingController;
  final FocusNode focusNow;
  final FocusNode focusNext; 
  final bool obsecure;

  const FormAuth({
    Key? key,
    required this.hint,
    required this.action,
    required this.textEditingController,
    required this.focusNow,
    required this.focusNext,
    this.obsecure = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      keyboardType: TextInputType.text,
      obscureText: obsecure,
      focusNode: focusNow,
      textInputAction: action,
      onFieldSubmitted: (v){
        FocusScope.of(context).requestFocus(focusNext);
      },
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}