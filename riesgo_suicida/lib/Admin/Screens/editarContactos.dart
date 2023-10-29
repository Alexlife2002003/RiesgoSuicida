import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:riesgo_suicida/Admin/Screens/agregarContactos.dart';

class editarContactos extends StatefulWidget {
  Map<String, dynamic> contacto;
  editarContactos({super.key, required this.contacto});

  @override
  State<editarContactos> createState() => _editarContactosState();
}

class _editarContactosState extends State<editarContactos> {
  final _unidadMedicaController = TextEditingController();
  final _especializacionController = TextEditingController();
  final _TipoUnidadController = TextEditingController();
  final _ubicacionController = TextEditingController();
  final _direccionController = TextEditingController();
  final _telefonoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String unidadOriginal = widget.contacto['Nombre_Unidad_Medica'].toString();
    _unidadMedicaController.text = unidadOriginal;
    _especializacionController.text = widget.contacto['Especializacion'];
    _TipoUnidadController.text = widget.contacto['Tipo_Unidad_Medica'];
    _ubicacionController.text = widget.contacto['Ubicacion'];
    _direccionController.text = widget.contacto['Direccion'];
    _telefonoController.text = widget.contacto['Telefono_Contacto'];

    double screenWidth = MediaQuery.of(context).size.width;

    Future<void> eliminar() async {
      try {
        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          // Reference to the user's "Users" collection
          CollectionReference contactosCollection =
              FirebaseFirestore.instance.collection('Contactos');

          //Query for the contacto document
          QuerySnapshot querySnapshot = await contactosCollection
              .where('Nombre_Unidad_Medica', isEqualTo: unidadOriginal)
              .get();

          if (querySnapshot.docs.isNotEmpty) {
            final contactoDoc = querySnapshot.docs.first;

            contactoDoc.reference.delete();
            Navigator.push(context,
                MaterialPageRoute(builder: ((context) => agregarContactos())));
          }
        }
      } catch (e) {
        print("No se ha eliminado");
      }
    }

    void showSnackbar(String message, Color backgroundColor) {
      final snackBar = SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    Future<void> editar() async {
      try {
        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          // Reference to the user's "Users" collection
          CollectionReference contactosCollection =
              FirebaseFirestore.instance.collection('Contactos');

          //Query for the contacto document
          QuerySnapshot querySnapshot = await contactosCollection
              .where('Nombre_Unidad_Medica', isEqualTo: unidadOriginal)
              .get();

          if (querySnapshot.docs.isNotEmpty) {
            final contactoDoc = querySnapshot.docs.first.reference;

            await contactoDoc.update({
              'Nombre_Unidad_Medica': _unidadMedicaController.text,
              'Especializacion': _especializacionController.text,
              'Tipo_Unidad_Medica': _TipoUnidadController.text,
              'Ubicacion': _ubicacionController.text,
              'Direccion': _direccionController.text,
              'Telefono_Contacto': _telefonoController.text
            });

            Navigator.push(context,
                MaterialPageRoute(builder: ((context) => agregarContactos())));
          }
        }
      } catch (e) {
        print("No se ha eliminado");
      }
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

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const agregarContactos();
            },
          ),
        );
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
                    const BorderSide(color: Color.fromARGB(255, 74, 101, 211)),
                borderRadius: BorderRadius.circular(12.0),
              ),
              labelText: hintText,
              hintStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 24,
              ),
              labelStyle: const TextStyle(color: Colors.black),
              filled: true,
              fillColor: const Color.fromRGBO(207, 235, 240, 1),
            ),
            style: const TextStyle(color: Colors.black),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Editar contacto de ayuda',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: const Color.fromRGBO(185, 236, 245, 1),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: const Color.fromRGBO(229, 251, 255, 1),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  buildInputField(
                    'Unidad Médica',
                    _unidadMedicaController,
                    false,
                    TextInputType.text,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  buildInputField(
                    'Especialización',
                    _especializacionController,
                    false,
                    TextInputType.text,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  buildInputField(
                    'Tipo de unidad médica',
                    _TipoUnidadController,
                    false,
                    TextInputType.text,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  buildInputField(
                    'Ubicación',
                    _ubicacionController,
                    false,
                    TextInputType.text,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  buildInputField(
                    'Dirección',
                    _direccionController,
                    false,
                    TextInputType.text,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  buildInputField(
                    'Teléfono de contacto',
                    _telefonoController,
                    false,
                    TextInputType.phone,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: GestureDetector(
                onTap: editar,
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 74, 101, 211),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Text(
                        'Actualizar',
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
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: GestureDetector(
                onTap: eliminar,
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Text(
                        'Eliminar',
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
    );
  }
}
