import 'package:flutter/material.dart';

import '../../config/api.dart';
import '../../models/teacher/t_exam_model.dart';
import '../../services/teacher/t_exam_service.dart';
import 't_exam_add.dart';

class TExam extends StatefulWidget {
  const TExam({super.key});

  @override
  State<TExam> createState() => _TExamState();
}

class _TExamState extends State<TExam> {
  final Api _api = Api();
  final TExamService _tExamService = TExamService();
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
        title: const Text("Daftar Ujian"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Tambah Ujian',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const TExamAdd()));
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Keluar',
            onPressed: () {
              
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refresh,
        child: FutureBuilder(
          future: _tExamService.getExam(),
          builder: (BuildContext ctx, AsyncSnapshot<TExamModel> snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text("Something wrong with message: ${snapshot.error.toString()}"));
            } else if (snapshot.connectionState == ConnectionState.done) {
              List<Exam>? exam = snapshot.data?.examInActive;
              return _buildListView(context, exam);
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }
        ),
      ),
    );
  }

  ListView _buildListView(context, List<Exam>? exam) {
    return ListView.builder(
      itemCount: exam?.length,
      itemBuilder: (ctx, index) {
        Exam data = exam![index];
        
        String src = _api.tBaseUrlAsset + data.thumbnail;
        data.thumbnail = src;

        return GestureDetector(
          onTap: () {
            // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => HomeShow(home: home)));
          },
          child: Container(
            padding: const EdgeInsets.all(4.0),
            width: double.maxFinite,
            child: Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(data.thumbnail, width: 80.0),
        
                    const SizedBox(width: 10.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 230,
                          child: Text(data.name, style: const TextStyle(
                            fontSize: 16.0,
                          ),
                          overflow: TextOverflow.ellipsis,
                          ),
                        ),

                        const SizedBox(height: 8.0),
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => HomeShow(home: home)));
                              },
                              style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll<Color>(Colors.orange),
                                elevation: MaterialStatePropertyAll(0)
                              ),
                              child: const Text("Edit"),
                            ),

                            const SizedBox(width: 10.0),
                            ElevatedButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (ctx) {
                                    return AlertDialog(
                                      title: const Text("Peringatan"),
                                      content: Text("Apakah kamu yakin ingin menghapus ujian ${data.name}?"),
                                      actions: <Widget>[
                                        ElevatedButton(
                                          style: const ButtonStyle(
                                            backgroundColor: MaterialStatePropertyAll<Color>(Colors.red),
                                            elevation: MaterialStatePropertyAll(0)
                                          ),
                                          onPressed: () {
                                            Navigator.pop(context);
                                            _tExamService.deleteExam(data.id).then((value) {
                                              setState(() {});
                                              SnackBar snackBar = const SnackBar(
                                                content: Text("Hapus data berhasil"),
                                              );
                                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                            }).catchError((err) {
                                              SnackBar snackBar = const SnackBar(
                                                content: Text("Terjadi Kesalahan"),
                                              );
                                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                            });
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
                    )
                  ],
                ),
              )
            )
          ),
        );
      },
    );
  }
}