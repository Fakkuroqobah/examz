import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';

import '../../configs/api.dart';
import '../../configs/utils.dart';
import '../../models/teacher/t_exam_model.dart';

import '../../models/teacher/t_question_model.dart';
import '../../provider/teacher/t_question_provider.dart';
import '../../widgets/empty_condition.dart';
import '../../widgets/question_card.dart';
import 't_question_add.dart';

class TExamDetail extends StatefulWidget {
  const TExamDetail({super.key, required this.data});

  final Exam data;

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
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => TQuestionAdd(id: widget.data.id)));
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
                            Image.network(_api.tBaseUrlAsset + widget.data.thumbnail, width: 80.0),
        
                            const SizedBox(width: 12.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(widget.data.name, style: const TextStyle(fontSize: 18.0)),
        
                                const SizedBox(height: 8.0),
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
                    List<TQuestionModel>? tQuestionModel = tQuestion.questionList;
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
                        for (TQuestionModel val in tQuestionModel) 
                          QuestionCard(question: val, number: number++),
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