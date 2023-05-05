import 'package:flutter/material.dart';

import '../../services/supervisor/p_auth_service.dart';
import '../auth/login.dart';

List<Widget> dataDrawer(BuildContext context, PAuthService pAuthService) {
  final List<Widget> data = [
    GestureDetector(
      onTap: () {
        pAuthService.logout().then((value) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => const Login()));
        });
      },
      child: const Text(
        "Log out",
        style: TextStyle(
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  ];
  
  return data;
}
