import 'package:flutter/material.dart';

class Plutchik extends StatelessWidget {
  final String uid;
  const Plutchik(
    {required this.uid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Riesgo Suicida Plutchik answers'  ),
        centerTitle: true,
      ),
    );
  }
}