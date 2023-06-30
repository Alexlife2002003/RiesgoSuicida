import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;
final CollectionReference usersCollection = firestore.collection('Puntajes');
//var firstquiz;
//var secondquiz;
//var thirdquiz;
//var fourthquiz;
var first;
var second;
var third;
var fourth;
var percentage=0.0;
var percentageText='0%';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  void setPercentage(){
    var temp=0.0;
    var temptext='';
    if (first>0){
        temp+=.25;
    }
    if (second>0){
        temp+=.25;
    }
    if (third>0){
        temp+=.25;
    }
    if (fourth>0){
        temp+=.25;
    }
    if(temp>0){
    temptext=(temp*100).toString();
    }
    setState(() {
        percentage=temp;
        percentageText="$temptext%";
      });

  }

  void fetchUserData() async {
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('Puntajes')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    if (documentSnapshot.exists) {
      Map<String, dynamic>? data =
          documentSnapshot.data() as Map<String, dynamic>?;

      if (data != null) {
        setState(() {
          first = data['primero'];
          second = data['segundo'];
          third = data['tercero'];
          fourth = data['cuarto'];
        });
      } else {
        print('"primero" field does not exist in the document');
      }
    } else {
      print('Document does not exist in the database');
    }
    setPercentage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 40,),
            CircularPercentIndicator(
              animation: true,
              radius:300,
              lineWidth:30,
              percent: percentage,
              progressColor: Colors.blue,
              backgroundColor:Colors.blue.shade100,
              circularStrokeCap: CircularStrokeCap.round,
              center: Text(percentageText,style:const TextStyle(fontSize: 50))

            ),
            const SizedBox(height: 20),
            Text(
              "First Quiz: ${first.toString()}\n"
              "Second Quiz: ${second.toString()}\n"
              "Third Quiz: ${third.toString()}\n"
              "Fourth Quiz: ${fourth.toString()}",
            ),
          ],
        ),
      ),
    );
  }
}
