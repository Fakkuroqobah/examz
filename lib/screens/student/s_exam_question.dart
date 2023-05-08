import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/student/s_question_model.dart';
import '../../provider/student/s_exam_provider.dart';
import 's_exam.dart';
import 's_exam_question_body.dart';

class SExamQuestion extends StatefulWidget {
  const SExamQuestion({super.key});

  @override
  State<SExamQuestion> createState() => _SExamQuestionState();
}

class _SExamQuestionState extends State<SExamQuestion> {
  final PageController _pageController = PageController(initialPage: 0);
  List<SQuestionModel> sqm = [];
  
  final List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    sqm = Provider.of<SExamProvider>(context, listen: false).questionList;
    List initAnswer = Provider.of<SExamProvider>(context, listen: false).questionAnswer;
    for (int i = 0; i < sqm.length; i++) {
      _pages.add(SExamQuestionBody(data: sqm[i]));
      initAnswer.add([sqm[i].id, 0]);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ujian Bahasa Indonesia"),
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
                                              ElevatedButton(
                                                style: const ButtonStyle(
                                                  backgroundColor: MaterialStatePropertyAll<Color>(Colors.red),
                                                  elevation: MaterialStatePropertyAll(0)
                                                ),
                                                onPressed: () {
                                                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const SExam()));
                                                  SnackBar snackBar = const SnackBar(content: Text("Kamu berhasil menyelesaikan ujian"));
                                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                                },
                                                child: const Text("Iya"),
                                              ),
                                              ElevatedButton(
                                                child: const Text("Tidak"),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
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

  OutlinedButton btnNumber(int no) {
    return OutlinedButton(
      onPressed: () {
        Provider.of<SExamProvider>(context, listen: false).setActivePage(no - 1);
        _pageController.animateToPage(no - 1,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeIn);
      },
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.white,
        alignment: Alignment.center,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
      child: Text(no.toString(),
        style: const TextStyle(
          color: Colors.black54,
        ),
      ),
    );
  }
}