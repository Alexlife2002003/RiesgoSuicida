import 'package:flutter/material.dart';

class Ideacion extends StatelessWidget {
  final String uid;
  const Ideacion({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ideacion Suicida Answers'),
        centerTitle: true,
      ),
    );
  }
}
