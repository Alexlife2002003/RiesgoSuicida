import 'package:flutter/material.dart';

class Ideacion extends StatelessWidget {
  final String uid;
  const Ideacion(
    {required this.uid});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Ideacion Suicida Answers'),
        centerTitle: true,
      ),
    );
  }
}