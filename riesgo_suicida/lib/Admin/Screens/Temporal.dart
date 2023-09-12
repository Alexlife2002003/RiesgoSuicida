import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:riesgo_suicida/Admin/Answers/Desesperanza.dart';
import 'package:riesgo_suicida/Admin/Answers/Ideacion.dart';
import 'package:riesgo_suicida/Admin/Answers/Plutchik.dart';
import 'package:riesgo_suicida/Answers/APGAR_answers.dart';
import 'package:riesgo_suicida/Answers/Desesperanza_answers.dart';
import 'package:riesgo_suicida/Answers/Ideacion_answers.dart';
import 'package:riesgo_suicida/Answers/Plutchik_answers.dart';
import 'package:riesgo_suicida/User/Screens/Dashboard.dart';
import 'package:riesgo_suicida/User/Screens/first_quiz.dart';
import 'package:riesgo_suicida/User/Screens/third_quiz.dart';

var edad = "";
var genero = "";
var programaAcademico = "";
var correo = "";
var firstquiz = 0;
var secondquiz = 0;
var thirdquiz = 0;
var fourthquiz = 0;

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

    DocumentSnapshot puntajesSnapshot = await FirebaseFirestore.instance
        .collection("Puntajes")
        .doc(widget.uid)
        .get();

    if (puntajesSnapshot.exists) {
      Map<String, dynamic>? puntajesData =
          puntajesSnapshot.data() as Map<String, dynamic>?;

      if (puntajesData != null) {
        setState(() {
          firstquiz = puntajesData['primero'];
          secondquiz = puntajesData['segundo'];
          thirdquiz = puntajesData['tercero'];
          fourthquiz = puntajesData['cuarto'];
        });
      } else {
        print('"primero" field does not exist in the document');
      }
    } else {
      print('Document does not exist in the database');
    }

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

    Color firstCircle = Colors.grey;
    Color secondCircle = Colors.grey;
    Color thirdCircle = Colors.grey;
    Color fourthCircle = Colors.grey;

    if (firstquiz >= 0 && firstquiz <= 8) {
      firstCircle = Colors.green;
    } else if (firstquiz >= 9 && firstquiz <= 14) {
      firstCircle = Colors.yellow;
    } else if (firstquiz >= 15 && firstquiz <= 20) {
      firstCircle = Colors.red;
    }

    if (secondquiz >= 0 && secondquiz <= 12) {
      secondCircle = Colors.green;
    } else if (secondquiz >= 13 && secondquiz <= 24) {
      secondCircle = Colors.yellow;
    } else if (secondquiz >= 25 && secondquiz <= 38) {
      secondCircle = Colors.red;
    }

    if (thirdquiz >= 0 && thirdquiz <= 5) {
      thirdCircle = Colors.green;
    } else if (thirdquiz >= 6 && thirdquiz <= 10) {
      thirdCircle = Colors.yellow;
    } else if (thirdquiz >= 11 && thirdquiz <= 15) {
      thirdCircle = Colors.red;
    }

    if (fourthquiz >= 7 && fourthquiz <= 10) {
      fourthCircle = Colors.green;
    } else if (fourthquiz >= 4 && fourthquiz <= 6) {
      fourthCircle = Colors.yellow;
    } else if (fourthquiz >= 0 && fourthquiz <= 3) {
      fourthCircle = Colors.red;
    }
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
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          SizedBox(
            height: 240,
            width: 360,
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
                        offset: const Offset(0, 3))
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
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(' $programaAcademico'),
                    const Text(
                      ' Genero:',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text('  $genero'),
                    const Text(
                      ' Correo Electronico:',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text('  $correo'),
                  ],
                )),
          ),
          const SizedBox(
            height: 50,
          ),
          Container(
            width: 350, // Adjust the width as needed
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: firstCircle, // Define your colors here
                      ),
                    ),
                    SizedBox(width: 20),
                    Text(
                      'Desesperanza de Beck: $firstquiz',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: secondCircle, // Define your colors here
                      ),
                    ),
                    SizedBox(width: 20),
                    Text(
                      'Ideacion Suicida: $secondquiz',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: thirdCircle, // Define your colors here
                      ),
                    ),
                    SizedBox(width: 20),
                    Text(
                      'Riesgo Suicida de Plutchik: $thirdquiz',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: fourthCircle, // Define your colors here
                      ),
                    ),
                    SizedBox(width: 20),
                    Text(
                      'Apgar Familiar: $fourthquiz',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ],
            ),
          )
        ]),
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
