import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/teacher/t_exam_model.dart';
import '../../provider/teacher/t_exam_provider.dart';

import '../../widgets/empty_condition.dart';
import '../../widgets/t_exam_card.dart';

class TExamInactive extends StatefulWidget {
  const TExamInactive({super.key});

  @override
  State<TExamInactive> createState() => _TExamInactiveState();
}

class _TExamInactiveState extends State<TExamInactive> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  
  Future<void> _refresh() async {
    Provider.of<TExamProvider>(context, listen: false).getExamInactive();
  }
  
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TExamProvider>(context, listen: false).getExamInactive();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refresh,
        child: Consumer<TExamProvider>(
          builder: (_, tExamI, __) {
            if(tExamI.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if(tExamI.hasError) {
              return const Center(child: Text("Terjadi kesalahan pada server"));
            }
            
            return (tExamI.examList.sumExamInActive > 0) ? Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(height: 8.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Text("Jumlah ujian: ${tExamI.examList.sumExamInActive}", 
                    style: const TextStyle(fontSize: 16.0, color: Colors.grey),
                  ),
                ),
                const Divider(),
                
                const SizedBox(height: 8.0),
                Expanded(child: _buildListView(context, tExamI.examList.examInActive)),
              ],
            ) : const EmptyCondition();
          },
        ),
      )
    );
  }

  ListView _buildListView(context, List<Exam> exam) {
    return ListView.builder(
      itemCount: exam.length,
      itemBuilder: (ctx, index) {
        Exam data = exam[index];

        return TExamCard(exam: data);
      },
    );
  }
}