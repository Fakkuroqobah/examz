import 'package:flutter/material.dart';

class QuestionCard extends StatefulWidget {
  const QuestionCard({super.key});

  @override
  State<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
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

                SizedBox(width: 10.0),
                Text("Apa makna dari mencintai?"),
              ],
            ),
            
            const Divider(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("Menyangi setulus hati"),
                Text("Mencampakan keinginannya"),
                Text("Tidak pernah mengabari"),
                Text("Tidak perhatian di kala manja"),
              ],
            ),
            
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (ctx) {
                        return AlertDialog(
                          title: const Text("Peringatan"),
                          content: const Text("Apakah kamu yakin ingin menghapus pertanyaan ini?"),
                          actions: <Widget>[
                            ElevatedButton(
                              style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll<Color>(Colors.red),
                                elevation: MaterialStatePropertyAll(0)
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Iya"),
                            ),
                            ElevatedButton(
                              child: const Text("Tidak"),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            )
                          ],
                        );
                      }
                    );
                  },
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll<Color>(Colors.red),
                    elevation: MaterialStatePropertyAll(0)
                  ),
                  child: const Text("Hapus"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}