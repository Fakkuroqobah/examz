import 'dart:io';

import 'package:fancy_drawer/fancy_drawer.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:flutter/material.dart';

import '../../provider/admin/a_import_provider.dart';
import '../../provider/loading_provider.dart';
import '../../services/admin/a_auth_service.dart';
import '../../services/admin/a_import_service.dart';
import 'a_data_drawer.dart';
import 'a_student_edit.dart';

class AStudent extends StatefulWidget {
  const AStudent({super.key});

  @override
  State<AStudent> createState() => _AStudentState();
}

class _AStudentState extends State<AStudent> with SingleTickerProviderStateMixin {
  final AAuthService _aAuthService = AAuthService();
  final AImportService _aImportService = AImportService();
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
      Provider.of<AImportProvider>(context, listen: false).getStudent();
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
            title: const Text("Daftar Siswa"),
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
                            loadingProvider.setLoading(true);
                            final result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['xls', 'xlsx']);
                                
                            if (result != null) {
                              File file = File(result.files.single.path.toString());
                              _aImportService.studentsImport(file).then((value) {
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
                                    context.read<AImportProvider>().addStudent(response);
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
                        await _aImportService.downloadFormat('siswa').then((value) {
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
              
                          if(aImportProvider.studentList.isEmpty) {
                            return const Center(child: Text("Data masih kosong"));
                          }

                          return DataTable(
                            showCheckboxColumn: false,
                            columns: const <DataColumn>[
                              DataColumn(label: Text("No")),
                              DataColumn(label: Text("Nama")),
                              DataColumn(label: Text("Kelas")),
                              DataColumn(label: Text("Username")),
                              DataColumn(label: Text("Aksi")),
                            ],
                            rows: aImportProvider.studentList.map((el) {
                              return DataRow(
                                cells: <DataCell>[
                                  DataCell(Text("${number++}")),
                                  DataCell(Text(el.name)),
                                  DataCell(Text(el.studentModelClass)),
                                  DataCell(Text(el.username)),
                                  DataCell(ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => AStudentEdit(data: el)));
                                    }, 
                                    style: const ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll<Color>(Colors.orange),
                                      elevation: MaterialStatePropertyAll(0)
                                    ),
                                    child: const Text("Edit")
                                  )),
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