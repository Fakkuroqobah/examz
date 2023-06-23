import 'package:flutter/material.dart';

import 'package:html_editor_enhanced/html_editor.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../models/question_model.dart';
import '../../provider/loading_provider.dart';
import '../../provider/teacher/t_is_correct_answer_provider.dart';
import '../../provider/teacher/t_question_provider.dart';
import '../../services/teacher/t_question_service.dart';

class TQuestionEditChoice extends StatefulWidget {
  const TQuestionEditChoice({super.key, required this.data});

  final QuestionModel data;

  @override
  State<TQuestionEditChoice> createState() => _TQuestionEditChoiceState();
}

class _TQuestionEditChoiceState extends State<TQuestionEditChoice> {
  final TQuestionService _tQuestionService = TQuestionService();
  final HtmlEditorController _controllerSubject = HtmlEditorController();
  final HtmlEditorController _controllerQuestion1 = HtmlEditorController();
  final HtmlEditorController _controllerQuestion2 = HtmlEditorController();
  final HtmlEditorController _controllerQuestion3 = HtmlEditorController();
  final HtmlEditorController _controllerQuestion4 = HtmlEditorController();
  final HtmlEditorController _controllerQuestion5 = HtmlEditorController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TIsCorrectAnswerProvider>(context, listen: false).setCheckedEdit(widget.data.answerOption!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Pertanyaan Pilgan"),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Pertanyaan"),

