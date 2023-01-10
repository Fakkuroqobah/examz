import 'package:flutter/material.dart';

import '../models/teacher/t_exam_model.dart';
import '../screens/student/s_exam_detail.dart';

class SExamCard extends StatefulWidget {
  const SExamCard({super.key, required this.exam, required this.type});

  final Exam exam;
  final String type;

  @override
  State<SExamCard> createState() => _SExamCardState();
}

class _SExamCardState extends State<SExamCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          if(widget.type == "launched") {
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => SExamDetail(data: widget.exam)));
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: Image.network(widget.exam.thumbnail),
              title: Text(widget.exam.name),
              subtitle: Text("Kelas ${widget.exam.examClass}",
                style: TextStyle(color: Colors.black.withOpacity(0.6)),
              ),
            ),
            widget.exam.description != null ?
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(widget.exam.description ?? "",
                  style: TextStyle(color: Colors.black.withOpacity(0.6)),
                ),
              )
            : Container(),
            (widget.type == "finished") ? Padding(
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