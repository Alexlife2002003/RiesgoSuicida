import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:riesgo_suicida/Admin/Screens/agregarContactos.dart';

class formularioContacto extends StatefulWidget {
  const formularioContacto({super.key});

  @override
  State<formularioContacto> createState() => _formularioContactoState();
}

class _formularioContactoState extends State<formularioContacto> {
  final _unidadMedicaController = TextEditingController();
  final _especializacionController = TextEditingController();
  final _TipoUnidadController = TextEditingController();
  final _ubicacionController = TextEditingController();
  final _direccionController = TextEditingController();
  final _telefonoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    void showSnackbar(String message, Color backgroundColor) {
      final snackBar = SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    void agregar() async {
      if (_unidadMedicaController.text.isEmpty ||
          _especializacionController.text.isEmpty ||
          _direccionController.text.isEmpty ||
          _telefonoController.text.isEmpty ||
          _TipoUnidadController.text.isEmpty ||
          _ubicacionController.text.isEmpty) {
        showSnackbar('No se pueden agregar campos vacios', Colors.red);
        return;
      }
      Map<String, dynamic> contactData = {
        'Nombre_Unidad_Medica': _unidadMedicaController.text.trim(),
        'Especializacion': _especializacionController.text.trim(),
        'Direccion': _direccionController.text.trim(),
        'Telefono_Contacto': _telefonoController.text.trim(),
        'Tipo_Unidad_Medica': _TipoUnidadController.text.trim(),
        'Ubicacion': _ubicacionController.text.trim(),
      };
      try {
        // Replace 'your_collection_name' with the actual name of your Firestore collection
        await FirebaseFirestore.instance
            .collection('Contactos')
            .add(contactData);
        showSnackbar('Contacto agregado correctamente', Colors.green);
        print('Contact added successfully');
        Navigator.pop(context);
      } catch (e) {
        showSnackbar('Error al agregar el contacto', Colors.red);
      }
    }

    Widget buildInputField(String hintText, TextEditingController controller,
        bool obscureText, TextInputType inputType) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: inputType,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black, width: 1.0),
                borderRadius: BorderRadius.circular(12.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Color.fromARGB(255, 74, 101, 211)),
                borderRadius: BorderRadius.circular(12.0),
              ),
              labelText: hintText,
              hintStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 24,
              ),
              labelStyle: TextStyle(color: Colors.black),
              filled: true,
              fillColor: Color.fromRGBO(207, 235, 240, 1),
            ),
            style: const TextStyle(color: Colors.black),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Agregar contacto de ayuda',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: const Color.fromRGBO(185, 236, 245, 1),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      backgroundColor: const Color.fromRGBO(229, 251, 255, 1),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            buildInputField(
              'Unidad Médica',
              _unidadMedicaController,
              false,
              TextInputType.text,
            ),
            SizedBox(
              height: 10,
            ),
            buildInputField(
              'Especialización',
              _especializacionController,
              false,
              TextInputType.text,
            ),
            SizedBox(
              height: 10,
            ),
            buildInputField(
              'Tipo de unidad médica',
              _TipoUnidadController,
              false,
              TextInputType.text,
            ),
            SizedBox(
              height: 10,
            ),
            buildInputField(
              'Ubicación',
              _ubicacionController,
              false,
              TextInputType.text,
            ),
            SizedBox(
              height: 10,
            ),
            buildInputField(
              'Dirección',
              _direccionController,
              false,
              TextInputType.text,
            ),
            SizedBox(
              height: 10,
            ),
            buildInputField(
              'Teléfono de contacto',
              _telefonoController,
              false,
              TextInputType.phone,
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: GestureDetector(
                  onTap: agregar,
                  child: Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 74, 101, 211),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Text(
                          'Agregar',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
