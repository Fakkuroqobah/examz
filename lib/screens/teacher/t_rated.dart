import 'package:fancy_drawer/fancy_drawer.dart';
import 'package:flutter/material.dart';

import '../../models/exam_model.dart';
import '../../services/teacher/t_auth_service.dart';
import '../../services/teacher/t_rated_service.dart';
import '../../widgets/empty_condition.dart';
import '../auth/login.dart';
import 't_exam.dart';
import 't_rated_student.dart';

class TRated extends StatefulWidget {
  const TRated({super.key});

  @override
  State<TRated> createState() => _TRatedState();
}

class _TRatedState extends State<TRated> with SingleTickerProviderStateMixin {
  final TAuthService _tAuthService = TAuthService();
  final TRatedService _tRatedService = TRatedService();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  late FancyDrawerController _controllerDrawer;

  Future<void> _refresh() async {
    setState(() {});
  }

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
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const TExam()));
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
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const TRated()));
            },
            child: const Text(
              "Penilaian",
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          GestureDetector(
            onTap: () {
              _tAuthService.logout().then((value) {
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
            title: const Text("Penilaian"),
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
          body: RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: _refresh,
            child: FutureBuilder(
              future: _tRatedService.getExam(),
              builder: (_, AsyncSnapshot<List<ExamModel>> snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text("Terjadi kesalahan dengan pesan : ${snapshot.error.toString()}"));
                } else if (snapshot.connectionState == ConnectionState.done) {
                  List<ExamModel>? exam = snapshot.data;
                  return (snapshot.data!.isNotEmpty) ? ListView.builder(
                    itemCount: exam?.length,
                    itemBuilder: (ctx, index) {
                      ExamModel data = exam![index];

                      return ListTile(
                        leading: const Icon(Icons.book),
                        title: Text(data.name),
                        subtitle: Text("Kelas ${data.examClass}"),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => TRatedStudent(data: data)));
                        },
                      );
                    },
                  ) : const EmptyCondition();
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }
            ),
          ),
        ),
      ),
    );
  }
}