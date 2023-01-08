import 'package:flutter/material.dart';

import '../../configs/utils.dart';
import '../../models/teacher/t_exam_model.dart';
import '../../services/teacher/t_auth_service.dart';

import '../../widgets/question_card.dart';
import '../auth/login.dart';
import 't_question_add.dart';

class TExamDetail extends StatefulWidget {
  const TExamDetail({super.key, required this.data});

  final Exam data;

  @override
  State<TExamDetail> createState() => _TExamDetailState();
}

class _TExamDetailState extends State<TExamDetail> {
  final TAuthService _tAuthService = TAuthService();
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
      appBar: AppBar(
        title: const Text("Detail Ujian"),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Tambah Pertanyaan',
            onPressed: () async {
              String refresh = await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const TQuestionAdd()));
              if(refresh == 'refresh') {
                setState(() {});
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Keluar',
            onPressed: () {
              _tAuthService.logout().then((value) {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => const Login()));
              });
            },
          ),
        ],
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
                          Text("Tanggal Mulai : ${widget.data.starts != null ? Utils.getFormatedDate(widget.data.starts) : 'Belum diatur'}", style: const TextStyle(
                            fontSize: 12.0
                          )),

                          const SizedBox(height: 8.0),
                          Text("Tanggal Selesai : ${widget.data.due != null ? Utils.getFormatedDate(widget.data.due) : 'Belum diatur'}", style: const TextStyle(
                            fontSize: 12.0
                          )),

                          const SizedBox(height: 8.0),
                          Text("Waktu : ${widget.data.hours ?? 0} Jam ${widget.data.minutes ?? 0} Menit", 
                            style: const TextStyle(fontSize: 12.0)
                          ),

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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("Daftar Soal"),
                ],
              ),

              const SizedBox(height: 8.0),
              Expanded(
                child: ListView(
                  children: const [
                    QuestionCard(),
                    QuestionCard(),
                    QuestionCard(),
                    QuestionCard(),
                    QuestionCard(),
                  ],
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}