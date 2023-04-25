import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../configs/constant.dart';

import '../../provider/auth/o_select_role_provider.dart';
import '../../provider/loading_provider.dart';
import '../../services/admin/a_auth_service.dart';
import '../../services/student/s_auth_service.dart';
import '../../services/supervisor/p_auth_service.dart';
import '../../services/teacher/t_auth_service.dart';

import '../admin/a_teacher.dart';
import '../student/s_exam.dart';
import '../supervisor/p_exam.dart';
import '../teacher/t_exam.dart';

import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';


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

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController txtUsername = TextEditingController();
  final TextEditingController txtPassword = TextEditingController();
  final FocusNode focusUsername = FocusNode();
  final FocusNode focusPassword = FocusNode();
  final FocusNode focusLogin = FocusNode();
  
  @override
  Widget build(BuildContext context) {
    txtPassword.text = "password";

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 250.0,
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 18.0),
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Colors.green
                ),
                child: Image.asset(
                  "${Constant.assetUrlLogo}/logo-white.png",
                  width: 150.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                        child: Consumer<OSelectRoleProvider>(
                          builder: (_, oSelectRoleProvider, widget) {
                            return DropdownButton<String>(
                              value: oSelectRoleProvider.selectedItem,
                              hint: const Text("Pilih Role"),
                              isExpanded: true,
                              elevation: 0,
                              underline: Container(
                                height: 1.0,
                                decoration: const BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Colors.transparent, width: 0.0))
                                ),
                              ),
                              items: oSelectRoleProvider.items.map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                oSelectRoleProvider.setSelectedItem(newValue!);
                              }
                            );
                          }
                        ),
                      ),
                      
                      const SizedBox(height: 18.0),
                      Consumer<LoadingProvider>(
                        builder: (_, loadingProvider, widget) {
                          return ElevatedButton(
                            onPressed: () {
                              loadingProvider.setLoading(true);
                              
                              String username = txtUsername.text.toString();
                              String password= txtPassword.text.toString();
                              String selectedRole = context.read<OSelectRoleProvider>().selectedItem;

                              if(selectedRole == "Teacher") {
                                _tAuthService.login(username, password).then((value) {
                                  loadingProvider.setLoading(false);
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => const TExam()));
                                }).catchError((err) {
                                  loadingProvider.setLoading(false);
                                  catchErrorLogin(context, err);
                                });
                              }else if(selectedRole == 'Student') {
                                _sAuthService.login(username, password).then((value) {
                                  loadingProvider.setLoading(false);
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => const SExam()));
                                }).catchError((err) {
                                  loadingProvider.setLoading(false);
                                  catchErrorLogin(context, err);
                                });
                              }else if(selectedRole == 'Admin') {
                                _aAuthService.login(username, password).then((value) {
                                  loadingProvider.setLoading(false);
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => const ATeacher()));
                                }).catchError((err) {
                                  loadingProvider.setLoading(false);
                                  catchErrorLogin(context, err);
                                });
                              }else if(selectedRole == 'Supervisor') {
                                _pAuthService.login(username, password).then((value) {
                                  loadingProvider.setLoading(false);
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => const PExam()));
                                }).catchError((err) {
                                  loadingProvider.setLoading(false);
                                  catchErrorLogin(context, err);
                                });
                              }else{
                                loadingProvider.setLoading(false);
                                showTopSnackBar(
                                  Overlay.of(context),
                                  const CustomSnackBar.error(
                                    message: "Role tidak valid",
                                  )
                                );
                              }
                            },
                            style: const ButtonStyle(
                              elevation: MaterialStatePropertyAll(0),
                              padding: MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0)),
                              minimumSize: MaterialStatePropertyAll(Size(double.infinity, 48)),
                              maximumSize: MaterialStatePropertyAll(Size(double.infinity, double.infinity)),
                            ),
                            child: Text(loadingProvider.isLoading ? "Loading..." : "Login")
                          );
                        }
                      )
                    ],
                  ),
                ),
              ),
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
      onFieldSubmitted: (v) {
        FocusScope.of(context).requestFocus(focusNext);
      },
      decoration: InputDecoration(
        hintText: hint,
        border: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.green),
        ),
        filled: true,
        fillColor: Colors.transparent,
      ),
    );
  }
}

void catchErrorLogin(BuildContext context, err) {
  if (err is DioError) {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.error(
        message: (err.response != null) ? err.response?.data['error'] : "Terjadi kesalahan, periksa koneksi internetmu",
      )
    );
  }else{
    showTopSnackBar(
      Overlay.of(context),
      const CustomSnackBar.error(
        message: "Terjadi kesalahan",
      )
    );
  }
}