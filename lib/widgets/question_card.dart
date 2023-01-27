import 'package:flutter/material.dart';

import '../models/teacher/t_question_model.dart';

class QuestionCard extends StatefulWidget {
  const QuestionCard({super.key, required this.question});

  final TQuestionModel question;

  @override
  State<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text("${widget.question.orderNumber}.", style: const TextStyle(fontWeight: FontWeight.bold)),

                const SizedBox(width: 8.0),
                Text(widget.question.subject),
              ],
            ),
            
            const Divider(),
            SizedBox(
              height: 80.0,
              child: ListView.builder(
                itemCount: widget.question.answerOption.length,
                itemBuilder: (ctx, index) {
                  AnswerOption answerOption = widget.question.answerOption[index];
                  return (answerOption.correct != null) ? Text(answerOption.subject, style: const TextStyle(color: Colors.green)) : Text(answerOption.subject);
                },
              ),
            ),
            
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
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
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll<Color>(Colors.red),
                    elevation: MaterialStatePropertyAll(0)
                  ),
                  child: const Text("Hapus"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}