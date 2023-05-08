import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../configs/api.dart';
import '../../configs/utils.dart';
import '../../models/student/s_exam_model.dart';

import '../../provider/loading_provider.dart';
import '../../provider/student/s_exam_provider.dart';
import '../../services/student/s_exam_service.dart';
import 's_exam_question.dart';

class SExamDetail extends StatefulWidget {
  const SExamDetail({super.key, required this.data});

  final SExamModel data;

  @override
  State<SExamDetail> createState() => _SExamDetailState();
}

class _SExamDetailState extends State<SExamDetail> {
  final Api _api = Api();
  final SExamService _sExamService = SExamService();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  final TextEditingController txtToken = TextEditingController();
  
  Future<void> _refresh() async {
    setState(() {});
  }
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final exam = widget.data.schedule.exam;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Ujian"),
        elevation: 0,
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refresh,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(_api.tBaseUrlAsset + exam.thumbnail, width: 100.0),
        
                            const SizedBox(width: 12.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 200.0,
                                  child: Wrap(
                                    children: [
                                      Text(exam.name, 
                                        style: const TextStyle(fontSize: 18.0)
                                      ),
                                    ],
                                  ),
                                ),
        
                                const SizedBox(height: 8.0),
                                Text("Kelas ${exam.examClass}",
                                  style: TextStyle(color: Colors.black.withOpacity(0.6)),
                                ),
        
                                const SizedBox(height: 8.0),
                                Text("Tanggal Publish : ${Utils.getFormatedDate(exam.createdAt)}", style: const TextStyle(
                                  fontSize: 12.0
                                )),
        
                                const SizedBox(height: 8.0),
                                Text("Waktu Ujian : ${exam.time} Menit", 
                                  style: const TextStyle(fontSize: 12.0)
                                ),

                                const SizedBox(height: 8.0),
                                Text("Acak Soal : ${exam.isRandom == 0 ? "Tidak" : "Iya"}", 
                                  style: const TextStyle(fontSize: 12.0)
                                ),
                              ],
                            ),
                          ],
                        ),
        
                        const SizedBox(height: 8.0),
                        exam.description != null ?
                        Html(
                          data: exam.description,
                          style: {
                            "body": Style(
                              padding: const EdgeInsets.all(0),
                              margin: const EdgeInsets.all(0),
                            ),
                            "p": Style(
                              padding: const EdgeInsets.all(0),
                              margin: const EdgeInsets.all(0),
                            ),
                          }
                        )
                        : Container(),
                      ],
                    ),
                  ),
                ),
        
                const SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Token Ujian'),
                              content: TextFormField(
                                controller: txtToken,
                                decoration: const InputDecoration(hintText: "Masukan Token Ujian"),
                                maxLength: 5,
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
                                      child: Text((loadingProvider.isLoading) ? "Loading..." : 'Mulai Ujian'),
                                      onPressed: () {
                                        loadingProvider.setLoading(true);

                                        _sExamService.token(widget.data.id, txtToken.text).then((value) {
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
                                              context.read<SExamProvider>().token(response);
                                              showTopSnackBar(
                                                Overlay.of(context),
                                                const CustomSnackBar.success(
                                                  message: "Selamat Ujian",
                                                )
                                              );
                                              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context) => SExamQuestion(data: exam)), (_) => false);
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
                          }
                        );
                      },
                      style: const ButtonStyle(
                        elevation: MaterialStatePropertyAll(0)
                      ),
                      child: const Text("Mulai Ujian")
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}