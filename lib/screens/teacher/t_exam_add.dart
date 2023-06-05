import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../provider/loading_provider.dart';
import '../../provider/teacher/t_exam_provider.dart';
import '../../provider/teacher/t_is_random_provider.dart';
import '../../provider/teacher/t_select_class_provider.dart';
import '../../provider/teacher/t_thumbnail_provider.dart';
import '../../services/teacher/t_exam_service.dart';

class TExamAdd extends StatefulWidget {
  const TExamAdd({super.key});

  @override
  State<TExamAdd> createState() => _TExamAddState();
}

class _TExamAddState extends State<TExamAdd> {
  final TExamService _tExamService = TExamService();
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerTime = TextEditingController();
  final HtmlEditorController _controllerDescription = HtmlEditorController();

  @override
  void initState() {
    super.initState();

    _controllerName.text = "PKN";
    _controllerTime.text = '1';

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TSelectClassProvider>(context, listen: false).setSelectedItem("1");
      Provider.of<TThumbnailProvider>(context, listen: false).setItem({});
      Provider.of<TIsRandomProvider>(context, listen: false).setChecked(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Ujian"),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12.0),
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
                  builder: (_, tSelectClassProvider, __) {
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
              TextField(
                controller: _controllerTime,
                keyboardType: TextInputType.number,
                maxLength: 3,
                decoration: const InputDecoration(
                  labelText: "Masukan waktu ujian (menit)",
                ),
              ),

              const SizedBox(height: 12.0),
              HtmlEditor(
                controller: _controllerDescription,
                htmlEditorOptions: const HtmlEditorOptions(
                  hint: "Masukan Deskripsi",
                  initialText: "<p>Keren</p>"
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
                      builder: (_, tIsRandomProvider, __) {
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
                              PlatformFile file = result.files.first;
                              Uint8List? fileBytes = file.bytes;

                              if (fileBytes != null) {
                                String extensions = file.extension!;

                                Map<String, dynamic> thumbnail = {};

                                thumbnail = {
                                  "file": file,
                                  "byte": fileBytes,
                                  "extension": extensions
                                };

                                tThumbnailProvider.setItem(thumbnail);
                              }
                            }
                          },
                          child: const Text("Pilih Gambar"),
                        ),
                      ),

                      const SizedBox(height: 12.0),
                      
                      tThumbnailProvider.thumbnails['byte'] != null ?
                      Image.memory(
                        tThumbnailProvider.thumbnails['byte']!,
                        fit: BoxFit.fill,
                        width: MediaQuery.of(context).size.width,
                        height: 300,
                      )
                      : const Text("", style: TextStyle(fontSize: 16, color: Colors.black54)),
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
                String time = _controllerTime.text.toString();
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
                }else if(thumbnail['file'] == null) {
                  loadingProvider.setLoading(false);
                  if (!mounted) return;
                  showTopSnackBar(
                    Overlay.of(context),
                    const CustomSnackBar.error(
                      message: "Thumbnail harus diisi",
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
                  _tExamService.addExam(name,  selectedClass, description, thumbnail['byte'], thumbnail['extension'], isRandom, int.parse(time)).then((value) {
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
                        context.read<TExamProvider>().addExamInactive(response);
                        showTopSnackBar(
                          Overlay.of(context),
                          const CustomSnackBar.success(
                            message: "Ujian baru berhasil dibuat",
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
              child: Text(loadingProvider.isLoading ? "Loading..." : "Tambah Ujian")
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