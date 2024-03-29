import 'package:flutter/material.dart';

import '../../models/answer_student_model.dart';
import '../../models/exam_model.dart';
import '../../models/question_model.dart';
import '../../models/rated_model.dart';
import '../../services/student/s_rated_service.dart';
import '../../widgets/empty_condition.dart';
import '../../widgets/question_card_student.dart';

class SRated extends StatefulWidget {
  const SRated({super.key, required this.exam});

  final ExamModel exam;

  @override
  State<SRated> createState() => _SRatedState();
}

class _SRatedState extends State<SRated> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  final SRatedService _sRatedService = SRatedService();
  
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
                future: _sRatedService.getRated(widget.exam.id),
                builder: (_, AsyncSnapshot<RatedModel> snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text("Terjadi kesalahan dengan pesan : ${snapshot.error.toString()}"));
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    int number = 1;
                    int totalChoice = snapshot.data!.scoreChoice;
                    int totalEssai = snapshot.data!.scoreEssai;
                    List<QuestionModel> questionList = snapshot.data!.questions;
                    List<AnswerStudentModel> answerStudentList = snapshot.data!.answerStudent;
          
                    return (snapshot.data!.answerStudent.isNotEmpty) ? Column(
                      children: [
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(widget.exam.name, style: const TextStyle(fontSize: 20.0)),
                          
                                const SizedBox(height: 6.0),
                                Text("Nilai pilihan ganda $totalChoice", style: const TextStyle(fontSize: 16.0)),

                                const SizedBox(height: 6.0),
                                Text("Nilai esai $totalEssai", style: const TextStyle(fontSize: 16.0)),
                                          
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
                          children: generateQuestionCardStudent(questionList, answerStudentList, number),
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

  List<QuestionCardStudent> generateQuestionCardStudent(List<QuestionModel> questionList, List<AnswerStudentModel> answerStudentList, int number) {
    List<QuestionCardStudent> data = [];

    for (QuestionModel val in questionList) {
      AnswerStudentModel? answerStudent;
      if(answerStudentList.indexWhere((el) => el.questionId == val.id) != -1) {
        answerStudent = answerStudentList[answerStudentList.indexWhere((el) => el.questionId == val.id)];
      }
      
      data.add(QuestionCardStudent(data: val, answerStudent: answerStudent, number: number++, role: 'student'));
    }

    return data;
  }
}