              const SizedBox(height: 8.0),
              HtmlEditor(
                controller: _controllerSubject,
                htmlEditorOptions: HtmlEditorOptions(
                  hint: "Masukan Pertanyaan",
                  initialText: widget.data.subject
                ),
                htmlToolbarOptions: const HtmlToolbarOptions(
                  toolbarType: ToolbarType.nativeExpandable,
                ),
                otherOptions: const OtherOptions(
                  height: 300,
                ),
              ),

              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Jawaban Soal Opsi 1"),
                  Consumer<TIsCorrectAnswerProvider>(
                    builder: (_, tIsCorrectAnswerProvider, __) {
                      return Checkbox(
                        checkColor: Colors.white,
                        fillColor: MaterialStateProperty.resolveWith(getColor),
                        value: tIsCorrectAnswerProvider.isChecked[0],
                        onChanged: (bool? value) {
                          tIsCorrectAnswerProvider.setChecked(0, value);
                        },
                      );
                    }
                  )
                ],
              ),
              HtmlEditor(
                controller: _controllerQuestion1,
                htmlEditorOptions: HtmlEditorOptions(
                  hint: "Masukan jawaban soal",
                  initialText: widget.data.answerOption![0].subject
                ),
                htmlToolbarOptions: const HtmlToolbarOptions(
                  toolbarType: ToolbarType.nativeExpandable,
                ),
                otherOptions: const OtherOptions(
                  height: 300,
                ),
              ),

              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Jawaban Soal Opsi 2"),
                  Consumer<TIsCorrectAnswerProvider>(
                    builder: (_, tIsCorrectAnswerProvider, __) {
                      return Checkbox(
                        checkColor: Colors.white,
                        fillColor: MaterialStateProperty.resolveWith(getColor),
                        value: tIsCorrectAnswerProvider.isChecked[1],
                        onChanged: (bool? value) {
                          tIsCorrectAnswerProvider.setChecked(1, value);
                        },
                      );
                    }
                  )
                ],
              ),
              const SizedBox(height: 8.0),
              HtmlEditor(
                controller: _controllerQuestion2,
                htmlEditorOptions: HtmlEditorOptions(
                  hint: "Masukan jawaban soal",
                  initialText: widget.data.answerOption![1].subject
                ),
                htmlToolbarOptions: const HtmlToolbarOptions(
                  toolbarType: ToolbarType.nativeExpandable,
                ),
                otherOptions: const OtherOptions(
                  height: 300,
                ),
              ),

              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Jawaban Soal Opsi 3"),
                  Consumer<TIsCorrectAnswerProvider>(
                    builder: (_, tIsCorrectAnswerProvider, __) {
                      return Checkbox(
                        checkColor: Colors.white,
                        fillColor: MaterialStateProperty.resolveWith(getColor),
                        value: tIsCorrectAnswerProvider.isChecked[2],
                        onChanged: (bool? value) {
                          tIsCorrectAnswerProvider.setChecked(2, value);
                        },
                      );
                    }
                  )
                ],
              ),
              const SizedBox(height: 8.0),
              HtmlEditor(
                controller: _controllerQuestion3,
                htmlEditorOptions: HtmlEditorOptions(
                  hint: "Masukan jawaban soal",
                  initialText: widget.data.answerOption![2].subject
                ),
                htmlToolbarOptions: const HtmlToolbarOptions(
                  toolbarType: ToolbarType.nativeExpandable,
                ),
                otherOptions: const OtherOptions(
                  height: 300,
                ),
              ),

              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Jawaban Soal Opsi 4"),
                  Consumer<TIsCorrectAnswerProvider>(
                    builder: (_, tIsCorrectAnswerProvider, __) {
                      return Checkbox(
                        checkColor: Colors.white,
                        fillColor: MaterialStateProperty.resolveWith(getColor),
                        value: tIsCorrectAnswerProvider.isChecked[3],
                        onChanged: (bool? value) {
                          tIsCorrectAnswerProvider.setChecked(3, value);
                        },
                      );
                    }
                  )
                ],
              ),
              const SizedBox(height: 8.0),
              HtmlEditor(
                controller: _controllerQuestion4,
                htmlEditorOptions: HtmlEditorOptions(
                  hint: "Masukan jawaban soal",
                  initialText: widget.data.answerOption![3].subject
                ),
                htmlToolbarOptions: const HtmlToolbarOptions(
                  toolbarType: ToolbarType.nativeExpandable,
                ),
                otherOptions: const OtherOptions(
                  height: 300,
                ),
              ),

              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Jawaban Soal Opsi 5"),
                  Consumer<TIsCorrectAnswerProvider>(
                    builder: (_, tIsCorrectAnswerProvider, __) {
                      return Checkbox(
                        checkColor: Colors.white,
                        fillColor: MaterialStateProperty.resolveWith(getColor),
                        value: tIsCorrectAnswerProvider.isChecked[4],
                        onChanged: (bool? value) {
                          tIsCorrectAnswerProvider.setChecked(4, value);
                        },
                      );
                    }
                  )
                ],
              ),
              const SizedBox(height: 8.0),
              HtmlEditor(
                controller: _controllerQuestion5,
                htmlEditorOptions: HtmlEditorOptions(
                  hint: "Masukan jawaban soal",
                  initialText: widget.data.answerOption![4].subject
                ),
                htmlToolbarOptions: const HtmlToolbarOptions(
                  toolbarType: ToolbarType.nativeExpandable,
                ),
                otherOptions: const OtherOptions(
                  height: 300,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 50,
        color: Colors.white,
        child: Consumer<LoadingProvider>(
            builder: (_, loadingProvider, __) {
              return ElevatedButton(
                onPressed: () async {
                  loadingProvider.setLoading(true);

                  List<bool> checkedAnswer = context.read<TIsCorrectAnswerProvider>().isChecked;
                  String subject = await _controllerSubject.getText();
                  String option1 = await _controllerQuestion1.getText();
                  String option2 = await _controllerQuestion2.getText();
                  String option3 = await _controllerQuestion3.getText();
                  String option4 = await _controllerQuestion4.getText();
                  String option5 = await _controllerQuestion5.getText();

                  Map<String, dynamic> answer = {
                    "0": {
                      "answer_option": option1,
                      "answer_correct": checkedAnswer[0]
                    },
                    "1": {
                      "answer_option": option2,
                      "answer_correct": checkedAnswer[1]
                    },
                    "2": {
                      "answer_option": option3,
                      "answer_correct": checkedAnswer[2]
                    },
                    "3": {
                      "answer_option": option4,
                      "answer_correct": checkedAnswer[3]
                    },
                    "4": {
                      "answer_option": option5,
                      "answer_correct": checkedAnswer[4]
                    }
                  };

                  _tQuestionService.addOrEditQuestion(widget.data.id, 'choice', subject, answer, 'edit', examId: widget.data.examId).then((value) {
                    loadingProvider.setLoading(false);
                    value.fold(
                      (errorMessage) {
                        showTopSnackBar(
                          Overlay.of(context),
                          CustomSnackBar.error(
                            message: errorMessage,
                          )
                        );
                        return;
                      },
                      (response) {
                        context.read<TQuestionProvider>().updateQuestion(response);
                        showTopSnackBar(
                          Overlay.of(context),
                          const CustomSnackBar.success(
                            message: "Pertanyaan berhasil diedit",
                          )
                        );
                        Navigator.pop(context);
                        return null;
                      },
                    );
                  }).catchError((err) {
                    loadingProvider.setLoading(false);
                    showTopSnackBar(
                      Overlay.of(context),
                      const CustomSnackBar.error(
                        message: "Terjadi kesalahan",
                      )
                    );
                  });
                },
                child: Text(loadingProvider.isLoading ? "Loading..." : "Edit Pertanyaan")
              );
            }
          )
      )
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