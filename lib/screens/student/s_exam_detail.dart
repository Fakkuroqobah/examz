import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../configs/api.dart';
import '../../configs/utils.dart';
import '../../models/student/s_exam_model.dart';

import 's_exam_question.dart';

class SExamDetail extends StatefulWidget {
  const SExamDetail({super.key, required this.data});

  final SExamModel data;

  @override
  State<SExamDetail> createState() => _SExamDetailState();
}

class _SExamDetailState extends State<SExamDetail> {
  final Api _api = Api();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  final TextEditingController txtToken = TextEditingController();
  
  Future<void> _refresh() async {
    setState(() {});
  }
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final exam = widget.data.schedule.exam;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Ujian"),
        elevation: 0,
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refresh,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(_api.tBaseUrlAsset + exam.thumbnail, width: 100.0),
        
                            const SizedBox(width: 12.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 200.0,
                                  child: Wrap(
                                    children: [
                                      Text(exam.name, 
                                        style: const TextStyle(fontSize: 18.0)
                                      ),
                                    ],
                                  ),
                                ),
        
                                const SizedBox(height: 8.0),
                                Text("Kelas ${exam.examClass}",
                                  style: TextStyle(color: Colors.black.withOpacity(0.6)),
                                ),
        
                                const SizedBox(height: 8.0),
                                Text("Tanggal Publish : ${Utils.getFormatedDate(exam.createdAt)}", style: const TextStyle(
                                  fontSize: 12.0
                                )),
        
                                const SizedBox(height: 8.0),
                                Text("Waktu Ujian : ${exam.time} Menit", 
                                  style: const TextStyle(fontSize: 12.0)
                                ),

                                const SizedBox(height: 8.0),
                                Text("Acak Soal : ${exam.isRandom == 0 ? "Tidak" : "Iya"}", 
                                  style: const TextStyle(fontSize: 12.0)
                                ),
                              ],
                            ),
                          ],
                        ),
        
                        exam.description != null ?
                        Html(
                          data: exam.description,
                          style: {
                            "body": Style(
                              padding: const EdgeInsets.all(0),
                              margin: const EdgeInsets.all(0),
                            )
                          }
                        )
                        : Container(),
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
                      style: const ButtonStyle(
                        elevation: MaterialStatePropertyAll(0)
                      ),
                      child: const Text("Mulai Ujian")
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}