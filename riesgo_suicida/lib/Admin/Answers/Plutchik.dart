import 'package:flutter/material.dart';

class Plutchik extends StatelessWidget {
  final String uid;
  const Plutchik({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riesgo Suicida Plutchik answers'),
        centerTitle: true,
      ),
    );
  }
}
