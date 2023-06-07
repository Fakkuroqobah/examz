import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:flutter/material.dart';

import '../../models/supervisor_model.dart';
import '../../provider/admin/a_import_provider.dart';
import '../../provider/loading_provider.dart';
import '../../services/admin/a_edit.service.dart';

class ASupervisorEdit extends StatefulWidget {
  const ASupervisorEdit({super.key, required this.data});

  final SupervisorModel data;

  @override
  State<ASupervisorEdit> createState() => _ASupervisorEditState();
}

class _ASupervisorEditState extends State<ASupervisorEdit> {
  final AEditService _aEditService = AEditService();
  final TextEditingController _controllerCode = TextEditingController();
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  @override
  void initState() {
    super.initState();

    _controllerCode.text = widget.data.code;
    _controllerName.text = widget.data.name;
    _controllerUsername.text = widget.data.username;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Pengawas"),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _controllerCode,
                keyboardType: TextInputType.text,
                maxLength: 3,
                decoration: const InputDecoration(
                  labelText: "Masukan kode pengawas",
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
                  labelText: "Masukan nama pengawas",
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

                String code = _controllerCode.text.toString();
                String name = _controllerName.text.toString();
                String username = _controllerUsername.text.toString();
                String password = _controllerPassword.text.toString();

                if(code == "") {
                  loadingProvider.setLoading(false);
                  if (!mounted) return;
                  showTopSnackBar(
                    Overlay.of(context),
                    const CustomSnackBar.error(
                      message: "Kode pengawas harus diisi",
                    )
                  );
                }else if(name == "") {
                  loadingProvider.setLoading(false);
                  if (!mounted) return;
                  showTopSnackBar(
                    Overlay.of(context),
                    const CustomSnackBar.error(
                      message: "Nama pengawas harus diisi",
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
                  _aEditService.editSupervisor(widget.data.id, code, name,  username, password).then((value) {
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
                        context.read<AImportProvider>().updateSupervisor(response);
                        showTopSnackBar(
                          Overlay.of(context),
                          CustomSnackBar.success(
                            message: "Data pengawas ${response.name} berhasil diedit",
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
              child: Text(loadingProvider.isLoading ? "Loading..." : "Edit Pengawas")
            );
          }
        ),
      ),
    );
  }
}