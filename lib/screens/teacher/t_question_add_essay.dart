import 'package:flutter/material.dart';

import 'package:html_editor_enhanced/html_editor.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../provider/loading_provider.dart';
import '../../provider/teacher/t_question_provider.dart';
import '../../services/teacher/t_question_service.dart';

class TQuestionAddEssay extends StatefulWidget {
  const TQuestionAddEssay({super.key, required this.id});

  final int id;

  @override
  State<TQuestionAddEssay> createState() => _TQuestionAddEssayState();
}

class _TQuestionAddEssayState extends State<TQuestionAddEssay> {
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
        title: const Text("Tambah Pertanyaan Essai"),
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
                htmlEditorOptions: const HtmlEditorOptions(
                  hint: "Masukan Pertanyaan",
                  initialText: "<p>Pertanyaan</p>"
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
                htmlEditorOptions: const HtmlEditorOptions(
                  hint: "Masukan ekspektasi jawaban",
                  initialText: "<p>Ekspektasi jawaban</p>"
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

                  _tQuestionService.addOrEditQuestion(widget.id, 'essay', subject, answer, 'add').then((value) {
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
                        context.read<TQuestionProvider>().addQuestion(response);
                        showTopSnackBar(
                          Overlay.of(context),
                          const CustomSnackBar.success(
                            message: "Pertanyaan baru berhasil dibuat",
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
                child: Text(loadingProvider.isLoading ? "Loading..." : "Tambah Pertanyaan")
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