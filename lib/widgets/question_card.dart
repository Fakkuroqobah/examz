import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../models/teacher/t_exam_model.dart';
import '../models/teacher/t_question_model.dart';
import '../provider/teacher/t_question_provider.dart';
import '../screens/teacher/t_question_edit.dart';
import '../services/teacher/t_question_service.dart';

class QuestionCard extends StatefulWidget {
  const QuestionCard({super.key, required this.exam, required this.question, required this.number});

  final Exam exam;
  final TQuestionModel question;
  final int number;

  @override
  State<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  final TQuestionService _tQuestionService = TQuestionService();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Soal ${widget.number}", style: const TextStyle(fontWeight: FontWeight.bold)),

                const SizedBox(height: 8.0),
                Html(
                  data: widget.question.subject,
                  style: {
                    "body": Style(
                      padding: const EdgeInsets.all(0),
                      margin: const EdgeInsets.all(0),
                    ),
                    "p": Style(
                      margin: const EdgeInsets.all(0),
                    ),
                  }
                )
              ],
            ),
            
            const Divider(),
            SizedBox(
              height: 200.0,
              child: ListView.builder(
                itemCount: widget.question.answerOption.length,
                itemBuilder: (ctx, index) {
                  AnswerOption answerOption = widget.question.answerOption[index];
                  List<String> al = ['A', 'B', 'C', 'D', 'E'];
                  
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                        fit: FlexFit.loose,
                        child: (answerOption.correct == 1) 
                          ? Text(al[index], style: const TextStyle(color: Colors.green))
                          : Text(al[index])
                      ),
                      
                      const SizedBox(width: 8.0),
                      Expanded(
                        flex: 20,
                        child: Html(
                          data: answerOption.subject,
                          style: {
                            "body": Style(
                              padding: const EdgeInsets.all(0),
                              margin: const EdgeInsets.all(0),
                            ),
                            "p": Style(
                              margin: const EdgeInsets.only(top: 0, bottom: 10),
                            ),
                          }
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            
            (widget.exam.status == "inactive") ? Column(
              children: [
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => TQuestionEdit(data: widget.question)));
                      },
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll<Color>(Colors.orange),
                        elevation: MaterialStatePropertyAll(0)
                      ),
                      child: const Text("Edit"),
                    ),

                    const SizedBox(width: 8.0),
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (ctx) {
                            return AlertDialog(
                              title: const Text("Peringatan"),
                              content: const Text("Apakah kamu yakin ingin menghapus pertanyaan ini?"),
                              actions: <Widget>[
                                ElevatedButton(
                                  style: const ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll<Color>(Colors.red),
                                    elevation: MaterialStatePropertyAll(0)
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    _tQuestionService.deleteQuestion(widget.question.id).then((value) {
                                      Provider.of<TQuestionProvider>(context, listen: false).deleteQuestion(widget.question.id);
                                      showTopSnackBar(
                                        Overlay.of(context),
                                        const CustomSnackBar.error(
                                          message: "Pertanyaan berhasil dihapus",
                                        )
                                      );
                                    }).catchError((err) {
                                      showTopSnackBar(
                                        Overlay.of(context),
                                        const CustomSnackBar.error(
                                          message: "Terjadi kesalahan",
                                        )
                                      );
                                    });
                                  },
                                  child: const Text("Iya"),
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
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll<Color>(Colors.red),
                        elevation: MaterialStatePropertyAll(0)
                      ),
                      child: const Text("Hapus"),
                    ),
                  ],
                ),
              ],
            ) : Container(),
          ],
        ),
      ),
    );
  }
}