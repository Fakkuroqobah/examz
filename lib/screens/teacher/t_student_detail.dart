import 'package:flutter/material.dart';

import '../../widgets/question_card_student.dart';

class TStudentDetail extends StatefulWidget {
  const TStudentDetail({super.key});

  @override
  State<TStudentDetail> createState() => _TStudentDetailState();
}

class _TStudentDetailState extends State<TStudentDetail> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  
  Future<void> _refresh() async {
    setState(() {});
  }
  
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _refreshIndicatorKey.currentState?.show());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Siswa"),
        elevation: 0,
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refresh,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text("M. Fakkuroqobah", style: TextStyle(fontSize: 20.0)),

                      const SizedBox(height: 6.0),
                      const Text("Nilai 98/100", style: TextStyle(fontSize: 16.0)),
              
                      const SizedBox(height: 6.0),
                      Text("Kelas 1",
                        style: TextStyle(color: Colors.black.withOpacity(0.6)),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 8.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ElevatedButton(onPressed: () {}, child: const Text("IPA")),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ElevatedButton(onPressed: () {}, child: const Text("IPS")),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ElevatedButton(onPressed: () {}, child: const Text("MATEMATIKA")),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 8.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Daftar Soal & Jawaban"),
                  ],
                ),
              ),

              const SizedBox(height: 8.0),
              Expanded(
                child: ListView(
                  children: const [
                    QuestionCardStudent(),
                    QuestionCardStudent(),
                    QuestionCardStudent(),
                    QuestionCardStudent(),
                    QuestionCardStudent(),
                  ],
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}