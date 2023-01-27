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
  final TextEditingController _controllerDescription = TextEditingController();

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
        title: const Text("Tambah Ujian"),
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
                decoration: const InputDecoration(
                  labelText: "Nama ujian",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(borderSide: BorderSide.none)
                ),
              ),
      
              const SizedBox(height: 12.0),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
                child: DropdownButton<String>(
                  isExpanded: true,
                  hint: const Text("Pilih Kelas"),
                  value: _valClass,
                  items: const [
                    DropdownMenuItem(value: '1', child: Text('Kelas 1')),
                    DropdownMenuItem(value: '2', child: Text('Kelas 2')),
                    DropdownMenuItem(value: '3', child: Text('Kelas 3')),
                  ],
                  underline: Container(
                    height: 1.0,
                    decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.transparent, width: 0.0))
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _valClass = value!;
                    });
                  },
                ),
              ),

              const SizedBox(height: 12.0),
              TextField(
                controller: _controllerDescription,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  labelText: "Deskripsi ujian",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(borderSide: BorderSide.none)
                ),
              ),
      
              const SizedBox(height: 12.0),
              thumbnailFile != null ?
              Image.file(
                File(thumbnailFile!.path),
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
                height: 300,
              )
              : const Text("Tidak ada gambar", style: TextStyle(fontSize: 16)),

              const SizedBox(height: 12.0),
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
                  child: const Text("Pilih Gambar"),
                ),
              ),

              const SizedBox(height: 8.0),
              ElevatedButton(
                onPressed: () async {
                  setState(() => _isLoading = true);

                  String name = _controllerName.text.toString();
                  String description = _controllerDescription.text.toString();
                  // String description = await _controllerDescription.getText();

                  if(thumbnailFile == null) {
                    setState(() => _isLoading = false);
                    SnackBar snackBar = const SnackBar(content: Text("Thumbnail harus diisi"));
                    if (!mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }else if(name == "") {
                    setState(() => _isLoading = false);
                    SnackBar snackBar = const SnackBar(content: Text("Nama ujian harus diisi"));
                    if (!mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }else if(_valClass == "") {
                    setState(() => _isLoading = false);
                    SnackBar snackBar = const SnackBar(content: Text("Kelas harus diisi"));
                    if (!mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }

                  _tExamService.addExam(name,  _valClass, description, thumbnailFile!, thumbnailName).then((value) {
                    setState(() => _isLoading = false);
                    Navigator.pop(context, 'refresh');
                  }).catchError((err) {
                    setState(() => _isLoading = false);
                    SnackBar snackBar = const SnackBar(content: Text("Terjadi Kesalahan"));
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