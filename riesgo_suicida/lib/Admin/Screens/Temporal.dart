import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:riesgo_suicida/Admin/Answers/Desesperanza.dart';
import 'package:riesgo_suicida/Admin/Answers/Ideacion.dart';
import 'package:riesgo_suicida/Admin/Answers/Plutchik.dart';
import 'package:riesgo_suicida/Answers/APGAR_answers.dart';
import 'package:riesgo_suicida/Answers/Desesperanza_answers.dart';
import 'package:riesgo_suicida/Answers/Ideacion_answers.dart';
import 'package:riesgo_suicida/Answers/Plutchik_answers.dart';

var edad = "";
var genero = "";
var programaAcademico = "";
var correo = "";

class Temporal extends StatefulWidget {
  final String uid;
  final String fullname;

  const Temporal({super.key, required this.uid, required this.fullname});

  @override
  State<Temporal> createState() => _TemporalState();
}

class _TemporalState extends State<Temporal> {
  void fetchUserData() async {
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection("Users")
        .doc(widget.uid)
        .get();

    if (documentSnapshot.exists) {
      Map<String, dynamic>? data =
          documentSnapshot.data() as Map<String, dynamic>?;

      if (data != null) {
        setState(() {
          edad = data['edad'];
          genero = data['genero'];
          programaAcademico = data['programaAcademico'];
          correo = data['correo'];
        });
      } else {
        print('"primero" field does not exist in the document');
      }
    } else {
      print('Document does not exist in the database');
    }
  }

  @override
  Widget build(BuildContext context) {
    fetchUserData();
    Color appbarColor = const Color.fromRGBO(185, 236, 245, 1);
    Color backgroundColor = const Color.fromRGBO(229, 251, 255, 1);
    Color btnColor = const Color.fromARGB(255, 74, 101, 211);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.fullname,
          style: const TextStyle(color: Colors.black),
        ),
        backgroundColor: appbarColor,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 240,
              width: 320,
              child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                      16,
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(.8),
                          spreadRadius: 4,
                          blurRadius: 8,
                          offset: Offset(0, 3))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        ' Nombre Completo:',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text('  ${widget.fullname}'),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(' Edad:',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(
                        height: 5,
                      ),
                      Text('  $edad'),
                      const Text(
                        ' Programa Academico:',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(' $programaAcademico'),
                      const Text(
                        ' Genero:',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text('  $genero'),
                      const Text(
                        ' Correo Electronico:',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text('  $correo'),
                    ],
                  )),
            ),
            const SizedBox(
              height: 50,
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 60,
              width: 280,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: btnColor,
                    padding: const EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          DesesperanzaAnswersPage(uid: widget.uid),
                    ),
                  );
                },
                child: const Text('Escala de Desesperanza de Beck'),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 60,
              width: 280,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: btnColor,
                    padding: const EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              IdeacionAnswersPage(uid: widget.uid)));
                },
                child: const Text('Escala de Ideacion Suicida'),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 60,
              width: 280,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: btnColor,
                    padding: const EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              PlutchikAnswersPage(uid: widget.uid)));
                },
                child: const Text('Escala de Riesgo Suicida de Plutchik'),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 60,
              width: 280,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: btnColor,
                    padding: const EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => APGARAnswersPage(uid: widget.uid),
                    ),
                  );
                },
                child: const Text('APGAR Familiar'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void navigateToTemporal(BuildContext context, String uid) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Temporal(uid: uid, fullname: widget.fullname),
      ),
    );
  }
}
