import 'package:flutter/material.dart';

import '../../configs/utils.dart';
import '../../models/teacher/t_exam_model.dart';

import 's_exam_question.dart';

class SExamDetail extends StatefulWidget {
  const SExamDetail({super.key, required this.data});

  final Exam data;

  @override
  State<SExamDetail> createState() => _SExamDetailState();
}

class _SExamDetailState extends State<SExamDetail> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  final TextEditingController txtToken = TextEditingController();
  
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
      appBar: AppBar(
        title: const Text("Detail Ujian"),
        elevation: 0,
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refresh,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(widget.data.thumbnail, width: 80.0),

                      const SizedBox(width: 12.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.data.name),

                          const SizedBox(width: 8.0),
                          Text("Kelas ${widget.data.examClass}",
                            style: TextStyle(color: Colors.black.withOpacity(0.6)),
                          ),

                          const SizedBox(height: 8.0),
                          Text("Tanggal Publish : ${Utils.getFormatedDate(widget.data.createdAt)}", style: const TextStyle(
                            fontSize: 12.0
                          )),

                          const SizedBox(height: 8.0),
                          Text("Acak Soal : ${widget.data.isRandom == 0 ? "Tidak" : "Iya"}", 
                            style: const TextStyle(fontSize: 12.0)
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Token Ujian'),
                            content: TextField(
                              onChanged: (value) {
                                setState(() {
                                  
                                });
                              },
                              controller: txtToken,
                              decoration: const InputDecoration(hintText: "Masukan Token Ujian"),
                            ),
                            actions: <Widget>[
                              ElevatedButton(
                                style: const ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll<Color>(Colors.grey),
                                  elevation: MaterialStatePropertyAll(0)
                                ),
                                child: const Text('Batal'),
                                onPressed: () {
                                  setState(() {
                                    Navigator.pop(context);
                                  });
                                },
                              ),
                              ElevatedButton(
                                style: const ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll<Color>(Colors.green),
                                  elevation: MaterialStatePropertyAll(0)
                                ),
                                child: const Text('Mulai Ujian'),
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const SExamQuestion()));
                                },
                              ),
                            ],
                          );
                        }
                      );
                    },
                    child: const Text("Mulai Ujian")
                  ),
                ],
              )
            ],
          ),
        ),
      )
    );
  }
}