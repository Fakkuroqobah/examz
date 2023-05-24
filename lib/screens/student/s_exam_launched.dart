import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/schedule_model.dart';
import '../../provider/student/s_exam_provider.dart';

import '../../widgets/empty_condition.dart';
import '../../widgets/s_exam_launched_card.dart';

class SExamLaunched extends StatefulWidget {
  const SExamLaunched({super.key});

  @override
  State<SExamLaunched> createState() => _SExamLaunchedState();
}

class _SExamLaunchedState extends State<SExamLaunched> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  
  Future<void> _refresh() async {
    Provider.of<SExamProvider>(context, listen: false).getExamLaunched();
  }
  
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SExamProvider>(context, listen: false).getExamLaunched();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refresh,
        child: Consumer<SExamProvider>(
          builder: (_, sExam, __) {
            if(sExam.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
          
            if(sExam.hasError) {
              return const Center(child: Text("Terjadi kesalahan pada server"));
            }
            
            return (sExam.examLaunchedList.isNotEmpty) ? Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(height: 8.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Text("Jumlah ujian: ${sExam.examLaunchedList.length}", 
                    style: const TextStyle(fontSize: 16.0, color: Colors.grey),
                  ),
                ),
                const Divider(),
                
                const SizedBox(height: 8.0),
                Expanded(child: _buildListView(context, sExam.examLaunchedList)),
              ],
            ) : const EmptyCondition();
          },
        ),
      ),
    );
  }

  ListView _buildListView(context, List<ScheduleModel>? exam) {
    return ListView.builder(
      itemCount: exam?.length,
      itemBuilder: (ctx, index) {
        ScheduleModel data = exam![index];

        return SExamLaunchedCard(exam: data);
      },
    );
  }
}