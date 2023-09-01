import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riesgo_suicida/Admin/AdminMain.dart';
import 'package:riesgo_suicida/User/Screens/first_quiz.dart';
import 'package:riesgo_suicida/User/Screens/temp.dart';
import 'package:riesgo_suicida/login/LoginOrRegisterPage.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isAdmin = false;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      if (documentSnapshot.exists) {
        Map<String, dynamic>? userData =
            documentSnapshot.data() as Map<String, dynamic>;
        setState(() {
          isAdmin = userData['admin'];
        });
        print('user data isadmin $isAdmin');
      } else {
        // User document does not exist
        setState(() {
          isAdmin = false;
        });
      }
    } catch (e) {
      print('Error fetching user data: $e');
      setState(() {
        isAdmin = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (isAdmin == false) {
              return const Temp();
            } else {
              return const AdminMain();
            }
          } else {
            return const LoginOrRegisterPage();
          }
        },
      ),
    );
  }
}
