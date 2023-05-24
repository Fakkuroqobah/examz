import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../models/answer_option_model.dart';
import '../models/question_model.dart';

class QuestionCardStudent extends StatefulWidget {
  const QuestionCardStudent({super.key, required this.data, required this.number});

  final QuestionModel data;
  final int number;

  @override
  State<QuestionCardStudent> createState() => _QuestionCardStudentState();
}

class _QuestionCardStudentState extends State<QuestionCardStudent> {
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
                  data: widget.data.subject,
                  style: {
                    "body": Style(
                      padding: const EdgeInsets.all(0),
                      margin: const EdgeInsets.all(0),
                    ),
                    "p": Style(
                      margin: const EdgeInsets.only(top: 0, bottom: 0),
                    ),
                  }
                ),
              ],
            ),
            
            const Divider(),
            SizedBox(
              height: 200.0,
              child: ListView.builder(
                itemCount: widget.data.answerOption.length,
                itemBuilder: (_, index) {
                  AnswerOptionModel answerOption = widget.data.answerOption[index];
                  List<String> al = ['A', 'B', 'C', 'D', 'E'];
                  Text option;

                  if(widget.data.answer == answerOption.id) {
                    if(answerOption.correct == 1) {
                      option = Text(al[index], style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)) ;
                    }else{
                      option = Text(al[index], style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold)) ;
                    }
                  }else {
                    if(answerOption.correct == 1) {
                      option = Text(al[index], style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)) ;
                    }else{
                      option = Text(al[index], style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)) ;
                    }
                  }
                  
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                        fit: FlexFit.loose,
                        child: option
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
          ],
        ),
      ),
    );
  }
}