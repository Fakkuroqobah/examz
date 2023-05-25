import 'package:flutter/material.dart';

import '../../models/student_schedule_model.dart';
import '../../services/supervisor/p_student_service.dart';
import '../../widgets/empty_condition.dart';

class PStudent extends StatefulWidget {
  const PStudent({super.key, required this.id});

  final int id;

  @override
  State<PStudent> createState() => _PStudentState();
}

class _PStudentState extends State<PStudent> with SingleTickerProviderStateMixin {
  final PStudentService _pStudentService = PStudentService();
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
        title: const Text("Daftar Siswa"),
        elevation: 0,
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refresh,
        child: FutureBuilder(
          future: _pStudentService.getStudent(widget.id),
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
                    subtitle: Text(data.block ?? 'Kosong'),
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