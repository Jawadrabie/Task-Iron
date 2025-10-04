import 'package:flutter/material.dart';

class SteelLoadingWidget extends StatelessWidget {
  const SteelLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: Colors.black),
          SizedBox(height: 16),
          Text('جاري تحميل البيانات...', style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
