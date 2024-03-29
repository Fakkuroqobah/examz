import 'package:flutter/material.dart';

import '../configs/constant.dart';

class EmptyCondition extends StatelessWidget {
  
  const EmptyCondition({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height - 100.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("${Constant.assetUrl}/empty.png", width: 200.0),
    
          const SizedBox(height: 4.0),
          const Text("Belum ada data", style: TextStyle(fontSize: 16.0, color: Colors.grey))
        ],
      ),
    );
  }
}