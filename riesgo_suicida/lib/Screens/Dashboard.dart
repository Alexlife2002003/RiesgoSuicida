import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;
final CollectionReference usersCollection = firestore.collection('Puntajes');
//var firstquiz;
//var secondquiz;
//var thirdquiz;
//var fourthquiz;
var first;
var second;
var third;
var fourth;

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  void fetchUserData() async {
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('Puntajes')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    if (documentSnapshot.exists) {
      Map<String, dynamic>? data =
          documentSnapshot.data() as Map<String, dynamic>?;

      if (data != null) {
        setState(() {
          first = data['primero'];
          second = data['segundo'];
          third = data['tercero'];
          fourth = data['cuarto'];
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
    return Scaffold(
      body: Center(
        child: Text(
          "First Quiz: ${first.toString()}\n"
          "Second Quiz: ${second.toString()}\n"
          "Third Quiz: ${third.toString()}\n"
          "Fourth Quiz: ${fourth.toString()}",
        ),
      ),
    );
  }
}
