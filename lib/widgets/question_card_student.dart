import 'package:flutter/material.dart';

class QuestionCardStudent extends StatefulWidget {
  const QuestionCardStudent({super.key});

  @override
  State<QuestionCardStudent> createState() => _QuestionCardStudentState();
}

class _QuestionCardStudentState extends State<QuestionCardStudent> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Text("1.", style: TextStyle(fontWeight: FontWeight.bold)),

                SizedBox(width: 8.0),
                Text("Bahasa HTML diciptakan oleh?"),
              ],
            ),
            
            const Divider(),
            const Text("Jawaban opsi 1", style: TextStyle(color: Colors.green)),
            const Text("Jawaban opsi 2"),
            const Text("Jawaban opsi 3"),
            const Text("Jawaban opsi 4"),
            const Text("Jawaban opsi 5"),
          ],
        ),
      ),
    );
  }
}