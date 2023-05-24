import 'package:fancy_drawer/fancy_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/exam_model.dart';
import '../../provider/admin/a_exam_provider.dart';

import '../../services/admin/a_auth_service.dart';
import '../../widgets/a_exam_card.dart';
import '../../widgets/empty_condition.dart';
import 'a_data_drawer.dart';

class AExam extends StatefulWidget {
  const AExam({super.key});

  @override
  State<AExam> createState() => _AExamState();
}

class _AExamState extends State<AExam> with SingleTickerProviderStateMixin {
  final AAuthService _aAuthService = AAuthService();
  late FancyDrawerController _controllerDrawer;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  
  Future<void> _refresh() async {
    Provider.of<AExamProvider>(context, listen: false).getExam();
  }
  
  @override
  void initState() {
    super.initState();
    _controllerDrawer = FancyDrawerController(
        vsync: this, duration: const Duration(milliseconds: 250))
      ..addListener(() {
        setState(() {});
      });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AExamProvider>(context, listen: false).getExam();
    });
  }

  @override
  void dispose() {
    _controllerDrawer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: FancyDrawerWrapper(
        backgroundColor: Colors.green,
        drawerPadding: const EdgeInsets.only(left: 26.0),
        controller: _controllerDrawer,
        drawerItems: dataDrawer(context, _aAuthService),
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Daftar Ujian"),
            elevation: 0,
            leading: IconButton(
              icon: const Icon(
                Icons.menu,
                color: Colors.white,
              ),
              onPressed: () {
                _controllerDrawer.toggle();
              },
            ),
          ),
          body: RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: _refresh,
            child: Consumer<AExamProvider>(
              builder: (_, aExam, __) {
                if(aExam.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
              
                if(aExam.hasError) {
                  return const Center(child: Text("Terjadi kesalahan pada server"));
                }
                
                return (aExam.examList.isNotEmpty) ? Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(height: 8.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Text("Jumlah ujian: ${aExam.examList.length}", 
                        style: const TextStyle(fontSize: 16.0, color: Colors.grey),
                      ),
                    ),
                    const Divider(),
                    
                    const SizedBox(height: 8.0),
                    Expanded(child: _buildListView(context, aExam.examList)),
                  ],
                ) : const EmptyCondition();
              },
            ),
          ),
        ),
      )
    );
  }

  ListView _buildListView(context, List<ExamModel> exam) {
    return ListView.builder(
      itemCount: exam.length,
      itemBuilder: (ctx, index) {
        ExamModel data = exam[index];

        return AExamCard(exam: data);
      },
    );
  }
}