import 'package:flutter/material.dart';

class FactoresProteccion extends StatefulWidget {
  const FactoresProteccion({super.key});

  @override
  State<FactoresProteccion> createState() => _FactoresProteccionState();
}

class _FactoresProteccionState extends State<FactoresProteccion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(185, 236, 245, 1),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: const Color.fromRGBO(229, 251, 255, 1),
    );
  }
}