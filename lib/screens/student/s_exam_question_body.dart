import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../models/question_model.dart';
import '../../provider/student/s_exam_provider.dart';
import '../../services/student/s_exam_service.dart';

class SExamQuestionBody extends StatefulWidget {
  const SExamQuestionBody({super.key, required this.data});

  final QuestionModel data;

  @override
  State<SExamQuestionBody> createState() => _SExamQuestionBodyState();
}

class _SExamQuestionBodyState extends State<SExamQuestionBody> {
  final SExamService _sExamService = SExamService();
  final HtmlEditorController _controllerAnswerEssay = HtmlEditorController();
  Timer? _debounceTimer;

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }
  
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
              if(widget.data.type == 'choice') for (int i = 0; i < widget.data.answerOption!.length; i++) 
                btnAnswer(widget.data.answerOption![i].subject, widget.data.answerOption![i].id)
              else Consumer<SExamProvider>(
                builder: (_, sExamProvider, __) {
                  return HtmlEditor(
                    controller: _controllerAnswerEssay,
                    htmlEditorOptions: HtmlEditorOptions(
                      hint: "Masukan jawaban",
                      initialText: sExamProvider.getAnswer(widget.data.id, 'essay').toString()
                    ),
                    htmlToolbarOptions: const HtmlToolbarOptions(
                      toolbarType: ToolbarType.nativeExpandable,
                    ),
                    otherOptions: const OtherOptions(
                      height: 300,
                    ),
                    callbacks: Callbacks(
                      onChangeContent: (val) {
                        _debounceTimer?.cancel();
                        _debounceTimer = Timer(const Duration(seconds: 3), () {
                          _sExamService.answer(widget.data.id, 'essay', val).then((value) {
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
                                return;
                              },
                            );
                          }).catchError((err) {
                            showTopSnackBar(
                              Overlay.of(context),
                              const CustomSnackBar.error(
                                message: "Terjadi kesalahan dalam menyimpan jawaban soal",
                              )
                            );
                          });
                        });

                        return sExamProvider.answer(widget.data.id, val);
                      }
                    ),
                  );
                }
              ),

              const SizedBox(height: 22.0),
              if(widget.data.type == 'choice') ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll<Color>(Colors.grey),
                  elevation: MaterialStatePropertyAll(0)
                ),
                child: const Text('Hapus jawaban soal ini'),
                onPressed: () {
                  Provider.of<SExamProvider>(context, listen: false).answer(widget.data.id, (widget.data.type == 'choice') ? 0 : '');
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
              _sExamService.answer(widget.data.id, 'choice', value).then((value) {
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
                    return;
                  },
                );
              }).catchError((err) {
                showTopSnackBar(
                  Overlay.of(context),
                  const CustomSnackBar.error(
                    message: "Terjadi kesalahan dalam menyimpan jawaban soal",
                  )
                );
              });
            },
            style: OutlinedButton.styleFrom(
              backgroundColor: (sExamProvider.getAnswer(widget.data.id, 'choice') == value) ? Colors.green : Colors.white,
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
                  color: (sExamProvider.getAnswer(widget.data.id, 'choice') == value) ? Colors.white : Colors.black54
                ),
              }
            ),
          );
        }
      ),
    );
  }
}