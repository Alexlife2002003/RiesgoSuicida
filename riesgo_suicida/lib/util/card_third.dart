import 'package:flutter/material.dart';
import 'package:flutter_swipable/flutter_swipable.dart';
import 'package:riesgo_suicida/Screens/third_quiz.dart' as globals;

class CardsThird extends StatelessWidget {
  final color;
  final text;
  final colorText;
  var valueL = 0;
  var valueR = 0;

  CardsThird(
      {required this.text,
      this.color,
      this.colorText,
      required this.valueL,
      required this.valueR});

  @override
  Widget build(BuildContext context) {
    return Swipable(
      onSwipeRight: (finalPosition) {
        //what to do
        globals.suma = globals.suma + valueR;
      },
      onSwipeLeft: (finalPosition) {
        globals.suma = globals.suma + valueL;
      },
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: color ?? Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 2), // changes the shadow position
                ),
              ],
            border: Border.all(
              width: 0,
              color: Colors.black,
            ),
          ),
          height: 200,
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: TextStyle(fontSize: 20, color: colorText),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
