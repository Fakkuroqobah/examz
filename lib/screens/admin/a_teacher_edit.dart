import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:flutter/material.dart';


import '../../models/teacher_model.dart';
import '../../provider/admin/a_import_provider.dart';
import '../../provider/loading_provider.dart';
import '../../services/admin/a_edit.service.dart';

class ATeacherEdit extends StatefulWidget {
  const ATeacherEdit({super.key, required this.data});

  final TeacherModel data;

  @override
  State<ATeacherEdit> createState() => _ATeacherEditState();
}

class _ATeacherEditState extends State<ATeacherEdit> {
  final AEditService _aEditService = AEditService();
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  @override
  void initState() {
    super.initState();

    _controllerName.text = widget.data.name;
    _controllerUsername.text = widget.data.username;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Guru"),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
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
                  labelText: "Masukan nama guru",
                ),
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

                String name = _controllerName.text.toString();
                String username = _controllerUsername.text.toString();
                String password = _controllerPassword.text.toString();

                if(name == "") {
                  loadingProvider.setLoading(false);
                  if (!mounted) return;
                  showTopSnackBar(
                    Overlay.of(context),
                    const CustomSnackBar.error(
                      message: "Nama guru harus diisi",
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
                }else{
                  _aEditService.editTeacher(widget.data.id, name,  username, password).then((value) {
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
                        context.read<AImportProvider>().updateTeacher(response);
                        showTopSnackBar(
                          Overlay.of(context),
                          CustomSnackBar.success(
                            message: "Data guru ${response.name} berhasil diedit",
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
              child: Text(loadingProvider.isLoading ? "Loading..." : "Edit Guru")
            );
          }
        ),
      ),
    );
  }
}