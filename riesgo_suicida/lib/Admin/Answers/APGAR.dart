import 'package:flutter/material.dart';

class APGAR extends StatelessWidget {
  final String uid;
  const APGAR({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('APGAR answers'),
        centerTitle: true,
      ),
    );
  }
}
