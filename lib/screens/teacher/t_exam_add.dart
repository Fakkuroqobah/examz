import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../services/teacher/t_exam_service.dart';

class TExamAdd extends StatefulWidget {
  const TExamAdd({super.key});

  @override
  State<TExamAdd> createState() => _TExamAddState();
}

class _TExamAddState extends State<TExamAdd> {
  bool _isLoading = false;
  final TExamService _tExamService = TExamService();
  final TextEditingController _controllerName = TextEditingController();

  String thumbnailName = "";
  File? thumbnailFile;
  
  String _valClass = "1";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Artikel"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            children: [
              TextField(
                controller: _controllerName,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(labelText: "Nama ujian"),
              ),
      
              const SizedBox(height: 8.0),
              DropdownButton<String>(
                isExpanded: true,
                hint: const Text("Pilih Kelas"),
                value: _valClass,
                items: const [
                  DropdownMenuItem(value: '1', child: Text('Kelas 1')),
                  DropdownMenuItem(value: '2', child: Text('Kelas 2')),
                  DropdownMenuItem(value: '3', child: Text('Kelas 3')),
                ],
                onChanged: (String? value) {
                  setState(() {
                    _valClass = value!;
                  });
                },
              ),
      
              const SizedBox(height: 8.0),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);
                    
                    if (result != null) {
                      File file = File(result.files.single.path.toString());
                      setState(() {
                        thumbnailFile = file;
                        thumbnailName = result.files.single.name;
                      });
                    }
                  },
                  child: Text((thumbnailName == "") ? "Tidak Ada File" : thumbnailName),
                ),
              ),

              const SizedBox(height: 8.0),
              ElevatedButton(
                onPressed: () async {
                  setState(() => _isLoading = true);

                  String name = _controllerName.text.toString();

                  _tExamService.addExam(name,  _valClass, thumbnailFile!, thumbnailName).then((value) {
                    setState(() => _isLoading = false);
                    Navigator.pop(context);
                  }).catchError((err) {
                    setState(() => _isLoading = false);
                    SnackBar snackBar = const SnackBar(
                      content: Text("Terjadi Kesalahan"),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  });
                },
                child: Text(_isLoading ? "Loading..." : "Tambah Ujian")
              )
            ],
          ),
        ),
      ),
    );
  }
}