import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:riesgo_suicida/Screens/temp.dart';
import 'package:riesgo_suicida/util/card_third.dart';
import 'package:riesgo_suicida/Screens/temp.dart' as globals;

var suma = 0;

class ThirdQuiz extends StatefulWidget {
  const ThirdQuiz({super.key});

  @override
  State<ThirdQuiz> createState() => _ThirdQuizState();
}

class _ThirdQuizState extends State<ThirdQuiz> {
  int cardCount = 0;

  @override
  void initState() {
    super.initState();
    suma = 0;
  }

  @override
  Widget build(BuildContext context) {
    Color darkblue = const Color.fromARGB(255, 0, 0, 139);
    Color appbarColor = Color.fromRGBO(185, 236, 245, 1);
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color.fromARGB(255, 244, 47, 33),
              Color.fromARGB(255, 241, 94, 84),
              Color.fromARGB(255, 83, 65, 65),
              Color.fromARGB(255, 8, 214, 111),
              Color.fromARGB(255, 3, 123, 63)
            ]),
      ),
      child: Scaffold(
          appBar: AppBar(
            
            leading: Builder(
              builder: (BuildContext context){
                return IconButton(icon:Icon(Icons.menu),color:Colors.black,onPressed: (){
                  
                },);
              },
            ),
            title: Text(
              'Escala de Riesgo Suicida',
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: appbarColor,
            elevation: 1,
            centerTitle: true,
          ),
          bottomNavigationBar: BottomAppBar(
            color: Colors.transparent,
            elevation: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'Question ${cardCount + 1} /15',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: LinearProgressBar(
                    maxSteps: 14,
                    progressType: LinearProgressBar.progressTypeLinear,
                    currentStep: cardCount,
                    progressColor: darkblue,
                    backgroundColor: Colors.grey,
                  ),
                )
              ],
            ),
          ),
          backgroundColor: Colors.transparent,
          body: Center(
            child: Stack(
              children: [
                Center(
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(appbarColor),
                    ),
                    onPressed: () {
                      globals.thirdIcon = Icons.check_box;
                      globals.currentPage = globals.DrawerSections.dashboard;
                      updateUserData(suma);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Temp()),
                      );
                    },
                    child: const Text(
                      'Finalizar',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                CardsThird(
                    text: "¿Ha intentado alguna vez quitarse la vida?",
                    color: darkblue,
                    colorText: Colors.white,
                    valueL: 0,
                    valueR: 2,
                    onSwiped: () {
                      setState(() {
                        cardCount = cardCount;
                      });
                    }),
                CardsThird(
                    text:
                        "¿Le ha comentado a alguien, en alguna ocasión, que quería suicidarse?",
                    color: Colors.white,
                    colorText: Colors.black,
                    valueL: 0,
                    valueR: 2,
                    onSwiped: () {
                      setState(() {
                        cardCount++;
                      });
                    }),
                CardsThird(
                    text: "¿Ha pensado alguna vez en suicidarse?",
                    color: darkblue,
                    colorText: Colors.white,
                    valueL: 0,
                    valueR: 2,
                    onSwiped: () {
                      setState(() {
                        cardCount++;
                      });
                    }),
                CardsThird(
                    text:
                        "¿Alguna vez se ha sentido tan enfadado/a que habría sido capaz de matar a alguien?",
                    color: Colors.white,
                    colorText: Colors.black,
                    valueL: 0,
                    valueR: 2,
                    onSwiped: () {
                      setState(() {
                        cardCount++;
                      });
                    }),
                CardsThird(
                    text:
                        "¿Sabe si alguien de su familia ha intentado suicidarse alguna vez?",
                    color: darkblue,
                    colorText: Colors.white,
                    valueL: 0,
                    valueR: 2,
                    onSwiped: () {
                      setState(() {
                        cardCount++;
                      });
                    }),
                CardsThird(
                    text:
                        "¿Está usted separado/a, divorciado/a o viudo/a o ha terminado recientemente una relación sentimental importante?",
                    color: Colors.white,
                    colorText: Colors.black,
                    valueL: 0,
                    valueR: 2,
                    onSwiped: () {
                      setState(() {
                        cardCount++;
                      });
                    }),
                CardsThird(
                    text: "¿Está deprimido/a ahora?",
                    color: darkblue,
                    colorText: Colors.white,
                    valueL: 0,
                    valueR: 2,
                    onSwiped: () {
                      setState(() {
                        cardCount++;
                      });
                    }),
                CardsThird(
                    text:
                        "¿Se ha sentido alguna vez tan fracasado/a que sólo quería meterse en la cama y abandonarlo todo?",
                    color: Colors.white,
                    colorText: Colors.black,
                    valueL: 0,
                    valueR: 2,
                    onSwiped: () {
                      setState(() {
                        cardCount++;
                      });
                    }),
                CardsThird(
                    text: "¿Ve su futuro sin ninguna esperanza?",
                    color: darkblue,
                    colorText: Colors.white,
                    valueL: 0,
                    valueR: 2,
                    onSwiped: () {
                      setState(() {
                        cardCount++;
                      });
                    }),
                CardsThird(
                    text: "¿Se ha sentido alguna vez inútil o inservible?",
                    color: Colors.white,
                    colorText: Colors.black,
                    valueL: 0,
                    valueR: 2,
                    onSwiped: () {
                      setState(() {
                        cardCount++;
                      });
                    }),
                CardsThird(
                    text: "¿Ve su futuro con más pesimismo que optimismo?",
                    color: darkblue,
                    colorText: Colors.white,
                    valueL: 0,
                    valueR: 2,
                    onSwiped: () {
                      setState(() {
                        cardCount++;
                      });
                    }),
                CardsThird(
                    text: "¿Tiene poco interés en relacionarse con la gente?",
                    color: Colors.white,
                    colorText: Colors.black,
                    valueL: 0,
                    valueR: 2,
                    onSwiped: () {
                      setState(() {
                        cardCount++;
                      });
                    }),
                CardsThird(
                    text:
                        "¿A veces nota que podría perder el control sobre sí mismo/a?",
                    color: darkblue,
                    colorText: Colors.white,
                    valueL: 0,
                    valueR: 2,
                    onSwiped: () {
                      setState(() {
                        cardCount++;
                      });
                    }),
                CardsThird(
                    text: "¿Tiene dificultades para conciliar el sueño?",
                    color: Colors.white,
                    colorText: Colors.black,
                    valueL: 0,
                    valueR: 2,
                    onSwiped: () {
                      setState(() {
                        cardCount++;
                      });
                    }),
                CardsThird(
                    text:
                        "¿Toma de forma habitual algún medicamento como aspirinas o pastillar para dormir?",
                    color: darkblue,
                    colorText: Colors.white,
                    valueL: 0,
                    valueR: 2,
                    onSwiped: () {
                      setState(() {
                        cardCount++;
                      });
                    }),
              ],
            ),
          )),
    );
  }

  void updateUserData(int newValue) async {
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance
          .collection('Puntajes')
          .doc(userId)
          .update({
        'tercero': newValue,
      });
    } catch (error) {
      print('Error updating user data: $error');
    }
  }
}
