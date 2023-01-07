import 'package:flutter/material.dart';

import '../../services/teacher/t_auth_service.dart';
import 't_exam_active.dart';
import 't_exam_inactive.dart';
import 't_exam_add.dart';
import '../auth/login.dart';

class TExam extends StatefulWidget {
  const TExam({super.key});

  @override
  State<TExam> createState() => _TExamState();
}

class _TExamState extends State<TExam> {
  final TAuthService _tAuthService = TAuthService();

  int _selectedIndex = 0;

  void _changeSelectedIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final _pageOptions = const [
    TExamInactive(),
    TExamActive(),
    TExamInactive(),
    TExamInactive(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Ujian"),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Tambah Ujian',
            onPressed: () async {
              String refresh = await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const TExamAdd()));
              if(refresh == 'refresh') {
                setState(() {});
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Keluar',
            onPressed: () {
              _tAuthService.logout().then((value) {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => const Login()));
              });
            },
          ),
        ],
      ),
      body: _pageOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Nonaktif',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'Aktif',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_turned_in),
            label: 'Berlangsung',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.done),
            label: 'Selesai',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _changeSelectedIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}