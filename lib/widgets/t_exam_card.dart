import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../configs/api.dart';
import '../models/teacher/t_exam_model.dart';
import '../provider/teacher/t_exam_provider.dart';
import '../screens/teacher/t_exam_edit.dart';
import '../screens/teacher/t_exam_detail.dart';
import '../services/teacher/t_exam_service.dart';

class TExamCard extends StatefulWidget {
  const TExamCard({super.key, required this.exam});

  final Exam exam;

  @override
  State<TExamCard> createState() => _TExamCardState();
}

class _TExamCardState extends State<TExamCard> {
  final TExamService _tExamService = TExamService();
  final Api _api = Api();
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => TExamDetail(data: widget.exam)));
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: Image.network(_api.tBaseUrlAsset + widget.exam.thumbnail),
                title: Text(widget.exam.name),
                subtitle: Text("Kelas ${widget.exam.examClass}",
                  style: TextStyle(color: Colors.black.withOpacity(0.6)),
                ),
              ),
              ButtonBar(
                alignment: MainAxisAlignment.start,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => TExamEdit(data: widget.exam)));
                    },
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll<Color>(Colors.orange),
                      elevation: MaterialStatePropertyAll(0)
                    ),
                    child: const Text("Edit"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) {
                          return AlertDialog(
                            title: const Text("Peringatan"),
                            content: Text("Apakah kamu yakin ingin menghapus ujian ${widget.exam.name}?"),
                            actions: <Widget>[
                              ElevatedButton(
                                style: const ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll<Color>(Colors.red),
                                  elevation: MaterialStatePropertyAll(0)
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                  _tExamService.deleteExam(widget.exam.id).then((value) {
                                    Provider.of<TExamProvider>(context, listen: false).deleteExamInactive(widget.exam.id);
                                    showTopSnackBar(
                                      Overlay.of(context),
                                      const CustomSnackBar.error(
                                        message: "Ujian berhasil dihapus",
                                      )
                                    );
                                  }).catchError((err) {
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
                      backgroundColor: MaterialStatePropertyAll<Color>(Colors.red),
                      elevation: MaterialStatePropertyAll(0)
                    ),
                    child: const Text("Hapus"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}