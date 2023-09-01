import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyHeaderDrawer extends StatefulWidget {
  const MyHeaderDrawer({super.key});

  @override
  State<MyHeaderDrawer> createState() => _MyHeaderDrawerState();
}

class _MyHeaderDrawerState extends State<MyHeaderDrawer> {
  final user = FirebaseAuth.instance.currentUser!;
  Color themeColor = const Color.fromRGBO(3, 38, 173, 1.0);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: themeColor,
      width: double.infinity,
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 8),
            height: 100,
            // ignore: prefer_const_constructors
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              // image: DecorationImage(image: ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Welcome,",
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              Text(
                user.displayName.toString(),
                style: TextStyle(color: Colors.grey[200], fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
