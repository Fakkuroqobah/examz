import 'dart:io';

import 'package:html_editor_enhanced/html_editor.dart';
import 'package:flutter/material.dart';

import '../../services/teacher/t_exam_service.dart';

class TQuestionAdd extends StatefulWidget {
  const TQuestionAdd({super.key});

  @override
  State<TQuestionAdd> createState() => _TQuestionAddState();
}

class _TQuestionAddState extends State<TQuestionAdd> {
  bool _isLoading = false;
  final TExamService _tExamService = TExamService();
  final HtmlEditorController _controllerNarrative = HtmlEditorController();
  final HtmlEditorController _controllerSubject = HtmlEditorController();
  final HtmlEditorController _controllerQuestion1 = HtmlEditorController();
  final HtmlEditorController _controllerQuestion2 = HtmlEditorController();
  final HtmlEditorController _controllerQuestion3 = HtmlEditorController();
  final HtmlEditorController _controllerQuestion4 = HtmlEditorController();
  final HtmlEditorController _controllerQuestion5 = HtmlEditorController();

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
              const Text("Petunjuk Menjawab"),
              const SizedBox(height: 8.0),
              HtmlEditor(
                controller: _controllerNarrative,
                otherOptions: const OtherOptions(
                  height: 200,
                ),
              ),

              const SizedBox(height: 16.0),
              const Text("Pertanyaan"),
              const SizedBox(height: 8.0),
              HtmlEditor(
                controller: _controllerSubject,
                otherOptions: const OtherOptions(
                  height: 200,
                ),
              ),

              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Jawaban Soal Opsi 1"),
                  Checkbox(
                    checkColor: Colors.white,
                    fillColor: MaterialStateProperty.resolveWith(getColor),
                    value: true,
                    onChanged: (bool? value) {
                      
                    },
                  )
                ],
              ),
              const SizedBox(height: 8.0),
              HtmlEditor(
                controller: _controllerQuestion1,
                otherOptions: const OtherOptions(
                  height: 200,
                ),
              ),

              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Jawaban Soal Opsi 2"),
                  Checkbox(
                    checkColor: Colors.white,
                    fillColor: MaterialStateProperty.resolveWith(getColor),
                    value: false,
                    onChanged: (bool? value) {
                      
                    },
                  )
                ],
              ),
              const SizedBox(height: 8.0),
              HtmlEditor(
                controller: _controllerQuestion2,
                otherOptions: const OtherOptions(
                  height: 200,
                ),
              ),

              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Jawaban Soal Opsi 3"),
                  Checkbox(
                    checkColor: Colors.white,
                    fillColor: MaterialStateProperty.resolveWith(getColor),
                    value: false,
                    onChanged: (bool? value) {
                      
                    },
                  )
                ],
              ),
              const SizedBox(height: 8.0),
              HtmlEditor(
                controller: _controllerQuestion3,
                otherOptions: const OtherOptions(
                  height: 200,
                ),
              ),

              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Jawaban Soal Opsi 4"),
                  Checkbox(
                    checkColor: Colors.white,
                    fillColor: MaterialStateProperty.resolveWith(getColor),
                    value: false,
                    onChanged: (bool? value) {
                      
                    },
                  )
                ],
              ),
              const SizedBox(height: 8.0),
              HtmlEditor(
                controller: _controllerQuestion4,
                otherOptions: const OtherOptions(
                  height: 100,
                ),
              ),

              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Jawaban Soal Opsi 5"),
                  Checkbox(
                    checkColor: Colors.white,
                    fillColor: MaterialStateProperty.resolveWith(getColor),
                    value: false,
                    onChanged: (bool? value) {
                      
                    },
                  )
                ],
              ),
              const SizedBox(height: 8.0),
              HtmlEditor(
                controller: _controllerQuestion5,
                otherOptions: const OtherOptions(
                  height: 100,
                ),
              ),

              const SizedBox(height: 8.0),
              ElevatedButton(
                onPressed: () async {
                  
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