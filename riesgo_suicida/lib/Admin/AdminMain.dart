import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riesgo_suicida/Admin/Screens.dart/Temporal.dart';

class AdminMain extends StatefulWidget {
  const AdminMain({Key? key}) : super(key: key);

  @override
  State<AdminMain> createState() => _AdminMainState();
}

class _AdminMainState extends State<AdminMain> {
  Future<List<Map<String, dynamic>>> fetchUsers() async {
    List<Map<String, dynamic>> users = [];

    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .get();

      for (QueryDocumentSnapshot document in querySnapshot.docs) {
        String userName = document['firstname']+" "+ document['lastname'];
        String uid = document.id; // Get the UID of the user document
        users.add({'name': userName, 'uid': uid});
      }
    } catch (e) {
      print('Error fetching users: $e');
    }

    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Main'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<Map<String, dynamic>> users = snapshot.data ?? [];

            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return GestureDetector(
                  onTap: () {
                    // Navigate to Temporal page with the user's UID
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>  Temporal(uid: user['uid'], fullname: user['name']),
                      ),
                    );
                  },
                  child: ListTile(
                    title: Text(user['name']),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
