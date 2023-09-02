import 'package:flutter/material.dart';
import 'package:riesgo_suicida/Admin/Answers/APGAR.dart';
import 'package:riesgo_suicida/Admin/Answers/Desesperanza.dart';
import 'package:riesgo_suicida/Admin/Answers/Ideacion.dart';
import 'package:riesgo_suicida/Admin/Answers/Plutchik.dart';

class Temporal extends StatelessWidget {
  final String uid;
  final String fullname;

  Temporal(
    {required this.uid,
    required this.fullname}
    );

  @override
  Widget build(BuildContext context) {
    Color appbarColor = Color.fromRGBO(185, 236, 245, 1);
    Color backgroundColor =Color.fromRGBO(229, 251, 255, 1);
    Color btnColor = const Color.fromARGB(255, 74, 101, 211);
    return Scaffold(
      appBar: AppBar(
        title: Text('$fullname',style: TextStyle(color: Colors.black),),
        backgroundColor: appbarColor,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      backgroundColor: backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('UID: $uid'),
            SizedBox(height: 20,),
            SizedBox(
              height: 60,
              width: 280,
              child: ElevatedButton( 
                style: ElevatedButton.styleFrom(
                  backgroundColor: btnColor,
                  padding: EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  )
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Desesperanza(uid:uid))
                  );
                },
                child: Text('Escala de Desesperanza de Beck'),
              ),
            ),
            SizedBox(height: 10,),
            SizedBox(
              height: 60,
              width: 280,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: btnColor,
                  padding: EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  )
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Ideacion(uid: uid))
                  );
                },
                child: Text('Escala de Ideacion Suicida'),
              ),
            ),
            SizedBox(height: 10,),
            SizedBox(
              height: 60,
              width: 280,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: btnColor,
                  padding: EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  )
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context )=>Plutchik(uid: uid))
                      );  
                },
                child: Text('Escala de Riesgo Suicida de Plutchik'),
              ),
            ),
            SizedBox(height: 10,),
            SizedBox(
              height: 60,
              width: 280,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: btnColor,
                  padding: EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  )
                ),
                onPressed: () {
                  Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>  APGAR(uid:uid),
                        ),
                      );
                },
                child: Text('APGAR Familiar'),
              ),
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