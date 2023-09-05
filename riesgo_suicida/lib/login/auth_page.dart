import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riesgo_suicida/Admin/Screens/AdminMenu.dart';
import 'package:riesgo_suicida/User/Screens/temp.dart';
import 'package:riesgo_suicida/login/LoginOrRegisterPage.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection('Users')
                  .doc(snapshot.data!.uid)
                  .get(),
              builder: (context, userSnapshot) {
                if (userSnapshot.hasData && userSnapshot.data != null) {
                  // Check if the user is an admin based on the "admin" variable
                  bool isAdmin = userSnapshot.data!.get('admin') ?? false;
                  print('is Admin $isAdmin');
                  if (isAdmin) {
                    // User is an admin, navigate to the admin page (Temp)
                    return const AdminMenu();
                  } else {
                    // User is not an admin, navigate to the login or register page
                    return const Temp();
                  }
                } else {
                  // Unable to fetch user data, you can handle this case as needed
                  return const LoginOrRegisterPage();
                }
              },
            );
          } else {
            // User is not authenticated, navigate to the login or register page
            return const LoginOrRegisterPage();
          }
        },
      ),
    );
  }
}
