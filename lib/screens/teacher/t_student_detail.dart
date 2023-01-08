import 'package:flutter/material.dart';

import '../../widgets/question_card.dart';

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
                      Text("Kelas 1",
                        style: TextStyle(color: Colors.black.withOpacity(0.6)),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 8.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("Daftar Soal & Jawaban"),
                ],
              ),

              const SizedBox(height: 8.0),
              Expanded(
                child: ListView(
                  children: const [
                    QuestionCard(),
                    QuestionCard(),
                    QuestionCard(),
                    QuestionCard(),
                    QuestionCard(),
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