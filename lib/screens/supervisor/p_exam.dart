import 'package:fancy_drawer/fancy_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/supervisor/p_exam_model.dart';

import '../../provider/supervisor/p_exam_provider.dart';
import '../../services/supervisor/p_auth_service.dart';
import '../../widgets/empty_condition.dart';
import '../../widgets/p_exam_card.dart';
import 'p_data_drawer.dart';

class PExam extends StatefulWidget {
  const PExam({super.key});

  @override
  State<PExam> createState() => _PExamState();
}

class _PExamState extends State<PExam> with SingleTickerProviderStateMixin {
  final PAuthService _pAuthService = PAuthService();
  late FancyDrawerController _controllerDrawer;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  
  Future<void> _refresh() async {
    Provider.of<PExamProvider>(context, listen: false).getExam();
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
      Provider.of<PExamProvider>(context, listen: false).getExam();
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
        drawerItems: dataDrawer(context, _pAuthService),
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
            child: Consumer<PExamProvider>(
              builder: (_, pExam, __) {
                if(pExam.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
              
                if(pExam.hasError) {
                  return const Center(child: Text("Terjadi kesalahan pada server"));
                }
                
                return (pExam.examList.isNotEmpty) ? Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(height: 8.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Text("Jumlah ujian: ${pExam.examList.length}", 
                        style: const TextStyle(fontSize: 16.0, color: Colors.grey),
                      ),
                    ),
                    const Divider(),
                    
                    const SizedBox(height: 8.0),
                    Expanded(child: _buildListView(context, pExam.examList)),
                  ],
                ) : const EmptyCondition();
              },
            ),
          ),
        ),
      )
    );
  }

  ListView _buildListView(context, List<PExamModel> exam) {
    return ListView.builder(
      itemCount: exam.length,
      itemBuilder: (ctx, index) {
        PExamModel data = exam[index];

        return PExamCard(exam: data);
      },
    );
  }
}