import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyHeaderDrawer extends StatefulWidget {
  const MyHeaderDrawer({Key? key});

  @override
  State<MyHeaderDrawer> createState() => _MyHeaderDrawerState();
}

class _MyHeaderDrawerState extends State<MyHeaderDrawer> {
  final user = FirebaseAuth.instance.currentUser!;
  Color themeColor = const Color.fromRGBO(3, 38, 173, 1.0);

  @override
  Widget build(BuildContext context) {
    String displayName = user.displayName ?? '';
// Split the display name by whitespace
    List<String> nameParts = displayName.split(' ');

// Get the first name (if available)
    String firstName = nameParts.isNotEmpty ? nameParts.first : '';
    return AppBar(
      backgroundColor: themeColor,
      automaticallyImplyLeading: false,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Bienvenido, ",
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
          Text(
            firstName,
            style: TextStyle(color: Colors.grey[200], fontSize: 22),
          ),
        ],
      ),
    );
  }
}
