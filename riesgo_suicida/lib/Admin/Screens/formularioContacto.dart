import 'package:flutter/material.dart';

class formularioContacto extends StatefulWidget {
  const formularioContacto({super.key});

  @override
  State<formularioContacto> createState() => _formularioContactoState();
}

class _formularioContactoState extends State<formularioContacto> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(185, 236, 245, 1),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      backgroundColor: const Color.fromRGBO(229, 251, 255, 1),
      body:Column(
        children: [
          Text("Especialización"),
          Text("Tipo de unidad Médica"),
          Text("Ubicación"),
          Text("Zacatecas,Zac"),
          Text("Dirección"),
          Text("Teléfono de Contacto"),

        ],
      ),
    );
  }
}