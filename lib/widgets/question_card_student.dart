import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../models/answer_option_model.dart';
import '../models/answer_student_model.dart';
import '../models/question_model.dart';

class QuestionCardStudent extends StatefulWidget {
  const QuestionCardStudent({super.key, required this.data, required this.answerStudent, required this.number, required this.role});

  final QuestionModel data;
  final AnswerStudentModel? answerStudent;
  final int number;
  final role;

  @override
  State<QuestionCardStudent> createState() => _QuestionCardStudentState();
}

class _QuestionCardStudentState extends State<QuestionCardStudent> {
  final TextEditingController txtRateEssay = TextEditingController();

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Soal ${widget.number}", style: const TextStyle(fontWeight: FontWeight.bold)),
                    generateScore()
                  ],
                ),

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
            (widget.data.type == 'choice') ? SizedBox(
              height: 200.0,
              child: ListView.builder(
                itemCount: widget.data.answerOption!.length,
                itemBuilder: (_, index) {
                  AnswerOptionModel answerOption = widget.data.answerOption![index];
                  List<String> al = ['A', 'B', 'C', 'D', 'E'];
                  Text option;

                  if(widget.answerStudent!.answerOptionId == answerOption.id) {
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
            ) : SizedBox(
              height: 200.0,
              child: ListView(
                children: [
                  const Text("Ekspektasi Jawaban", style: TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8.0),
                  Html(
                    data: widget.data.answerEssay?.defaultAnswer ?? '',
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

                  const Divider(),
                  const Text("Jawaban Siswa", style: TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8.0),
                  Html(
                    data: widget.answerStudent?.answerEssay ?? '',
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget generateScore() {
    if(widget.data.type == 'choice') {
      for (var el in widget.data.answerOption!) {
        if(widget.answerStudent!.answerOptionId == el.id) {
          if(el.correct == 1) {
            return Text("${widget.answerStudent?.score ?? 0}/${widget.data.score}", 
              style: const TextStyle(fontWeight: FontWeight.bold)
            );
          }
        }
      }

      return Text("0/${widget.data.score}");
    }else{
      return ElevatedButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Soal ${widget.number}'),
                content: TextFormField(
                  controller: txtRateEssay,
                  decoration: const InputDecoration(hintText: "Masukan nilai essai"),
                  maxLength: 5,
                ),
                actions: <Widget>[
                  ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll<Color>(Colors.grey),
                      elevation: MaterialStatePropertyAll(0)
                    ),
                    child: const Text('Batal'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll<Color>(Colors.green),
                      elevation: MaterialStatePropertyAll(0)
                    ),
                    child: const Text('Simpan'),
                    onPressed: () {
                      Navigator.pop(context);
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
        child: const Text("Beri nilai")
      );
    }
  }
}