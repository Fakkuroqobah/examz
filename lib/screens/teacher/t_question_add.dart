import 'package:flutter/material.dart';

import '../../services/teacher/t_question_service.dart';

class TQuestionAdd extends StatefulWidget {
  const TQuestionAdd({super.key, required this.id});

  final int id;

  @override
  State<TQuestionAdd> createState() => _TQuestionAddState();
}

class _TQuestionAddState extends State<TQuestionAdd> {
  bool _isLoading = false;
  final TQuestionService _tQuestionService = TQuestionService();
  final TextEditingController _controllerSubject = TextEditingController();
  final TextEditingController _controllerQuestion1 = TextEditingController();
  final TextEditingController _controllerQuestion2 = TextEditingController();
  final TextEditingController _controllerQuestion3 = TextEditingController();
  final TextEditingController _controllerQuestion4 = TextEditingController();
  final TextEditingController _controllerQuestion5 = TextEditingController();

  bool valOption1 = false;
  bool valOption2 = false;
  bool valOption3 = false;
  bool valOption4 = false;
  bool valOption5 = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Pertanyaan"),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16.0),
              const Text("Pertanyaan"),

              const SizedBox(height: 8.0),
              TextField(
                controller: _controllerSubject,
                maxLines: null,
                keyboardType: TextInputType.multiline,
              ),

              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Jawaban Soal Opsi 1"),
                  Checkbox(
                    checkColor: Colors.white,
                    fillColor: MaterialStateProperty.resolveWith(getColor),
                    value: valOption1,
                    onChanged: (bool? value) {
                      setState(() {
                        valOption1 = value ?? false;
                      });
                    },
                  )
                ],
              ),
              const SizedBox(height: 8.0),
              TextField(
                controller: _controllerQuestion1,
                maxLines: null,
                keyboardType: TextInputType.multiline,
              ),

              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Jawaban Soal Opsi 2"),
                  Checkbox(
                    checkColor: Colors.white,
                    fillColor: MaterialStateProperty.resolveWith(getColor),
                    value: valOption2,
                    onChanged: (bool? value) {
                      setState(() {
                        valOption2 = value ?? false;
                      });
                    },
                  )
                ],
              ),
              const SizedBox(height: 8.0),
              TextField(
                controller: _controllerQuestion2,
                maxLines: null,
                keyboardType: TextInputType.multiline,
              ),

              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Jawaban Soal Opsi 3"),
                  Checkbox(
                    checkColor: Colors.white,
                    fillColor: MaterialStateProperty.resolveWith(getColor),
                    value: valOption3,
                    onChanged: (bool? value) {
                      setState(() {
                        valOption3 = value ?? false;
                      });
                    },
                  )
                ],
              ),
              const SizedBox(height: 8.0),
              TextField(
                controller: _controllerQuestion3,
                maxLines: null,
                keyboardType: TextInputType.multiline,
              ),

              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Jawaban Soal Opsi 4"),
                  Checkbox(
                    checkColor: Colors.white,
                    fillColor: MaterialStateProperty.resolveWith(getColor),
                    value: valOption4,
                    onChanged: (bool? value) {
                      setState(() {
                        valOption4 = value ?? false;
                      });
                    },
                  )
                ],
              ),
              const SizedBox(height: 8.0),
              TextField(
                controller: _controllerQuestion4,
                maxLines: null,
                keyboardType: TextInputType.multiline,
              ),

              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Jawaban Soal Opsi 5"),
                  Checkbox(
                    checkColor: Colors.white,
                    fillColor: MaterialStateProperty.resolveWith(getColor),
                    value: valOption5,
                    onChanged: (bool? value) {
                      setState(() {
                        valOption5 = value ?? false;
                      });
                    },
                  )
                ],
              ),
              const SizedBox(height: 8.0),
              TextField(
                controller: _controllerQuestion5,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                
              ),

              const SizedBox(height: 8.0),
              ElevatedButton(
                onPressed: () async {
                  setState(() => _isLoading = true);

                  String subject = _controllerSubject.text.toString();
                  String option1 = _controllerQuestion1.text.toString();
                  String option2 = _controllerQuestion2.text.toString();
                  String option3 = _controllerQuestion3.text.toString();
                  String option4 = _controllerQuestion4.text.toString();
                  String option5 = _controllerQuestion5.text.toString();

                  Map<String, dynamic> answer = {
                    "0": {
                      "answer_option": option1,
                      "answer_correct": valOption1
                    },
                    "1": {
                      "answer_option": option2,
                      "answer_correct": valOption2
                    },
                    "2": {
                      "answer_option": option3,
                      "answer_correct": valOption3
                    },
                    "3": {
                      "answer_option": option4,
                      "answer_correct": valOption4
                    },
                    "4": {
                      "answer_option": option5,
                      "answer_correct": valOption5
                    }
                  };

                  _tQuestionService.addQuestion(widget.id, subject, answer).then((value) {
                    setState(() => _isLoading = false);
                    Navigator.pop(context, 'refresh');
                  }).catchError((err) {
                    setState(() => _isLoading = false);
                    SnackBar snackBar = const SnackBar(content: Text("Terjadi Kesalahan"));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  });
                },
                child: Text(_isLoading ? "Loading..." : "Tambah Pertanyaan")
              )
            ],
          ),
        ),
      ),
    );
  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.grey;
    }
    return Colors.green;
  }
}