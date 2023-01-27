import 'package:flutter/material.dart';

class SExamQuestionBody extends StatefulWidget {
  const SExamQuestionBody({super.key, required this.title});

  final String title;

  @override
  State<SExamQuestionBody> createState() => _SExamQuestionBodyState();
}

class _SExamQuestionBodyState extends State<SExamQuestionBody> {
  int isChecked = 0;

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
              const Text("This is free code for a flutter quiz app. all you need is just set up firebase for this project.", style: TextStyle(color: Colors.black54)),

              const SizedBox(height: 22.0),
              btnAnswer("Shapen", 1),
              btnAnswer("Size", 2),
              btnAnswer("Rotate", 3),
              btnAnswer("Acceleration", 4),
              btnAnswer("Position", 5),
            ],
          ),
        ),
      ),
    );
  }

  Padding btnAnswer(String text, int value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: OutlinedButton(
        onPressed: () {
          setState(() {
            isChecked = value;
          });
        },
        style: OutlinedButton.styleFrom(
          backgroundColor: (isChecked == value) ? Colors.green : Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 14.0),
          alignment: Alignment.centerLeft,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
        ),
        child: Text(text,
          style: TextStyle(
            color: (isChecked == value) ? Colors.white : Colors.black54,
          ),
        ),
      ),
    );
  }
}