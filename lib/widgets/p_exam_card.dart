import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../configs/api.dart';
import '../models/schedule_model.dart';
import '../provider/loading_provider.dart';
import '../provider/supervisor/p_exam_provider.dart';
import '../screens/supervisor/p_student.dart';
import '../services/supervisor/p_exam_service.dart';

class PExamCard extends StatefulWidget {
  const PExamCard({super.key, required this.exam});

  final ScheduleModel exam;

  @override
  State<PExamCard> createState() => _PExamCardState();
}

class _PExamCardState extends State<PExamCard> {
  final PExamService _pExamService = PExamService();
  final Api _api = Api();
  
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => PStudent(id: widget.exam.id)));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: Image.network(_api.tBaseUrlAsset + widget.exam.exam.thumbnail),
              title: Text(widget.exam.exam.name),
              subtitle: Text("Kelas ${widget.exam.exam.examClass}",
                style: TextStyle(color: Colors.black.withOpacity(0.6)),
              ),
            ),

            widget.exam.exam.description != '' ?
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Html(
                  data: widget.exam.exam.description,
                  style: {
                    "body": Style(
                      padding: const EdgeInsets.all(0),
                      margin: const EdgeInsets.all(0),
                    )
                  }
                ),
              )
            : Container(),

            (widget.exam.token == null) ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Consumer<LoadingProvider>(
                builder: (_, loadingProvider, __) {
                  return ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) {
                          return AlertDialog(
                            title: const Text("Peringatan"),
                            content: Text("Apakah kamu yakin ingin memulai ujian ${widget.exam.exam.name}?"),
                            actions: <Widget>[
                              ElevatedButton(
                                style: const ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll<Color>(Colors.red),
                                  elevation: MaterialStatePropertyAll(0)
                                ),
                                onPressed: () {
                                  loadingProvider.setLoading(true);

                                  _pExamService.triggerExam(widget.exam.id).then((value) {
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
                                            message: "Ujian berhasil dimulai",
                                          )
                                        );
                                        Navigator.pop(context);
                                        Provider.of<PExamProvider>(context, listen: false).triggerExam(response);
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
                                child: const Text("Iya"),
                              ),
                              ElevatedButton(
                                style: const ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll<Color>(Colors.grey),
                                  elevation: MaterialStatePropertyAll(0)
                                ),
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
                      elevation: MaterialStatePropertyAll(0)
                    ),
                    child: const Text("Mulai")
                  );
                }
              ),
            ) : Container(),

            (widget.exam.token != null) ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Container(
                padding: const EdgeInsets.all(6.0),
                decoration: BoxDecoration(border: Border.all(color: Colors.green)),
                child: Text(widget.exam.token!, style: const TextStyle(fontSize: 18.0, color: Colors.black54)),
              ),
            ) : Container()
          ],
        ),
      ),
    );
  }
}