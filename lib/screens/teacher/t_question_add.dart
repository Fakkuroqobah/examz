import 'package:flutter/material.dart';

class TQuestionAdd extends StatefulWidget {
  const TQuestionAdd({super.key});

  @override
  State<TQuestionAdd> createState() => _TQuestionAddState();
}

class _TQuestionAddState extends State<TQuestionAdd> {
  final bool _isLoading = false;
  final TextEditingController _controllerSubject = TextEditingController();
  final TextEditingController _controllerQuestion1 = TextEditingController();
  final TextEditingController _controllerQuestion2 = TextEditingController();
  final TextEditingController _controllerQuestion3 = TextEditingController();
  final TextEditingController _controllerQuestion4 = TextEditingController();
  final TextEditingController _controllerQuestion5 = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Pertanyaan"),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16.0),
              const Text("Pertanyaan"),

              const SizedBox(height: 8.0),
              TextField(
                controller: _controllerSubject,
                maxLines: null,
                keyboardType: TextInputType.multiline,
              ),

              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Jawaban Soal Opsi 1"),
                  Checkbox(
                    checkColor: Colors.white,
                    fillColor: MaterialStateProperty.resolveWith(getColor),
                    value: true,
                    onChanged: (bool? value) {
                      
                    },
                  )
                ],
              ),
              const SizedBox(height: 8.0),
              TextField(
                controller: _controllerQuestion1,
                maxLines: null,
                keyboardType: TextInputType.multiline,
              ),

              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Jawaban Soal Opsi 2"),
                  Checkbox(
                    checkColor: Colors.white,
                    fillColor: MaterialStateProperty.resolveWith(getColor),
                    value: false,
                    onChanged: (bool? value) {
                      
                    },
                  )
                ],
              ),
              const SizedBox(height: 8.0),
              TextField(
                controller: _controllerQuestion2,
                maxLines: null,
                keyboardType: TextInputType.multiline,
              ),

              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Jawaban Soal Opsi 3"),
                  Checkbox(
                    checkColor: Colors.white,
                    fillColor: MaterialStateProperty.resolveWith(getColor),
                    value: false,
                    onChanged: (bool? value) {
                      
                    },
                  )
                ],
              ),
              const SizedBox(height: 8.0),
              TextField(
                controller: _controllerQuestion3,
                maxLines: null,
                keyboardType: TextInputType.multiline,
              ),

              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Jawaban Soal Opsi 4"),
                  Checkbox(
                    checkColor: Colors.white,
                    fillColor: MaterialStateProperty.resolveWith(getColor),
                    value: false,
                    onChanged: (bool? value) {
                      
                    },
                  )
                ],
              ),
              const SizedBox(height: 8.0),
              TextField(
                controller: _controllerQuestion4,
                maxLines: null,
                keyboardType: TextInputType.multiline,
              ),

              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Jawaban Soal Opsi 5"),
                  Checkbox(
                    checkColor: Colors.white,
                    fillColor: MaterialStateProperty.resolveWith(getColor),
                    value: false,
                    onChanged: (bool? value) {
                      
                    },
                  )
                ],
              ),
              const SizedBox(height: 8.0),
              TextField(
                controller: _controllerQuestion5,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                
              ),

              const SizedBox(height: 8.0),
              ElevatedButton(
                onPressed: () async {
                  
                },
                child: Text(_isLoading ? "Loading..." : "Tambah Pertanyaan")
              )
            ],
          ),
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