import 'package:flutter/material.dart';

import '../../configs/api.dart';
import '../../models/teacher/t_exam_model.dart';
import '../../services/teacher/t_exam_service.dart';

import '../../widgets/t_exam_card.dart';

class TExamInactive extends StatefulWidget {
  const TExamInactive({super.key});

  @override
  State<TExamInactive> createState() => _TExamInactiveState();
}

class _TExamInactiveState extends State<TExamInactive> {
  final Api _api = Api();
  final TExamService _tExamService = TExamService();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  
  Future<void> _refresh() async {
    setState(() {});
  }
  
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _refreshIndicatorKey.currentState?.show());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refresh,
        child: FutureBuilder(
          future: _tExamService.getExam(),
          builder: (BuildContext ctx, AsyncSnapshot<TExamModel> snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text("Something wrong with message: ${snapshot.error.toString()}"));
            } else if (snapshot.connectionState == ConnectionState.done) {
              List<Exam>? exam = snapshot.data?.examInActive;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text("Jumlah ujian: ${snapshot.data?.sumExamInActive}", 
                      style: const TextStyle(fontSize: 18.0),
                    ),
                  ),
                  
                  const SizedBox(height: 8.0),
                  Expanded(child: _buildListView(context, exam)),
                ],
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }
        ),
      )
    );
  }

  ListView _buildListView(context, List<Exam>? exam) {
    return ListView.builder(
      itemCount: exam?.length,
      itemBuilder: (ctx, index) {
        Exam data = exam![index];
        
        String src = _api.tBaseUrlAsset + data.thumbnail;
        data.thumbnail = src;

        return TExamCard(exam: data);
      },
    );
  }
}