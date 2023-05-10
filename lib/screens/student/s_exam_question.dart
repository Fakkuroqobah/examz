import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../models/student/s_exam_model.dart';
import '../../models/student/s_question_model.dart';
import '../../provider/loading_provider.dart';
import '../../provider/student/s_exam_provider.dart';
import '../../services/student/s_exam_service.dart';
import 's_exam.dart';
import 's_exam_question_body.dart';

class SExamQuestion extends StatefulWidget {
  const SExamQuestion({super.key, required this.data});

  final Exam data;

  @override
  State<SExamQuestion> createState() => _SExamQuestionState();
}

class _SExamQuestionState extends State<SExamQuestion> with WidgetsBindingObserver {
  final PageController _pageController = PageController(initialPage: 0);
  final SExamService _sExamService = SExamService();
  final TextEditingController _txtBlock = TextEditingController();
  final List<Widget> _pages = [];
  List<SQuestionModel> sqm = [];
  bool _isBlock = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    sqm = Provider.of<SExamProvider>(context, listen: false).questionList;
    List initAnswer = Provider.of<SExamProvider>(context, listen: false).questionAnswer;
    for (int i = 0; i < sqm.length; i++) {
      _pages.add(SExamQuestionBody(data: sqm[i]));
      initAnswer.add([sqm[i].id, 0]);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _pageController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      if(_isBlock) Navigator.of(context).pop();
      _sExamService.block(widget.data.id).then((value) {
        value.fold(
          (errorMessage) {
            return;
          },
          (response) {
            return null;
          },
        );
      }).catchError((_) {
      });
    }else if(state == AppLifecycleState.resumed) {
      _showPrompt();
      _isBlock = true;
    }
  }

  void _showPrompt() {
    showDialog(context: context, barrierDismissible: false, builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Ujian di blokir. Silahkan meminta kode akses kepada pengawas'),
        content: TextFormField(
          controller: _txtBlock,
          decoration: const InputDecoration(hintText: "Masukan Token Akses"),
          maxLength: 5,
        ),
        actions: <Widget>[
          Consumer<LoadingProvider>(
            builder: (_, loadingProvider, __) {
              return ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll<Color>(Colors.green),
                  elevation: MaterialStatePropertyAll(0)
                ),
                child: Text((loadingProvider.isLoading) ? "Loading..." : 'Buka'),
                onPressed: () {
                  loadingProvider.setLoading(true);

                  _sExamService.openBlock(widget.data.id, _txtBlock.text).then((value) {
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
                        showTopSnackBar(
                          Overlay.of(context),
                          const CustomSnackBar.success(
                            message: "Selamat ujian kembali",
                          )
                        );
                        _isBlock = false;
                        _txtBlock.text = "";
                        Navigator.of(context).pop();
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
              );
            }
          ),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.data.name),
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 18.0, left: 18.0, right: 18.0,),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Consumer<SExamProvider>(
                  builder: (_, sExamProvider, __) {
                    return Text("No. ${sExamProvider.activePage + 1}", style: const TextStyle(color: Colors.black54, fontSize: 18.0));
                  }
                ),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Wrap(
                                  alignment: WrapAlignment.spaceBetween,
                                  children: <Widget>[
                                    for (int i = 0; i < sqm.length; i++)
                                      btnNumber(i + 1),
                                  ],
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (ctx) {
                                          return AlertDialog(
                                            title: const Text("Peringatan"),
                                            content: const Text("Apakah kamu yakin ingin menyelesaikan ujian?"),
                                            actions: <Widget>[
                                              Consumer<LoadingProvider>(
                                                builder: (_, loadingProvider, __) {
                                                  return ElevatedButton(
                                                    style: const ButtonStyle(
                                                      backgroundColor: MaterialStatePropertyAll<Color>(Colors.green),
                                                      elevation: MaterialStatePropertyAll(0)
                                                    ),
                                                    onPressed: () {
                                                      _sExamService.endExam(widget.data.id).then((value) {
                                                        loadingProvider.setLoading(true);
                                                        value.fold(
                                                          (errorMessage) {
                                                            loadingProvider.setLoading(false);
                                                            showTopSnackBar(
                                                              Overlay.of(context),
                                                              CustomSnackBar.error(
                                                                message: errorMessage,
                                                              )
                                                            );
                                                            return;
                                                          },
                                                          (response) {
                                                            loadingProvider.setLoading(false);
                                                            showTopSnackBar(
                                                              Overlay.of(context),
                                                              const CustomSnackBar.success(
                                                                message: "Kamu berhasil menyelesaikan ujian",
                                                              )
                                                            );
                                                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context) => const SExam()), (_) => false);
                                                            return;
                                                          },
                                                        );
                                                      }).catchError((err) {
                                                        loadingProvider.setLoading(false);
                                                        showTopSnackBar(
                                                          Overlay.of(context),
                                                          const CustomSnackBar.error(
                                                            message: "Terjadi kesalahan pada server",
                                                          )
                                                        );
                                                      });
                                                    },
                                                    child: Text(loadingProvider.isLoading ? "Loading..." : "Iya"),
                                                  );
                                                }
                                              ),
                                              ElevatedButton(
                                                style: const ButtonStyle(
                                                  backgroundColor: MaterialStatePropertyAll<Color>(Colors.grey),
                                                  elevation: MaterialStatePropertyAll(0)
                                                ),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text("Tidak"),
                                              )
                                            ],
                                          );
                                        }
                                      );
                                    },
                                    style: const ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll<Color>(Colors.orange),
                                      elevation: MaterialStatePropertyAll(0)
                                    ),
                                    child: const Text("Selesai Ujian"),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                  },
                  child: const Icon(Icons.apps_sharp, size: 32.0, color: Colors.black54),
                )
              ],
            ),
          ),

          Expanded(
            child: Consumer<SExamProvider>(
              builder: (_, sExamProvider, __) {
                return PageView.builder(
                  controller: _pageController,
                  onPageChanged: (int page) {
                    sExamProvider.setActivePage(page);
                  },
                  itemCount: _pages.length,
                  itemBuilder: (_, int index) {
                    return _pages[index % _pages.length];
                  },
                );
              }
            ),
          ),
        ],
      ),
    );
  }

  Widget btnNumber(int no) {
    return Consumer<SExamProvider>(
      builder: (_, sExamProvider, __) {
        return OutlinedButton(
          onPressed: () {
            sExamProvider.setActivePage(no - 1);
            _pageController.animateToPage(no - 1,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeIn);
          },
          style: OutlinedButton.styleFrom(
            backgroundColor: (sExamProvider.questionAnswer[no - 1][1] != 0) ? Colors.green : Colors.white,
            alignment: Alignment.center,
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
          ),
          child: Text(no.toString(),
            style: TextStyle(
              color: (sExamProvider.questionAnswer[no - 1][1] != 0) ? Colors.white : Colors.black54,
            ),
          ),
        );
      }
    );
  }
}