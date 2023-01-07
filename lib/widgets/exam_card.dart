import 'package:flutter/material.dart';

import '../models/teacher/t_exam_model.dart';
import '../screens/teacher/t_exam_edit.dart';
import '../services/teacher/t_exam_service.dart';

class ExamCard extends StatefulWidget {
  const ExamCard({super.key, required this.exam});

  final Exam exam;

  @override
  State<ExamCard> createState() => _ExamCardState();
}

class _ExamCardState extends State<ExamCard> {
  final TExamService _tExamService = TExamService();
  
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          
        },
        child: Column(
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
                padding: const EdgeInsets.all(16.0),
                child: Text(widget.exam.description ?? "",
                  style: TextStyle(color: Colors.black.withOpacity(0.6)),
                ),
              )
            : Container(),
            ButtonBar(
              alignment: MainAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    String refresh = await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => TExamEdit(data: widget.exam)));
                    if(refresh == 'refresh') {
                      setState(() {});
                    }
                  },
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll<Color>(Colors.orange),
                    elevation: MaterialStatePropertyAll(0)
                  ),
                  child: const Text("Edit"),
                ),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (ctx) {
                        return AlertDialog(
                          title: const Text("Peringatan"),
                          content: Text("Apakah kamu yakin ingin menghapus ujian ${widget.exam.name}?"),
                          actions: <Widget>[
                            ElevatedButton(
                              style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll<Color>(Colors.red),
                                elevation: MaterialStatePropertyAll(0)
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                                _tExamService.deleteExam(widget.exam.id).then((value) {
                                  setState(() {});
                                  SnackBar snackBar = const SnackBar(
                                    content: Text("Hapus data berhasil"),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                }).catchError((err) {
                                  SnackBar snackBar = const SnackBar(
                                    content: Text("Terjadi Kesalahan"),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                });
                              },
                              child: const Text("Iya"),
                            ),
                            ElevatedButton(
                              child: const Text("Tidak"),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            )
                          ],
                        );
                      }
                    );
                  },
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll<Color>(Colors.red),
                    elevation: MaterialStatePropertyAll(0)
                  ),
                  child: const Text("Hapus"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}