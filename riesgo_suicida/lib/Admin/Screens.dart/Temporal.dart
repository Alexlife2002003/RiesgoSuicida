import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:riesgo_suicida/Admin/Answers/APGAR.dart';
import 'package:riesgo_suicida/Admin/Answers/Desesperanza.dart';
import 'package:riesgo_suicida/Admin/Answers/Ideacion.dart';
import 'package:riesgo_suicida/Admin/Answers/Plutchik.dart';
import 'package:riesgo_suicida/Answers/APGAR_answers.dart';

var edad="";
var genero="";

class Temporal extends StatefulWidget {
  final String uid;
  final String fullname;


  Temporal(
    {required this.uid,
    required this.fullname}
    );

  @override
  State<Temporal> createState() => _TemporalState();
}

class _TemporalState extends State<Temporal> {
  void fetchUserData() async {
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection("Users")
        .doc(widget.uid)
        .get();

    if (documentSnapshot.exists) {
      Map<String, dynamic>? data =
          documentSnapshot.data() as Map<String, dynamic>?;

      if (data != null) {
        setState(() {
          edad = data['edad'];
          genero=data['genero'];
          
        
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
    fetchUserData();
    Color appbarColor = Color.fromRGBO(185, 236, 245, 1);
    Color backgroundColor =Color.fromRGBO(229, 251, 255, 1);
    Color btnColor = const Color.fromARGB(255, 74, 101, 211);
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.fullname}',style: TextStyle(color: Colors.black),),
        backgroundColor: appbarColor,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      backgroundColor: backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 240,
              width: 320,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      spreadRadius: 2,
                      blurRadius: 2
                    )
                  ],
                  
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10,),
                    Text(' Nombre Completo:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    SizedBox(height: 5,),
                    Text('  ${widget.fullname}'),
                    SizedBox(height: 10,),
                    Text(' Edad:',style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold)),
                    SizedBox(height: 5,),
                    Text('  $edad'),
                    Text(' Programa Academico:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    SizedBox(height: 5,),
                    Text('  Ingenieria de Software'),
                    Text(' Genero:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    Text('  $genero'),
                    Text(' Correo Electronico:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    Text('  20200992@uaz.edu.mx'),
                  ],
                )),
            ),
            SizedBox(height: 50,),
            Text('UID: ${widget.uid}'),
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
                      builder: (context) => Desesperanza(uid:widget.uid))
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
                      builder: (context) => Ideacion(uid: widget.uid))
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
                      builder: (context )=>Plutchik(uid: widget.uid))
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
                          builder: (context) =>  APGARAnswersPage(uid:widget.uid),
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
        builder: (context) => Temporal(uid: uid,fullname:widget.fullname),
      ),
    );
  }
}