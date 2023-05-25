import 'package:flutter/material.dart';

import '../../models/exam_group_model.dart';
import '../../models/exam_model.dart';
import '../../services/teacher/t_exam_service.dart';

import '../../widgets/empty_condition.dart';
import '../../widgets/t_exam_card.dart';

class TExamLaunched extends StatefulWidget {
  const TExamLaunched({super.key});

  @override
  State<TExamLaunched> createState() => _TExamLaunchedState();
}

class _TExamLaunchedState extends State<TExamLaunched> {
  final TExamService _tExamService = TExamService();
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
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refresh,
        child: FutureBuilder(
          future: _tExamService.getExam(),
          builder: (BuildContext ctx, AsyncSnapshot<ExamGroupModel> snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text("Terjadi kesalahan dengan pesan : ${snapshot.error.toString()}"));
            } else if (snapshot.connectionState == ConnectionState.done) {
              List<ExamModel>? exam = snapshot.data?.examLaunched;
              return (snapshot.data!.sumExamLaunched > 0) ? Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(height: 8.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Text("Jumlah ujian: ${snapshot.data?.sumExamLaunched}", 
                      style: const TextStyle(fontSize: 16.0, color: Colors.grey),
                    ),
                  ),
                  const Divider(),
                  
                  const SizedBox(height: 8.0),
                  Expanded(child: _buildListView(context, exam)),
                ],
              ) : const EmptyCondition();
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }
        ),
      )
    );
  }

  ListView _buildListView(context, List<ExamModel>? exam) {
    return ListView.builder(
      itemCount: exam?.length,
      itemBuilder: (ctx, index) {
        ExamModel data = exam![index];

        return TExamCard(exam: data);
      },
    );
  }
}