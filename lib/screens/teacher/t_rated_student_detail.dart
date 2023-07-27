import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/answer_student_model.dart';
import '../../models/exam_model.dart';
import '../../models/question_model.dart';
import '../../models/student_schedule_model.dart';
import '../../provider/teacher/t_rated_provider.dart';
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
  
  Future<void> _refresh() async {
    Provider.of<TRatedProvider>(context, listen: false).getRated(widget.tRatedModel.studentId, widget.exam.id);
  }
  
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TRatedProvider>(context, listen: false).getRated(widget.tRatedModel.studentId, widget.exam.id);
    });
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
              child: Consumer<TRatedProvider>(
                builder: (_, tRatedProvider, __) {
                  if(tRatedProvider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if(tRatedProvider.hasError) {
                    return const Center(child: Text("Terjadi kesalahan pada server"));
                  }

                  int number = 1;
                  int total = tRatedProvider.ratedModel.total;
                  int totalQuestion = tRatedProvider.ratedModel.questions.length;
                  List<QuestionModel> questionList = tRatedProvider.ratedModel.questions;
                  List<AnswerStudentModel> answerStudentList = tRatedProvider.ratedModel.answerStudent;

                  return (tRatedProvider.ratedModel.answerStudent.isNotEmpty) ? Column(
                    children: [
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(widget.tRatedModel.student!.name, style: const TextStyle(fontSize: 20.0)),
                        
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
                        children: generateQuestionCardStudent(questionList, answerStudentList, number),
                      )
                    ],
                  ) : const EmptyCondition();
                },
              )
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
      
      data.add(QuestionCardStudent(data: val, answerStudent: answerStudent, number: number++, role: 'teacher'));
    }

    return data;
  }
}