import 'package:fancy_drawer/fancy_drawer.dart';
import 'package:flutter/material.dart';

import '../../services/teacher/t_auth_service.dart';
import '../auth/login.dart';
import 'a_teacher.dart';

class AStudent extends StatefulWidget {
  const AStudent({super.key});

  @override
  State<AStudent> createState() => _AStudentState();
}

class _AStudentState extends State<AStudent> with SingleTickerProviderStateMixin {
  final TAuthService _tAuthService = TAuthService();
  late FancyDrawerController _controllerDrawer;

  @override
  void initState() {
    super.initState();
    _controllerDrawer = FancyDrawerController(
        vsync: this, duration: const Duration(milliseconds: 250))
      ..addListener(() {
        setState(() {});
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
              children: [
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll<Color>(Colors.green.shade400),
                        elevation: const MaterialStatePropertyAll(0)
                      ),
                      child: const Text("Import Data")
                    ),
                  ],
                ),

                Row(
                  children: [
                    ElevatedButton(onPressed: () {}, child: const Text("Kelas 1")),
                    
                    const SizedBox(width: 8.0),
                    ElevatedButton(onPressed: () {}, child: const Text("Kelas 2")),

                    const SizedBox(width: 8.0),
                    ElevatedButton(onPressed: () {}, child: const Text("Kelas 3")),
                  ],
                ),

                const SizedBox(height: 8.0),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        showCheckboxColumn: false,
                        columns: const <DataColumn>[
                          DataColumn(label: Text("No")),
                          DataColumn(label: Text("Nama")),
                          DataColumn(label: Text("Aksi")),
                        ],
                        rows:  <DataRow>[
                          DataRow(
                            cells: <DataCell>[
                              const DataCell(Text("1")),
                              const DataCell(Text("M. Fakkuroqobah")),
                              DataCell(ElevatedButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (ctx) {
                                      return AlertDialog(
                                        title: const Text("Peringatan"),
                                        content: const Text("Apakah kamu yakin ingin menghapus siswa ini?"),
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
                          ),
                          DataRow(
                            cells: <DataCell>[
                              const DataCell(Text("1")),
                              const DataCell(Text("M. Fakkuroqobah")),
                              DataCell(ElevatedButton(
                                onPressed: () {
                                }, 
                                style: const ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll<Color>(Colors.red),
                                  elevation: MaterialStatePropertyAll(0)
                                ),
                                child: const Text("Hapus")
                              )),
                            ]
                          ),
                          DataRow(
                            cells: <DataCell>[
                              const DataCell(Text("1")),
                              const DataCell(Text("M. Fakkuroqobah")),
                              DataCell(ElevatedButton(
                                onPressed: () {
                                }, 
                                style: const ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll<Color>(Colors.red),
                                  elevation: MaterialStatePropertyAll(0)
                                ),
                                child: const Text("Hapus")
                              )),
                            ]
                          ),
                          DataRow(
                            cells: <DataCell>[
                              const DataCell(Text("1")),
                              const DataCell(Text("M. Fakkuroqobah")),
                              DataCell(ElevatedButton(
                                onPressed: () {
                                }, 
                                style: const ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll<Color>(Colors.red),
                                  elevation: MaterialStatePropertyAll(0)
                                ),
                                child: const Text("Hapus")
                              )),
                            ]
                          ),
                          DataRow(
                            cells: <DataCell>[
                              const DataCell(Text("1")),
                              const DataCell(Text("M. Fakkuroqobah")),
                              DataCell(ElevatedButton(
                                onPressed: () {
                                }, 
                                style: const ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll<Color>(Colors.red),
                                  elevation: MaterialStatePropertyAll(0)
                                ),
                                child: const Text("Hapus")
                              )),
                            ]
                          ),
                          DataRow(
                            cells: <DataCell>[
                              const DataCell(Text("1")),
                              const DataCell(Text("M. Fakkuroqobah")),
                              DataCell(ElevatedButton(
                                onPressed: () {
                                }, 
                                style: const ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll<Color>(Colors.red),
                                  elevation: MaterialStatePropertyAll(0)
                                ),
                                child: const Text("Hapus")
                              )),
                            ]
                          ),
                          DataRow(
                            cells: <DataCell>[
                              const DataCell(Text("1")),
                              const DataCell(Text("M. Fakkuroqobah")),
                              DataCell(ElevatedButton(
                                onPressed: () {
                                }, 
                                style: const ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll<Color>(Colors.red),
                                  elevation: MaterialStatePropertyAll(0)
                                ),
                                child: const Text("Hapus")
                              )),
                            ]
                          ),
                          DataRow(
                            cells: <DataCell>[
                              const DataCell(Text("1")),
                              const DataCell(Text("M. Fakkuroqobah")),
                              DataCell(ElevatedButton(
                                onPressed: () {
                                }, 
                                style: const ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll<Color>(Colors.red),
                                  elevation: MaterialStatePropertyAll(0)
                                ),
                                child: const Text("Hapus")
                              )),
                            ]
                          ),
                          DataRow(
                            cells: <DataCell>[
                              const DataCell(Text("1")),
                              const DataCell(Text("M. Fakkuroqobah")),
                              DataCell(ElevatedButton(
                                onPressed: () {
                                }, 
                                style: const ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll<Color>(Colors.red),
                                  elevation: MaterialStatePropertyAll(0)
                                ),
                                child: const Text("Hapus")
                              )),
                            ]
                          ),
                          DataRow(
                            cells: <DataCell>[
                              const DataCell(Text("1")),
                              const DataCell(Text("M. Fakkuroqobah")),
                              DataCell(ElevatedButton(
                                onPressed: () {
                                }, 
                                style: const ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll<Color>(Colors.red),
                                  elevation: MaterialStatePropertyAll(0)
                                ),
                                child: const Text("Hapus")
                              )),
                            ]
                          ),
                          DataRow(
                            cells: <DataCell>[
                              const DataCell(Text("1")),
                              const DataCell(Text("M. Fakkuroqobah")),
                              DataCell(ElevatedButton(
                                onPressed: () {
                                }, 
                                style: const ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll<Color>(Colors.red),
                                  elevation: MaterialStatePropertyAll(0)
                                ),
                                child: const Text("Hapus")
                              )),
                            ]
                          ),
                          DataRow(
                            cells: <DataCell>[
                              const DataCell(Text("1")),
                              const DataCell(Text("M. Fakkuroqobah")),
                              DataCell(ElevatedButton(
                                onPressed: () {
                                }, 
                                style: const ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll<Color>(Colors.red),
                                  elevation: MaterialStatePropertyAll(0)
                                ),
                                child: const Text("Hapus")
                              )),
                            ]
                          ),
                          DataRow(
                            cells: <DataCell>[
                              const DataCell(Text("1")),
                              const DataCell(Text("M. Fakkuroqobah")),
                              DataCell(ElevatedButton(
                                onPressed: () {
                                }, 
                                style: const ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll<Color>(Colors.red),
                                  elevation: MaterialStatePropertyAll(0)
                                ),
                                child: const Text("Hapus")
                              )),
                            ]
                          ),
                        ],
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