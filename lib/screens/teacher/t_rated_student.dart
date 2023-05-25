import 'package:flutter/material.dart';

import '../../models/exam_model.dart';
import '../../models/student_schedule_model.dart';
import '../../services/teacher/t_rated_service.dart';
import '../../widgets/empty_condition.dart';
import 't_rated_student_detail.dart';

class TRatedStudent extends StatefulWidget {
  const TRatedStudent({super.key, required this.data});

  final ExamModel data;

  @override
  State<TRatedStudent> createState() => _TRatedStudentState();
}

class _TRatedStudentState extends State<TRatedStudent> with SingleTickerProviderStateMixin {
  final TRatedService _tRatedService = TRatedService();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  Future<void> _refresh() async {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Penilaian"),
        elevation: 0,
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refresh,
        child: FutureBuilder(
          future: _tRatedService.getStudent(widget.data.id, widget.data.examClass),
          builder: (_, AsyncSnapshot<List<StudentScheduleModel>> snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text("Terjadi kesalahan dengan pesan : ${snapshot.error.toString()}"));
            } else if (snapshot.connectionState == ConnectionState.done) {
              List<StudentScheduleModel>? exam = snapshot.data;
              return (snapshot.data!.isNotEmpty) ? ListView.builder(
                itemCount: exam?.length,
                itemBuilder: (ctx, index) {
                  StudentScheduleModel data = exam![index];

                  return ListTile(
                    leading: const Icon(Icons.person),
                    title: Text(data.student!.name),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => TRatedStudentDetail(exam: widget.data, tRatedModel: data)));
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
    );
  }
}