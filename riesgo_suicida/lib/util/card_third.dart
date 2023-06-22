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
            color: color,
            borderRadius: BorderRadius.circular(50),
            border: Border.all(
              width: 0,
              color: Colors.black,
            ),
          ),
          height: 600,
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: TextStyle(fontSize: 30, color: colorText),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
