import 'dart:io';

import 'package:fancy_drawer/fancy_drawer.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:flutter/material.dart';

import '../../provider/admin/a_import_provider.dart';
import '../../provider/loading_provider.dart';
import '../../services/admin/a_import_service.dart';
import '../../services/teacher/t_auth_service.dart';
import '../../widgets/empty_condition.dart';
import '../auth/login.dart';
import 'a_student.dart';

class ATeacher extends StatefulWidget {
  const ATeacher({super.key});

  @override
  State<ATeacher> createState() => _ATeacherState();
}

class _ATeacherState extends State<ATeacher> with SingleTickerProviderStateMixin {
  final TAuthService _tAuthService = TAuthService();
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
      Provider.of<AImportProvider>(context, listen: false).getRoom();
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
        drawerItems: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const ATeacher()));
            },
            child: const Text(
              "Daftar Guru",
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const AStudent()));
            },
            child: const Text(
              "Daftar Siswa",
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          GestureDetector(
            onTap: () {
              _tAuthService.logout().then((value) {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => const Login()));
              });
            },
            child: const Text(
              "Log out",
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Daftar Guru"),
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
                              _aImportService.roomsImport(file).then((value) {
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
                                    context.read<AImportProvider>().addRoom(response);
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
              
                          if(aImportProvider.roomList.isEmpty) {
                            return const EmptyCondition();
                          }

                          return DataTable(
                            showCheckboxColumn: false,
                            columns: const <DataColumn>[
                              DataColumn(label: Text("No")),
                              DataColumn(label: Text("Nama")),
                              DataColumn(label: Text("Aksi")),
                            ],
                            rows: aImportProvider.roomList.map((el) {
                              return DataRow(
                                cells: <DataCell>[
                                  DataCell(Text("${number++}")),
                                  DataCell(Text(el.name)),
                                  DataCell(ElevatedButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (ctx) {
                                          return AlertDialog(
                                            title: const Text("Peringatan"),
                                            content: const Text("Apakah kamu yakin ingin menghapus guru ini?"),
                                            actions: <Widget>[
                                              ElevatedButton(
                                                style: const ButtonStyle(
                                                  backgroundColor: MaterialStatePropertyAll<Color>(Colors.red),
                                                  elevation: MaterialStatePropertyAll(0)
                                                ),
                                                onPressed: () {
                                                  
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
                                      backgroundColor: MaterialStatePropertyAll<Color>(Colors.red),
                                      elevation: MaterialStatePropertyAll(0)
                                    ),
                                    child: const Text("Hapus")
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