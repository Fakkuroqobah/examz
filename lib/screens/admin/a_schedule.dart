import 'dart:typed_data';

import 'package:fancy_drawer/fancy_drawer.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:flutter/material.dart';

import '../../provider/admin/a_import_provider.dart';
import '../../provider/loading_provider.dart';
import '../../services/admin/a_auth_service.dart';
import '../../services/admin/a_delete.service.dart';
import '../../services/admin/a_import_service.dart';
import 'a_data_drawer.dart';

class ASchedule extends StatefulWidget {
  const ASchedule({super.key});

  @override
  State<ASchedule> createState() => _AScheduleState();
}

class _AScheduleState extends State<ASchedule> with SingleTickerProviderStateMixin {
  final AAuthService _aAuthService = AAuthService();
  final AImportService _aImportService = AImportService();
  final ADeleteService _aDeleteService = ADeleteService();
  late FancyDrawerController _controllerDrawer;

  @override
  void initState() {
    super.initState();
    _controllerDrawer = FancyDrawerController(
        vsync: this, duration: const Duration(milliseconds: 250))
      ..addListener(() {
        setState(() {});
      });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AImportProvider>(context, listen: false).getSchedule();
    });
  }

  @override
  void dispose() {
    _controllerDrawer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: FancyDrawerWrapper(
        backgroundColor: Colors.green,
        drawerPadding: const EdgeInsets.only(left: 26.0),
        controller: _controllerDrawer,
        drawerItems: dataDrawer(context, _aAuthService),
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Daftar Jadwal"),
            elevation: 0,
            leading: IconButton(
              icon: const Icon(
                Icons.menu,
                color: Colors.white,
              ),
              onPressed: () {
                _controllerDrawer.toggle();
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Consumer<LoadingProvider>(
                      builder: (_, loadingProvider, __) {
                        return ElevatedButton(
                          onPressed: () async {
                            final result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['xls', 'xlsx'], withData: true);
                            loadingProvider.setLoading(true);
                                
                            if (result != null) {
                              PlatformFile file = result.files.first;
                              Uint8List fileBytes = file.bytes!;
                              
                              _aImportService.schedulesImport(fileBytes).then((value) {
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
                                    context.read<AImportProvider>().addSchedule(response);
                                    showTopSnackBar(
                                      Overlay.of(context),
                                      const CustomSnackBar.success(
                                        message: "Import data berhasil",
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
                            }else{
                              loadingProvider.setLoading(false);
                            }
                          },
                          style: const ButtonStyle(
                            elevation: MaterialStatePropertyAll(0),
                          ),
                          child: Text(loadingProvider.isLoading ? "Loading..." : "Import")
                        );
                      }
                    ),

                    const SizedBox(width: 10.0),
                    ElevatedButton(
                      onPressed: () async {
                        await _aImportService.downloadFormat('jadwal').then((value) {
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
                                CustomSnackBar.success(
                                  message: response,
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
                      style: const ButtonStyle(
                        elevation: MaterialStatePropertyAll(0)
                      ),
                      child: const Text("Download Format")
                    )
                  ],
                ),

                const SizedBox(height: 8.0),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Consumer<AImportProvider>(
                        builder: (_, aImportProvider, __) {
                          int number = 1;

                          if(aImportProvider.isLoading) {
                            return const Center(child: CircularProgressIndicator());
                          }
              
                          if(aImportProvider.hasError) {
                            return const Center(child: Text("Terjadi kesalahan pada server"));
                          }
              
                          if(aImportProvider.scheduleList.isEmpty) {
                            return const Center(child: Text("Data masih kosong"));
                          }

                          return DataTable(
                            showCheckboxColumn: false,
                            columns: const <DataColumn>[
                              DataColumn(label: Text("No")),
                              DataColumn(label: Text("Ruangan")),
                              DataColumn(label: Text("Pengawas")),
                              DataColumn(label: Text("Ujian")),
                              DataColumn(label: Text("Aksi")),
                            ],
                            rows: aImportProvider.scheduleList.map((el) {
                              return DataRow(
                                cells: <DataCell>[
                                  DataCell(Text("${number++}")),
                                  DataCell(Text(el.room!.name)),
                                  DataCell(Text(el.supervisor!.name)),
                                  DataCell(Text(el.exam.name)),
                                  DataCell(ElevatedButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (_) {
                                          return AlertDialog(
                                            title: const Text("Peringatan"),
                                            content: const Text("Apakah kamu yakin ingin menghapus jadwal ini"),
                                            actions: <Widget>[
                                              ElevatedButton(
                                                style: const ButtonStyle(
                                                  backgroundColor: MaterialStatePropertyAll<Color>(Colors.red),
                                                  elevation: MaterialStatePropertyAll(0)
                                                ),
                                                onPressed: () async {
                                                  Navigator.pop(context);
                                                  await _aDeleteService.deleteData(el.id, 'schedule').then((value) {
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
                                                        Provider.of<AImportProvider>(context, listen: false).deleteSchedule(el.id);
                                                        showTopSnackBar(
                                                          Overlay.of(context),
                                                          CustomSnackBar.success(
                                                            message: response,
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
                                    child: const Text("Hapus"),
                                  ))
                                ]
                              );
                            }).toList(),
                          );
                        }
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}