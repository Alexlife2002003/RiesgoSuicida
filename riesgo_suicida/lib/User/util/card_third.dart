import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipable/flutter_swipable.dart';
import 'package:riesgo_suicida/User/Screens/third_quiz.dart' as globals;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CardsThird extends StatefulWidget {
  final id;
  final color;
  final text;
  final colorText;
  var valueL = 0;
  var valueR = 0;
  final VoidCallback? onSwiped;

  CardsThird({
    required this.id,
    required this.text,
    this.color,
    this.colorText,
    required this.valueL,
    required this.valueR,
    required this.onSwiped,
  });

  @override
  _CardsThirdState createState() => _CardsThirdState();
}

class _CardsThirdState extends State<CardsThird> {
  double cardPositionY = 0.0;
  final CollectionReference userAnswersCollection =
      FirebaseFirestore.instance.collection('PlutchikAnswers');

  Future<void> _registerAnswer(int question, bool answer) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;

    await userAnswersCollection
        .doc(userId)
        .collection('Answers')
        .doc(question.toString())
        .set({'questionIndex': question, 'answer': answer});
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onVerticalDragUpdate: (details) {
          setState(() {
            cardPositionY = details.localPosition.dy;
          });
        },
        onVerticalDragEnd: (details) {
          setState(() {
            cardPositionY = 0.0;
          });
        },
        child: Transform.translate(
          offset: Offset(0.0, cardPositionY),
          child: Swipable(
            onSwipeRight: (finalPosition) {
              _registerAnswer(widget.id, true);
              globals.suma += widget.valueR;
              print('Suma after right swipe: ${globals.suma}');
              print('----------------------------------------');
              widget.onSwiped?.call();
            },
            onSwipeLeft: (finalPosition) {
              _registerAnswer(widget.id, false);
              globals.suma += widget.valueL;
              print('Suma after left swipe: ${globals.suma}');
              print('----------------------------------------');
              widget.onSwiped?.call();
            },
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: widget.color ?? Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 2), // changes the shadow position
                    ),
                  ],
                ),
                height: 200,
                width: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.text,
                      style: TextStyle(
                          fontSize: 20,
                          color: widget.colorText ?? Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
