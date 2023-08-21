import 'package:flutter/material.dart';

import '../configs/api.dart';
import '../models/student_schedule_model.dart';
import '../screens/student/s_rated.dart';

class SExamFinishedCard extends StatefulWidget {
  const SExamFinishedCard({super.key, required this.exam});

  final StudentScheduleModel exam;

  @override
  State<SExamFinishedCard> createState() => _SExamFinishedCardState();
}

class _SExamFinishedCardState extends State<SExamFinishedCard> {
  final Api _api = Api();
  
  @override
  Widget build(BuildContext context) {
    final exam = widget.exam.schedule!.exam;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          if(exam.isRated == 1) {
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => SRated(exam: exam)));
          }
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
            )
          ],
        ),
      ),
    );
  }
}