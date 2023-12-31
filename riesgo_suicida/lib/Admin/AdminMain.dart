import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riesgo_suicida/Admin/Screens/AppDrawerAdmin.dart';
import 'package:riesgo_suicida/Admin/Screens/Temporal.dart';

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
          .orderBy('timestamp', descending: true)
          .get();

      for (QueryDocumentSnapshot document in querySnapshot.docs) {
        // Check if 'admin' is true before adding the user
        bool isAdmin = document['admin'] ??
            false; // Default to false if 'admin' field doesn't exist
        if (!isAdmin) {
          String userName = document['firstname'] + " " + document['lastname'];
          String uid = document.id; // Get the UID of the user document
          users.add({'name': userName, 'uid': uid});
        }
      }
    } catch (e) {
      print('Error fetching users: $e');
    }

    return users;
  }

  @override
  Widget build(BuildContext context) {
    return AppDrawerMain(
      appbarText: "Registro de evaluaciones",
      currentPage: "AdminMain",
      content: Scaffold(
        backgroundColor: const Color.fromRGBO(229, 251, 255, 1),
        body: FutureBuilder<List<Map<String, dynamic>>>(
          future: fetchUsers(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
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
                          builder: (context) => Temporal(
                              uid: user['uid'], fullname: user['name']),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.grey,
                                spreadRadius: 4,
                                blurRadius: 8,
                                offset: Offset(0, 3))
                          ]),
                      child: ListTile(
                        title: Center(
                            child: Text(
                          user['name'],
                          style: const TextStyle(fontSize: 18),
                        )),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
