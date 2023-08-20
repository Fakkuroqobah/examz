import 'package:fancy_drawer/fancy_drawer.dart';
import 'package:flutter/material.dart';

import '../../services/student/s_auth_service.dart';
import '../auth/login.dart';
import 's_exam_finished.dart';
import 's_exam_launched.dart';

class SExam extends StatefulWidget {
  const SExam({super.key});

  @override
  State<SExam> createState() => _SExamState();
}

class _SExamState extends State<SExam> with SingleTickerProviderStateMixin {
  final SAuthService _sAuthService = SAuthService();
  late FancyDrawerController _controllerDrawer;

  int _selectedIndex = 0;

  void _changeSelectedIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final _pageOptions = const [
    SExamLaunched(),
    SExamFinished(),
  ];

  @override
  void initState() {
    super.initState();
    _controllerDrawer = FancyDrawerController(
        vsync: this, duration: const Duration(milliseconds: 250))
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controllerDrawer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: FancyDrawerWrapper(
        backgroundColor: Colors.green,
        drawerPadding: const EdgeInsets.only(left: 26.0),
        controller: _controllerDrawer,
        drawerItems: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const SExam()));
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
              _sAuthService.logout().then((value) {
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
        ],
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Daftar Ujian"),
            elevation: 0,
            leading: IconButton(
              icon: const Icon(
                Icons.menu,
                color: Colors.white,
              ),
              onPressed: () {
                _controllerDrawer.toggle();
              },
            ),
          ),
          body: _pageOptions[_selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
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
        ),
      ),
    );
  }
}