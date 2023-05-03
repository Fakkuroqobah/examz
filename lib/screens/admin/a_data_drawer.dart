import 'package:flutter/material.dart';

import '../../services/admin/a_auth_service.dart';
import '../auth/login.dart';
import 'a_exam.dart';
import 'a_room.dart';
import 'a_schedule.dart';
import 'a_student.dart';
import 'a_student_schedule.dart';
import 'a_supervisor.dart';
import 'a_teacher.dart';

List<Widget> dataDrawer(BuildContext context, AAuthService aAuthService) {
  final List<Widget> data = [
    GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const ATeacher()));
      },
      child: const Text(
        "Daftar Guru",
        style: TextStyle(
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),

    GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const AStudent()));
      },
      child: const Text(
        "Daftar Siswa",
        style: TextStyle(
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),

    GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const ASupervisor()));
      },
      child: const Text(
        "Daftar Pengawas",
        style: TextStyle(
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),

    GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const ARoom()));
      },
      child: const Text(
        "Daftar Ruangan",
        style: TextStyle(
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),

    GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const ASchedule()));
      },
      child: const Text(
        "Daftar Jadwal",
        style: TextStyle(
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),

    GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const AStudentSchedule()));
      },
      child: const Text(
        "Daftar Jadwal Siswa",
        style: TextStyle(
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),

    GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const AExam()));
      },
      child: const Text(
        "Daftar Ujian",
        style: TextStyle(
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),

    GestureDetector(
      onTap: () {
        aAuthService.logout().then((value) {
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
