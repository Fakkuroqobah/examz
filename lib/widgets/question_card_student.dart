import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';

import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../models/answer_option_model.dart';
import '../models/answer_student_model.dart';
import '../models/question_model.dart';
import '../provider/loading_provider.dart';
import '../provider/teacher/t_rated_provider.dart';
import '../services/teacher/t_rated_service.dart';

class QuestionCardStudent extends StatefulWidget {
  const QuestionCardStudent({super.key, required this.data, required this.answerStudent, required this.number, required this.role});

  final QuestionModel data;
  final AnswerStudentModel? answerStudent;
  final int number;
  final String role;

  @override
  State<QuestionCardStudent> createState() => _QuestionCardStudentState();
}

class _QuestionCardStudentState extends State<QuestionCardStudent> {
  final TextEditingController txtRateEssay = TextEditingController();
  final TRatedService _tRatedService = TRatedService();

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

      return Text("0/${widget.data.score}",
        style: const TextStyle(fontWeight: FontWeight.bold)
      );
    }else{
      if(widget.answerStudent != null) {
        return Row(
          children: [
            (widget.answerStudent!.score != -1) ? Text("${widget.answerStudent?.score ?? 0}/${widget.data.score}", 
              style: const TextStyle(fontWeight: FontWeight.bold)
            ) : const Text(''),

            const SizedBox(width: 5.0),
            (widget.role == 'teacher') ? ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Soal ${widget.number}'),
                      content: TextFormField(
                        controller: txtRateEssay,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(hintText: "Masukan nilai essai (max: ${widget.data.score})"),
                        maxLength: 1,
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
                        Consumer<LoadingProvider>(
                          builder: (_, loadingProvider, __) {
                            return ElevatedButton(
                              style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll<Color>(Colors.green),
                                elevation: MaterialStatePropertyAll(0)
                              ),
                              child: Text(loadingProvider.isLoading ? 'Loading...' : 'Simpan'),
                              onPressed: () {
                                if(int.parse(txtRateEssay.text) > widget.data.score) {
                                  showTopSnackBar(
                                    Overlay.of(context),
                                    const CustomSnackBar.error(
                                      message: "Nilai essai yang diberikan tidak boleh melebihi bobot nilai",
                                    )
                                  );
                                }else{
                                  loadingProvider.setLoading(true);
                                  _tRatedService.update(widget.answerStudent!.id, widget.answerStudent!.studentId, widget.data.examId, txtRateEssay.text).then((value) {
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
                                        context.read<TRatedProvider>().updateRated(response);
                                        showTopSnackBar(
                                          Overlay.of(context),
                                          const CustomSnackBar.success(
                                            message: "Nilai essai berhasil disimpan",
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
                                }
                              },
                            );
                          }
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
            ) : const Text(''),
          ],
        );
      }

      return Text("0/${widget.data.score}",
        style: const TextStyle(fontWeight: FontWeight.bold)
      );
    }
  }
}