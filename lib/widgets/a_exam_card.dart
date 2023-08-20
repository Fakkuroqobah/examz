import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../configs/api.dart';
import '../models/exam_model.dart';
import '../provider/admin/a_exam_provider.dart';
import '../provider/loading_provider.dart';
import '../services/admin/a_exam_service.dart';

class AExamCard extends StatefulWidget {
  const AExamCard({super.key, required this.exam});

  final ExamModel exam;

  @override
  State<AExamCard> createState() => _AExamCardState();
}

class _AExamCardState extends State<AExamCard> {
  final AExamService _aExamService = AExamService();
  final Api _api = Api();
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: Image.network(_api.tBaseUrlAsset + widget.exam.thumbnail),
                title: Text(widget.exam.name),
                subtitle: Text("Kelas ${widget.exam.examClass} - ID: ${widget.exam.id}",
                  style: TextStyle(color: Colors.black.withOpacity(0.6)),
                ),
              ),
              Consumer<LoadingProvider>(
                builder: (_, loadingProvider, __) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        (widget.exam.status == 'inactive') ? ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (_) {
                                return AlertDialog(
                                  title: const Text("Peringatan"),
                                  content: Text("Apakah kamu yakin ingin meluncurkan ujian ${widget.exam.name}? aksi ini tidak bisa dibatalkan"),
                                  actions: <Widget>[
                                    ElevatedButton(
                                      style: const ButtonStyle(
                                        backgroundColor: MaterialStatePropertyAll<Color>(Colors.red),
                                        elevation: MaterialStatePropertyAll(0)
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                        _aExamService.triggerExam(widget.exam.id, 'launched').then((value) {
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
                                              context.read<AExamProvider>().triggerExam(response);
                                              showTopSnackBar(
                                                Overlay.of(context),
                                                const CustomSnackBar.success(
                                                  message: "Ujian berhasil diluncurkan",
                                                )
                                              );
                                              return null;
                                            },
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
                            backgroundColor: MaterialStatePropertyAll<Color>(Colors.green),
                            elevation: MaterialStatePropertyAll(0)
                          ),
                          child: Text(loadingProvider.isLoading ? "Loading..." : "Luncurkan"),
                        ) : Container(),
                  
                        (widget.exam.status == 'launched') ? ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (_) {
                                return AlertDialog(
                                  title: const Text("Peringatan"),
                                  content: Text("Apakah kamu yakin ingin menutup ujian ${widget.exam.name}? aksi ini tidak bisa dibatalkan"),
                                  actions: <Widget>[
                                    ElevatedButton(
                                      style: const ButtonStyle(
                                        backgroundColor: MaterialStatePropertyAll<Color>(Colors.red),
                                        elevation: MaterialStatePropertyAll(0)
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                        _aExamService.triggerExam(widget.exam.id, 'finished').then((value) {
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
                                              context.read<AExamProvider>().triggerExam(response);
                                              showTopSnackBar(
                                                Overlay.of(context),
                                                const CustomSnackBar.success(
                                                  message: "Ujian berhasil ditutup",
                                                )
                                              );
                                              return null;
                                            },
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
                          child: Text(loadingProvider.isLoading ? "Loading..." : "Tutup"),
                        ) : Container(),
                  
                        (widget.exam.status == 'finished') ? ElevatedButton(
                          onPressed: () {
                          },
                          style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll<Color>(Colors.grey),
                            elevation: MaterialStatePropertyAll(0)
                          ),
                          child: const Text("Selesai"),
                        ) : Container(),
                  


                        const SizedBox(width: 10.0),
                        (widget.exam.isRated == 0) ? ElevatedButton(
                          onPressed: () {
                            loadingProvider.setLoading(true);
                  
                            _aExamService.triggerRated(widget.exam.id, 1).then((value) {
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
                                  context.read<AExamProvider>().triggerExam(response);
                                  showTopSnackBar(
                                    Overlay.of(context),
                                    const CustomSnackBar.success(
                                      message: "Lihat nilai berhasil di nonaktif",
                                    )
                                  );
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
                          style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll<Color>(Colors.orange),
                            elevation: MaterialStatePropertyAll(0)
                          ),
                          child: Text(loadingProvider.isLoading ? "Loading..." : "Nilai nonaktif"),
                        ) : Container(),

                        (widget.exam.isRated == 1) ? ElevatedButton(
                          onPressed: () {
                            loadingProvider.setLoading(true);
                  
                            _aExamService.triggerRated(widget.exam.id, 0).then((value) {
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
                                  context.read<AExamProvider>().triggerExam(response);
                                  showTopSnackBar(
                                    Overlay.of(context),
                                    const CustomSnackBar.success(
                                      message: "Lihat nilai berhasil aktif",
                                    )
                                  );
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
                          style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll<Color>(Colors.grey),
                            elevation: MaterialStatePropertyAll(0)
                          ),
                          child: Text(loadingProvider.isLoading ? "Loading..." : "Nilai aktif"),
                        ) : Container(),
                      ],
                    ),
                  );
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}