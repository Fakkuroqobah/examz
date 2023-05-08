import 'package:flutter/material.dart';

import '../configs/api.dart';
import '../models/student/s_exam_model.dart';
import '../screens/student/s_exam_detail.dart';

class SExamCard extends StatefulWidget {
  const SExamCard({super.key, required this.exam});

  final SExamModel exam;

  @override
  State<SExamCard> createState() => _SExamCardState();
}

class _SExamCardState extends State<SExamCard> {
  final Api _api = Api();
  
  @override
  Widget build(BuildContext context) {
    final exam = widget.exam.schedule.exam;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          if(exam.status == "launched") {
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => SExamDetail(data: widget.exam)));
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
            ),

            (exam.status == "finished") ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Container(
                padding: const EdgeInsets.all(6.0),
                decoration: BoxDecoration(border: Border.all(color: Colors.green)),
                child: const Text("Nilai: 90", style: TextStyle(fontSize: 14.0, color: Colors.black54)),
              ),
            ) : Container()
          ],
        ),
      ),
    );
  }
}