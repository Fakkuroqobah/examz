import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:flutter/material.dart';

import '../../models/student_model.dart';
import '../../provider/admin/a_import_provider.dart';
import '../../provider/admin/a_select_room_provider.dart';
import '../../provider/loading_provider.dart';
import '../../services/admin/a_edit.service.dart';

class AStudentEdit extends StatefulWidget {
  const AStudentEdit({super.key, required this.data});

  final StudentModel data;

  @override
  State<AStudentEdit> createState() => _AStudentEditState();
}

class _AStudentEditState extends State<AStudentEdit> {
  final AEditService _aEditService = AEditService();
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerNis = TextEditingController();
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerClass = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  @override
  void initState() {
    super.initState();

    _controllerNis.text = widget.data.nis;
    _controllerName.text = widget.data.name;
    _controllerUsername.text = widget.data.username;
    _controllerClass.text = widget.data.studentModelClass;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ASelectRoomProvider>(context, listen: false).setItems();
      Provider.of<ASelectRoomProvider>(context, listen: false).setSelectedItem(widget.data.roomId.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Siswa"),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Consumer<ASelectRoomProvider>(
          builder: (_, aSelectRoomProvider, __) {
            if(aSelectRoomProvider.isLoading) {
              return const Padding(
                padding: EdgeInsets.all(18.0),
                child: Center(child: CircularProgressIndicator()),
              );
            }

            if(aSelectRoomProvider.hasError) {
              return const Center(child: Text("Terjadi kesalahan pada server"));
            }

            return Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: _controllerNis,
                    keyboardType: TextInputType.text,
                    maxLength: 10,
                    decoration: const InputDecoration(
                      labelText: "Masukan nis",
                    ),
                  ),

                  TextField(
                    controller: _controllerUsername,
                    keyboardType: TextInputType.text,
                    maxLength: 30,
                    decoration: const InputDecoration(
                      labelText: "Masukan username",
                    ),
                  ),

                  TextField(
                    controller: _controllerName,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      labelText: "Masukan nama siswa",
                    ),
                  ),

                  const SizedBox(height: 12.0),
                  TextField(
                    controller: _controllerClass,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      labelText: "Masukan kelas",
                    ),
                  ),

                  const SizedBox(height: 12.0),
                  DropdownButton<String>(
                    value: aSelectRoomProvider.selectedItem,
                    hint: const Text("Pilih Ruangan"),
                    isExpanded: true,
                    elevation: 0,
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 16.0),
                    underline: Container(
                      height: 1.0,
                      decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.transparent, width: 0.0))
                      ),
                    ),
                    items: aSelectRoomProvider.items.map<DropdownMenuItem<String>>((List<String> value) {
                      return DropdownMenuItem<String>(
                        value: value[0],
                        child: Text(value[1]),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      aSelectRoomProvider.setSelectedItem(newValue!);
                    }
                  ),

                  const SizedBox(height: 12.0),
                  TextField(
                    controller: _controllerPassword,
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: "Masukan password baru",
                    ),
                  ),
                ],
              ),
            );
          }
        ),
      ),
      bottomNavigationBar: Container(
        height: 50,
        color: Colors.white,
        child: Consumer<LoadingProvider>(
          builder: (_, loadingProvider, __) {
            return ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
              onPressed: () async {
                loadingProvider.setLoading(true);

                String nis = _controllerNis.text.toString();
                String name = _controllerName.text.toString();
                String username = _controllerUsername.text.toString();
                String classStudent = _controllerClass.text.toString();
                String selectedClass = context.read<ASelectRoomProvider>().selectedItem;
                String password = _controllerPassword.text.toString();

                if(nis == "") {
                  loadingProvider.setLoading(false);
                  if (!mounted) return;
                  showTopSnackBar(
                    Overlay.of(context),
                    const CustomSnackBar.error(
                      message: "NIS siswa harus diisi",
                    )
                  );
                }else if(name == "") {
                  loadingProvider.setLoading(false);
                  if (!mounted) return;
                  showTopSnackBar(
                    Overlay.of(context),
                    const CustomSnackBar.error(
                      message: "Nama siswa harus diisi",
                    )
                  );
                }else if(username == "") {
                  loadingProvider.setLoading(false);
                  if (!mounted) return;
                  showTopSnackBar(
                    Overlay.of(context),
                    const CustomSnackBar.error(
                      message: "Username harus diisi",
                    )
                  );
                }else if(classStudent == "") {
                  loadingProvider.setLoading(false);
                  if (!mounted) return;
                  showTopSnackBar(
                    Overlay.of(context),
                    const CustomSnackBar.error(
                      message: "Kelas harus diisi",
                    )
                  );
                }else if(selectedClass == "") {
                  loadingProvider.setLoading(false);
                  if (!mounted) return;
                  showTopSnackBar(
                    Overlay.of(context),
                    const CustomSnackBar.error(
                      message: "Ruangan harus diisi",
                    )
                  );
                }else{
                  _aEditService.editStudent(widget.data.id, nis, name,  username, classStudent, selectedClass, password).then((value) {
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
                        context.read<AImportProvider>().updateStudent(response);
                        showTopSnackBar(
                          Overlay.of(context),
                          CustomSnackBar.success(
                            message: "Data siswa ${response.name} berhasil diedit",
                          )
                        );
                        Navigator.pop(context);
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
                }
              },
              child: Text(loadingProvider.isLoading ? "Loading..." : "Edit Siswa")
            );
          }
        ),
      ),
    );
  }
}