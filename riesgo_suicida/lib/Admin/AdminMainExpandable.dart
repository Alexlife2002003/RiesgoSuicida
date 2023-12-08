import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riesgo_suicida/Admin/Screens/AppDrawerAdmin.dart';
import 'package:riesgo_suicida/Admin/Screens/agregarContactos.dart';

class AdminMainExpandable extends StatefulWidget {
  const AdminMainExpandable({Key? key}) : super(key: key);

  @override
  State<AdminMainExpandable> createState() => _AdminMainState();
}

class _AdminMainState extends State<AdminMainExpandable> {
  List<Map<String, dynamic>> users = [];

  @override
  void initState() {
    super.initState();
    fetchUsersFromFirestore();
  }

  void fetchUsersFromFirestore() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .orderBy('timestamp', descending: true)
          .get();

      for (QueryDocumentSnapshot document in querySnapshot.docs) {
        bool isAdmin = document['admin'] ?? false;
        if (!isAdmin) {
          String userName = document['firstname'] + " " + document['lastname'];
          String uid = document.id;
          users.add({'name': userName, 'uid': uid});
        }
      }

      setState(() {});
    } catch (e) {
      print('Error fetching users: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppDrawerMain(
      currentPage: "AdminMainExpandable",
      appbarText: "Evaluaciones realizadas",
      content: Scaffold(
        backgroundColor: const Color.fromRGBO(229, 251, 255, 1),
        body: ListView(
          children: users.map<Widget>((user) {
            return UserExpansionTile(user: user);
          }).toList(),
        ),
      ),
    );
  }
}

class UserExpansionTile extends StatefulWidget {
  final Map<String, dynamic> user;

  UserExpansionTile({required this.user});

  @override
  _UserExpansionTileState createState() => _UserExpansionTileState();
}

class _UserExpansionTileState extends State<UserExpansionTile> {
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
          title: Text(widget.user['name']),
          onExpansionChanged: (expanded) {
            toggleExpand();
          },
          backgroundColor: isExpanded ? Color.fromRGBO(229, 251, 255, 1) : null,
          children: <Widget>[
            Temporal(uid: widget.user['uid'], fullname: widget.user['name']),
          ],
        ),
      ],
    );
  }
}

class Temporal extends StatefulWidget {
  final String uid;
  final String fullname;

  Temporal({required this.uid, required this.fullname});

  @override
  _TemporalState createState() => _TemporalState();
}

class _TemporalState extends State<Temporal> {
  String edad = "";
  String genero = "";
  String programaAcademico = "";
  String correo = "";
  int firstquiz = 0;
  int secondquiz = 0;
  int thirdquiz = 0;
  int fourthquiz = 0;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

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
    // Define circle colors
    Color firstCircle = Colors.grey;
    Color secondCircle = Colors.grey;
    Color thirdCircle = Colors.grey;
    Color fourthCircle = Colors.grey;

    // Set circle colors based on quiz scores
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

    return Column(
      children: <Widget>[
        ListTile(
          title: Column(
            children: [
              Row(
                children: [
                  const Text('Edad: ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(edad),
                ],
              ),
              Row(
                children: [
                  const Text('Genero: ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(genero),
                ],
              ),
              Row(
                children: [
                  const Text('Programa Academico: ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                
                ],
              ),
                Row(
                  children: [
                    Text(programaAcademico),
                  ],
                ),
              const Row(
                children: [
                  Text('Correo Electronico: ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              Row(
                children: [
                  Text(correo),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: firstCircle,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Desesperanza de Beck: $firstquiz',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: secondCircle,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Ideacion Suicida: $secondquiz',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: thirdCircle,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Riesgo Suicida de Plutchik: $thirdquiz',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: fourthCircle,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Apgar Familiar: $fourthquiz',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
