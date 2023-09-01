import 'package:flutter/material.dart';

class Temporal extends StatelessWidget {
  final String uid;
  final String fullname;

  Temporal(
    {required this.uid,
    required this.fullname}
    );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$fullname'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('UID: $uid'),
            ElevatedButton(
              onPressed: () {
                navigateToTemporal(context, uid);
              },
              child: Text('Button 1'),
            ),
            ElevatedButton(
              onPressed: () {
                navigateToTemporal(context, uid);
              },
              child: Text('Button 2'),
            ),
            ElevatedButton(
              onPressed: () {
                navigateToTemporal(context, uid);
              },
              child: Text('Button 3'),
            ),
            ElevatedButton(
              onPressed: () {
                navigateToTemporal(context, uid);
              },
              child: Text('Button 4'),
            ),
          ],
        ),
      ),
    );
  }

  void navigateToTemporal(BuildContext context, String uid) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Temporal(uid: uid,fullname:fullname),
      ),
    );
  }
}