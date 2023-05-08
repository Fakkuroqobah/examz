import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';

import '../../models/student/s_question_model.dart';
import '../../provider/student/s_exam_provider.dart';

class SExamQuestionBody extends StatefulWidget {
  const SExamQuestionBody({super.key, required this.data});

  final SQuestionModel data;

  @override
  State<SExamQuestionBody> createState() => _SExamQuestionBodyState();
}

class _SExamQuestionBodyState extends State<SExamQuestionBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 18.0, right: 18.0,),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Divider(color: Colors.grey),
              const SizedBox(height: 12.0),
              Html(
                data: widget.data.subject,
                style: {
                  "body": Style(
                    padding: const EdgeInsets.all(0),
                    margin: const EdgeInsets.all(0),
                  ),
                  "p": Style(
                    padding: const EdgeInsets.all(0),
                    margin: const EdgeInsets.all(0),
                    color: Colors.black54
                  ),
                }
              ),

              const SizedBox(height: 22.0),
              for (int i = 0; i < widget.data.answerOption.length; i++)
                btnAnswer(widget.data.answerOption[i].subject, i + 1),

              const SizedBox(height: 22.0),
              ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll<Color>(Colors.grey),
                  elevation: MaterialStatePropertyAll(0)
                ),
                child: const Text('Hapus jawaban soal ini'),
                onPressed: () {
                  Provider.of<SExamProvider>(context, listen: false).answer(widget.data.id, 0);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Padding btnAnswer(String text, int value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Consumer<SExamProvider>(
        builder: (_, sExamProvider, __) {
          return OutlinedButton(
            onPressed: () {
              sExamProvider.answer(widget.data.id, value);
            },
            style: OutlinedButton.styleFrom(
              backgroundColor: (sExamProvider.answerChecked(widget.data.id) == value) ? Colors.green : Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 14.0),
              alignment: Alignment.centerLeft,
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
            ),
            child: Html(
              data: text,
              style: {
                "body": Style(
                  padding: const EdgeInsets.all(0),
                  margin: const EdgeInsets.all(0),
                ),
                "p": Style(
                  padding: const EdgeInsets.all(0),
                  margin: const EdgeInsets.all(0),
                  color: (sExamProvider.answerChecked(widget.data.id) == value) ? Colors.white : Colors.black54
                ),
              }
            ),
          );
        }
      ),
    );
  }
}