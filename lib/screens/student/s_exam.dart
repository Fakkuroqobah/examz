import 'package:flutter/material.dart';

class SExam extends StatefulWidget {
  const SExam({super.key});

  @override
  State<SExam> createState() => _SExamState();
}

class _SExamState extends State<SExam> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Ujian"),
      ),
      body: Container(),
    );
  }
}