import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../configs/api.dart';
import '../../models/teacher/t_exam_model.dart';
import '../../provider/loading_provider.dart';
import '../../provider/teacher/t_exam_provider.dart';
import '../../provider/teacher/t_is_random_provider.dart';
import '../../provider/teacher/t_select_class_provider.dart';
import '../../provider/teacher/t_thumbnail_provider.dart';
import '../../services/teacher/t_exam_service.dart';

class TExamEdit extends StatefulWidget {
  const TExamEdit({super.key, required this.data});

  final Exam data;

  @override
  State<TExamEdit> createState() => _TExamEditState();
}

class _TExamEditState extends State<TExamEdit> {
  final TExamService _tExamService = TExamService();
  final TextEditingController _controllerName = TextEditingController();
  final HtmlEditorController _controllerDescription = HtmlEditorController();
  final Api _api = Api();

  @override
  void initState() {
    super.initState();
    _controllerName.text = widget.data.name;
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TSelectClassProvider>(context, listen: false).setSelectedItem(widget.data.examClass);
      Provider.of<TIsRandomProvider>(context, listen: false).setChecked((widget.data.isRandom == 1));
      Provider.of<TThumbnailProvider>(context, listen: false).setItem({});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Ujian"),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            children: [
              TextField(
                controller: _controllerName,
                keyboardType: TextInputType.text,
                maxLength: 30,
                decoration: const InputDecoration(
                  labelText: "Masukan nama ujian",
                ),
              ),

              const SizedBox(height: 12.0),
              Container(
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(width: 1.0, color: Colors.grey))
                ),
                child: Consumer<TSelectClassProvider>(
                  builder: (_, tSelectClassProvider, widget) {
                    return DropdownButton<String>(
                      value: tSelectClassProvider.selectedItem,
                      hint: const Text("Pilih Kelas"),
                      isExpanded: true,
                      elevation: 0,
                      style: TextStyle(color: Colors.grey.shade600, fontSize: 16.0),
                      underline: Container(
                        height: 1.0,
                        decoration: const BoxDecoration(
                          border: Border(bottom: BorderSide(color: Colors.transparent, width: 0.0))
                        ),
                      ),
                      items: tSelectClassProvider.items.map<DropdownMenuItem<String>>((List<String> value) {
                        return DropdownMenuItem<String>(
                          value: value[0],
                          child: Text(value[1]),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        tSelectClassProvider.setSelectedItem(newValue!);
                      }
                    );
                  }
                ),
              ),

              const SizedBox(height: 12.0),
              HtmlEditor(
                controller: _controllerDescription,
                htmlEditorOptions: HtmlEditorOptions(
                  hint: "Masukan Deskripsi",
                  initialText: widget.data.description
                ),
                htmlToolbarOptions: const HtmlToolbarOptions(
                  toolbarType: ToolbarType.nativeExpandable,
                ),
                otherOptions: const OtherOptions(
                  height: 300,
                ),
              ),

              const SizedBox(height: 16.0),
              Row(
                children: [
                  SizedBox(
                    height: 24.0,
                    width: 24.0,
                    child: Consumer<TIsRandomProvider>(
                      builder: (_, tIsRandomProvider, widget) {
                        return Checkbox(
                          checkColor: Colors.white,
                          fillColor: MaterialStateProperty.resolveWith(getColor),
                          value: tIsRandomProvider.isChecked,
                          onChanged: (bool? value) {
                            tIsRandomProvider.setChecked(value);
                          },
                        );
                      }
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Text("Acak soal", style: TextStyle(color: Colors.grey.shade600, fontSize: 16.0))
                ],
              ),

              const SizedBox(height: 16.0),
              Consumer<TThumbnailProvider>(
                builder: (_, tThumbnailProvider, __) {
                  return Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.green.shade600),
                            elevation: const MaterialStatePropertyAll(0),
                            padding: const MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0)),
                            minimumSize: const MaterialStatePropertyAll(Size(double.infinity, 48)),
                            maximumSize: const MaterialStatePropertyAll(Size(double.infinity, double.infinity)),
                          ),
                          onPressed: () async {
                            final result = await FilePicker.platform.pickFiles(type: FileType.image, withData: true);
                            
                            if (result != null) {
                              final bytes = result.files.single.bytes!;
                              final extensions = result.files.single.extension!;

                              File file = File(result.files.single.path.toString());
                              Map<String, dynamic> thumbnail = {};

                              thumbnail = {
                                "file": file,
                                "byte": base64.encode(bytes),
                                "extension": extensions
                              };

                              tThumbnailProvider.setItem(thumbnail);
                            }
                          },
                          child: const Text("Pilih Gambar"),
                        ),
                      ),

                      const SizedBox(height: 12.0),
                      tThumbnailProvider.thumbnails['file'] != null ?
                      Image.file(
                        File(tThumbnailProvider.thumbnails['file']!.path),
                        fit: BoxFit.fill,
                        width: MediaQuery.of(context).size.width,
                        height: 300,
                      )
                      : Image.network(_api.tBaseUrlAsset + widget.data.thumbnail, 
                        fit: BoxFit.fill,
                        width: MediaQuery.of(context).size.width, 
                        height: 300
                      ),
                    ],
                  );
                }
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
                String selectedClass = context.read<TSelectClassProvider>().selectedItem;
                bool? isRandom = context.read<TIsRandomProvider>().isChecked;
                Map<String, dynamic> thumbnail = context.read<TThumbnailProvider>().thumbnails;
                String description = await _controllerDescription.getText();

                if(name == "") {
                  loadingProvider.setLoading(false);
                  if (!mounted) return;
                  showTopSnackBar(
                    Overlay.of(context),
                    const CustomSnackBar.error(
                      message: "Nama ujian harus diisi",
                    )
                  );
                }else if(selectedClass == "") {
                  loadingProvider.setLoading(false);
                  if (!mounted) return;
                  showTopSnackBar(
                    Overlay.of(context),
                    const CustomSnackBar.error(
                      message: "Kelas harus diisi",
                    )
                  );
                }else{
                  _tExamService.editExam(widget.data.id, name,  selectedClass, description, thumbnail['byte'], thumbnail['extension'], isRandom).then((value) {
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
                        context.read<TExamProvider>().updateExamInactive(response);
                        showTopSnackBar(
                          Overlay.of(context),
                          CustomSnackBar.success(
                            message: "Ujian ${response.name} berhasil diedit",
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
              child: Text(loadingProvider.isLoading ? "Loading..." : "Edit Ujian")
            );
          }
        ),
      ),
    );
  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.grey;
    }
    return Colors.green;
  }
}