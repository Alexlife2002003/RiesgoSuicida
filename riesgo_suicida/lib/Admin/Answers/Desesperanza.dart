import 'package:flutter/material.dart';

class Desesperanza extends StatelessWidget {
  final String uid;
  const Desesperanza({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Escala de Desesperanza Answers'),
        centerTitle: true,
      ),
    );
  }
}
