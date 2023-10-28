import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riesgo_suicida/Admin/Screens/AppDrawerAdmin.dart';
import 'package:riesgo_suicida/Admin/Screens/formularioContacto.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class agregarContactos extends StatefulWidget {
  const agregarContactos({Key? key}) : super(key: key);

  @override
  State<agregarContactos> createState() => _AdminMainState();
}

class _AdminMainState extends State<agregarContactos> {
  Color btnColor = Color.fromARGB(255, 74, 101, 211);
  List<Map<String, dynamic>> contactos = [];

  @override
  void initState() {
    super.initState();
    fetchContactosFromFirestore();
  }

  void fetchContactosFromFirestore() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Contactos')
          .orderBy('Nombre_Unidad_Medica',
              descending:
                  false) // Cambia el campo para ordenar según tus necesidades
          .get();

      for (QueryDocumentSnapshot document in querySnapshot.docs) {
        String nombreUnidadMedica = document['Nombre_Unidad_Medica'] ?? "";
        String especializacion = document['Especializacion'] ?? "";
        String direccion = document['Direccion'] ?? "";
        String telefonoContacto = document['Telefono_Contacto'] ?? "";
        String tipoUnidadMedica = document['Tipo_Unidad_Medica'] ?? "";
        String ubicacion = document['Ubicacion'] ?? "";

        contactos.add({
          'Nombre_Unidad_Medica': nombreUnidadMedica,
          'Especializacion': especializacion,
          'Direccion': direccion,
          'Telefono_Contacto': telefonoContacto,
          'Tipo_Unidad_Medica': tipoUnidadMedica,
          'Ubicacion': ubicacion,
        });
      }

      setState(() {});
    } catch (e) {
      print('Error fetching contactos: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppDrawerMain(
      appbarText: "Contactos de apoyo profesional",
      currentPage: "agregarContactos",
      content: Scaffold(
        bottomNavigationBar: BottomAppBar(
          color: Color.fromRGBO(229, 251, 255, 1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 50,

                width: 200, // Adjust the width as needed
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(btnColor),
                  ),
                  onPressed: () {
                    print("se presiono");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const formularioContacto()),
                    );
                  },
                  child: Text('Agregar nuevo contacto'),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: const Color.fromRGBO(229, 251, 255, 1),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                children: contactos.map<Widget>((contacto) {
                  return ContactoExpansionTile(contacto: contacto);
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ContactoExpansionTile extends StatefulWidget {
  final Map<String, dynamic> contacto;

  ContactoExpansionTile({required this.contacto});

  @override
  _ContactoExpansionTileState createState() => _ContactoExpansionTileState();
}

class _ContactoExpansionTileState extends State<ContactoExpansionTile> {
  bool isExpanded = false;

  void toggleExpand() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ExpansionTile(
          title: Text(widget.contacto['Nombre_Unidad_Medica']),
          onExpansionChanged: (expanded) {
            toggleExpand();
          },
          backgroundColor: isExpanded ? Colors.grey : null,
          children: <Widget>[
            ContactoInfo(contacto: widget.contacto),
          ],
        ),
      ],
    );
  }
}

class ContactoInfo extends StatelessWidget {
  final Map<String, dynamic> contacto;

  ContactoInfo({required this.contacto});
  void _makePhoneCall(String phoneNumber) async {
    await FlutterPhoneDirectCaller.callNumber(phoneNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                textAlign: TextAlign.left,
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Especialización: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: contacto['Especializacion']),
                  ],
                ),
              ),
              RichText(
                textAlign: TextAlign.left,
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Tipo de Unidad Médica: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: contacto['Tipo_Unidad_Medica']),
                  ],
                ),
              ),
              RichText(
                textAlign: TextAlign.left,
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Ubicación: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: contacto['Ubicacion']),
                  ],
                ),
              ),
              RichText(
                textAlign: TextAlign.left,
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Dirección: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: contacto['Direccion']),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  _makePhoneCall(contacto['Telefono_Contacto']);
                },
                child: RichText(
                  textAlign: TextAlign.left,
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Teléfono de Contacto: ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: contacto['Telefono_Contacto'],
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
