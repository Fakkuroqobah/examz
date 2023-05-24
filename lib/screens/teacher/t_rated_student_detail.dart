import 'package:flutter/material.dart';

import '../../models/exam_model.dart';
import '../../models/question_model.dart';
import '../../models/rated_model.dart';
import '../../models/student_schedule_model.dart';
import '../../services/teacher/t_rated_service.dart';
import '../../widgets/empty_condition.dart';
import '../../widgets/question_card_student.dart';

class TRatedStudentDetail extends StatefulWidget {
  const TRatedStudentDetail({super.key, required this.exam, required this.tRatedModel});

  final ExamModel exam;
  final StudentScheduleModel tRatedModel;

  @override
  State<TRatedStudentDetail> createState() => _TRatedStudentDetailState();
}

class _TRatedStudentDetailState extends State<TRatedStudentDetail> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  final TRatedService _tRatedService = TRatedService();
  
  Future<void> _refresh() async {
    setState(() {});
  }
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Penilaian"),
        elevation: 0,
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refresh,
        child: Center(
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder(
                future: _tRatedService.getRated(widget.tRatedModel.studentId, widget.exam.id),
                builder: (_, AsyncSnapshot<RatedModel> snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text("Terjadi kesalahan dengan pesan : ${snapshot.error.toString()}"));
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    int number = 1;
                    int total = snapshot.data!.total;
                    int totalQuestion = snapshot.data!.questions.length;
                    List<QuestionModel> questionList = snapshot.data!.questions;
          
                    return (snapshot.data!.answerStudent.isNotEmpty) ? Column(
                      children: [
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(widget.tRatedModel.student.name, style: const TextStyle(fontSize: 20.0)),
                          
                                const SizedBox(height: 6.0),
                                Text("Nilai $total/$totalQuestion", style: const TextStyle(fontSize: 16.0)),
                                          
                                const SizedBox(height: 6.0),
                                Text("Kelas ${widget.exam.examClass}",
                                  style: TextStyle(color: Colors.black.withOpacity(0.6)),
                                ),
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
                              Text("Daftar Soal & Jawaban"),
                            ],
                          ),
                        ),
          
                        const SizedBox(height: 8.0),
                        Column(
                          children: [
                            for (QuestionModel val in questionList) 
                              QuestionCardStudent(data: val, number: number++)
                          ],
                        )
                      ],
                    ) : const EmptyCondition();
                  } else {
                    return const CircularProgressIndicator();
                  }
                }
              ),
            ),
          ),
        ),
      )
    );
  }
}