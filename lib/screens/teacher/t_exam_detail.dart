import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';

import '../../configs/api.dart';
import '../../configs/utils.dart';
import '../../models/exam_model.dart';
import '../../models/question_model.dart';
import '../../provider/teacher/t_question_provider.dart';
import '../../widgets/empty_condition.dart';
import '../../widgets/question_card.dart';
import 't_question_add_choice.dart';
import 't_question_add_essay.dart';

class TExamDetail extends StatefulWidget {
  const TExamDetail({super.key, required this.data});

  final ExamModel data;

  @override
  State<TExamDetail> createState() => _TExamDetailState();
}

class _TExamDetailState extends State<TExamDetail> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  final Api _api = Api();
  
  Future<void> _refresh() async {
    Provider.of<TQuestionProvider>(context, listen: false).getQuestion(widget.data.id);
  }
  
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TQuestionProvider>(context, listen: false).getQuestion(widget.data.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Ujian"),
        elevation: 0,
        actions: [
          (widget.data.status == 'inactive') ? IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Tambah Pertanyaan',
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) {
                  return AlertDialog(
                    title: const Text("Pilih tipe soal"),
                    content: const Text("Silahkan pilih tipe soal yang ingin kamu buat"),
                    actions: <Widget>[
                      ElevatedButton(
                        style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll<Color>(Colors.green),
                          elevation: MaterialStatePropertyAll(0)
                        ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => TQuestionAddChoice(id: widget.data.id)));
                        },
                        child: const Text("Pilgan"),
                      ),
                      ElevatedButton(
                        style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll<Color>(Colors.green),
                          elevation: MaterialStatePropertyAll(0)
                        ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => TQuestionAddEssay(id: widget.data.id)));
                        },
                        child: const Text("Essai"),
                      ),
                      ElevatedButton(
                        style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll<Color>(Colors.grey),
                          elevation: MaterialStatePropertyAll(0)
                        ),
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
          ) : Container()
        ],
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
                            Image.network(_api.tBaseUrlAsset + widget.data.thumbnail, width: 100.0),
        
                            const SizedBox(width: 12.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 200.0,
                                  child: Wrap(
                                    children: [
                                      Text(widget.data.name, 
                                        style: const TextStyle(fontSize: 18.0)
                                      ),
                                    ],
                                  ),
                                ),

                                const SizedBox(height: 8.0),
                                Text("Kelas ${widget.data.examClass}",
                                  style: TextStyle(color: Colors.black.withOpacity(0.6)),
                                ),
        
                                const SizedBox(height: 8.0),
                                Text("Tanggal Publish : ${Utils.getFormatedDate(widget.data.createdAt)}", style: const TextStyle(
                                  fontSize: 12.0
                                )),
        
                                const SizedBox(height: 8.0),
                                Text("Waktu Ujian : ${widget.data.time} Menit", 
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
        
                        widget.data.description != null ?
                        Html(
                          data: widget.data.description,
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("Daftar Soal"),
                    ],
                  ),
                ),
        
                const SizedBox(height: 8.0),
                Consumer<TQuestionProvider>(
                  builder: (_, tQuestion, __) {
                    List<QuestionModel>? tQuestionModel = tQuestion.questionList;
                    int number = 1;
        
                    if(tQuestion.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
        
                    if(tQuestion.hasError) {
                      return const Center(child: Text("Terjadi kesalahan pada server"));
                    }
        
                    if(tQuestionModel.isEmpty) {
                      return const EmptyCondition();
                    }
        
                    return Column(
                      children: [
                        for (QuestionModel val in tQuestionModel) 
                          QuestionCard(exam: widget.data, question: val, number: number++),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}