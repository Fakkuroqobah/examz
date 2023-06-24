import 'package:flutter/material.dart';

import 'package:html_editor_enhanced/html_editor.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../models/question_model.dart';
import '../../provider/loading_provider.dart';
import '../../provider/teacher/t_question_provider.dart';
import '../../services/teacher/t_question_service.dart';

class TQuestionEditEssay extends StatefulWidget {
  const TQuestionEditEssay({super.key, required this.data});

  final QuestionModel data;

  @override
  State<TQuestionEditEssay> createState() => _TQuestionEditEssayState();
}

class _TQuestionEditEssayState extends State<TQuestionEditEssay> {
  final TQuestionService _tQuestionService = TQuestionService();
  final HtmlEditorController _controllerSubject = HtmlEditorController();
  final HtmlEditorController _controllerDefaultAnswer = HtmlEditorController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Pertanyaan Essai"),
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
              const Text("Ekspektasi jawaban"),
              const SizedBox(height: 8.0),
              HtmlEditor(
                controller: _controllerDefaultAnswer,
                htmlEditorOptions: HtmlEditorOptions(
                  hint: "Masukan ekspektasi jawaban",
                  initialText: widget.data.answerEssay?.defaultAnswer ?? ''
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

                  String subject = await _controllerSubject.getText();
                  String defaultAnswer = await _controllerDefaultAnswer.getText();

                  Map<String, dynamic> answer = {
                    'essay': defaultAnswer
                  };

                  _tQuestionService.addOrEditQuestion(widget.data.id, 'essay', subject, answer, 'edit', examId: widget.data.examId).then((value) {
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