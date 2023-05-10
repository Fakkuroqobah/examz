import 'package:flutter/material.dart';

import '../configs/api.dart';
import '../models/student/s_exam_model.dart';
import '../screens/student/s_exam_detail.dart';

class SExamLaunchedCard extends StatefulWidget {
  const SExamLaunchedCard({super.key, required this.exam});

  final SExamModel exam;

  @override
  State<SExamLaunchedCard> createState() => _SExamLaunchedCardState();
}

class _SExamLaunchedCardState extends State<SExamLaunchedCard> {
  final Api _api = Api();
  
  @override
  Widget build(BuildContext context) {
    final exam = widget.exam.schedule.exam;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => SExamDetail(data: widget.exam)));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: Image.network(_api.tBaseUrlAsset + exam.thumbnail),
              title: Text(exam.name),
              subtitle: Text("Kelas ${exam.examClass}",
                style: TextStyle(color: Colors.black.withOpacity(0.6)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}