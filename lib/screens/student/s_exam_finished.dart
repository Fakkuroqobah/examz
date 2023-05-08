import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/student/s_exam_model.dart';
import '../../provider/student/s_exam_provider.dart';

import '../../widgets/empty_condition.dart';
import '../../widgets/s_exam_card.dart';

class SExamFinished extends StatefulWidget {
  const SExamFinished({super.key});

  @override
  State<SExamFinished> createState() => _SExamFinishedState();
}

class _SExamFinishedState extends State<SExamFinished> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  
  Future<void> _refresh() async {
    Provider.of<SExamProvider>(context, listen: false).getExamFinished();
  }
  
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SExamProvider>(context, listen: false).getExamFinished();
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
            
            return (sExam.examFinishedList.isNotEmpty) ? Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(height: 8.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Text("Jumlah ujian: ${sExam.examFinishedList.length}", 
                    style: const TextStyle(fontSize: 16.0, color: Colors.grey),
                  ),
                ),
                const Divider(),
                
                const SizedBox(height: 8.0),
                Expanded(child: _buildListView(context, sExam.examFinishedList)),
              ],
            ) : const EmptyCondition();
          },
        ),
      ),
    );
  }

  ListView _buildListView(context, List<SExamModel>? exam) {
    return ListView.builder(
      itemCount: exam?.length,
      itemBuilder: (ctx, index) {
        SExamModel data = exam![index];

        return SExamCard(exam: data);
      },
    );
  }
}