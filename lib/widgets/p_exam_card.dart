import 'package:flutter/material.dart';

import '../models/teacher/t_exam_model.dart';

class PExamCard extends StatefulWidget {
  const PExamCard({super.key, required this.exam, required this.type});

  final Exam exam;
  final String type;

  @override
  State<PExamCard> createState() => _PExamCardState();
}

class _PExamCardState extends State<PExamCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          
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
            (widget.type == "inactive") ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (ctx) {
                      return AlertDialog(
                        title: const Text("Peringatan"),
                        content: Text("Apakah kamu yakin ingin memulai ujian ${widget.exam.name}?"),
                        actions: <Widget>[
                          ElevatedButton(
                            style: const ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll<Color>(Colors.red),
                              elevation: MaterialStatePropertyAll(0)
                            ),
                            onPressed: () {
                              
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
                child: const Text("Mulai")
              ),
            ) : Container(),

            (widget.type == "launched") ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("12isq"),
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (ctx) {
                          return AlertDialog(
                            title: const Text("Peringatan"),
                            content: Text("Apakah kamu yakin ingin menghentikan ujian ${widget.exam.name}?"),
                            actions: <Widget>[
                              ElevatedButton(
                                style: const ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll<Color>(Colors.red),
                                  elevation: MaterialStatePropertyAll(0)
                                ),
                                onPressed: () {
                                  
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
                    child: const Text("Stop")
                  ),
                ],
              ),
            ) : Container(),

            (widget.type == "finished") ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Container(
                padding: const EdgeInsets.all(6.0),
                decoration: BoxDecoration(border: Border.all(color: Colors.green)),
                child: const Text("12isq", style: TextStyle(fontSize: 14.0, color: Colors.black54)),
              ),
            ) : Container()
          ],
        ),
      ),
    );
  }
}