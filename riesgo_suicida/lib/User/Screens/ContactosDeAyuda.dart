import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class ContactosDeAyuda extends StatefulWidget {
  const ContactosDeAyuda({Key? key}) : super(key: key);

  @override
  State<ContactosDeAyuda> createState() => _AdminMainState();
}

class _AdminMainState extends State<ContactosDeAyuda> {
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
      showSnackbar('Error al obtener contactos', Colors.red);
    }
  }

  void showSnackbar(String message, Color backgroundColor) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: backgroundColor,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(185, 236, 245, 1),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: const Color.fromRGBO(229, 251, 255, 1),
      body: ListView(
        children: contactos.map<Widget>((contacto) {
          return ContactoExpansionTile(contacto: contacto);
        }).toList(),
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
                    const TextSpan(
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
                    const TextSpan(
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
                    const TextSpan(
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
                    const TextSpan(
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
                      const TextSpan(
                        text: 'Teléfono de Contacto: ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: contacto['Telefono_Contacto'],
                        style: const TextStyle(
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
