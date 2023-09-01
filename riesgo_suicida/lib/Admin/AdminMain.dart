import 'package:flutter/material.dart';

class AdminMain extends StatefulWidget {
  const AdminMain({super.key});

  @override
  State<AdminMain> createState() => _AdminMainState();
}

class _AdminMainState extends State<AdminMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Pages'),
        centerTitle: true,
      ),
      body: Center(child: Text('This is the admin area')),
    );
  }
}
