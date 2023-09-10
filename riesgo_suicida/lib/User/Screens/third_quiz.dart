import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:riesgo_suicida/User/Screens/temp.dart';
import 'package:riesgo_suicida/User/util/card_third.dart';
import 'package:riesgo_suicida/User/Screens/temp.dart' as globals;

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
    Color appbarColor = const Color.fromRGBO(185, 236, 245, 1);
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color.fromRGBO(229, 251, 255, 1),
              Color.fromRGBO(229, 251, 255, 1),
            ]),
      ),
      child: Scaffold(
          appBar: AppBar(
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(Icons.menu),
                  color: Colors.black,
                  onPressed: () {},
                );
              },
            ),
            title: const Text(
              'Cuestionario 3',
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
                    'Pregunta ${cardCount + 1} /15',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
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
                const Positioned(
                  left: 50,
                  top: 125,
                  child: Text(
                    'No',
                    style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                  ),
                ),
                const Positioned(
                  right: 50,
                  top: 125,
                  child: Text(
                    'Si',
                    style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                  ),
                ),
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
                    id: 15,
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
                    id: 14,
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
                    id: 13,
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
                    id: 12,
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
                    id: 11,
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
                    id: 10,
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
                    id: 9,
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
                    id: 8,
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
                    id: 7,
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
                    id: 6,
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
                    id: 5,
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
                    id: 4,
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
                    id: 3,
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
                    id: 2,
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
                    id: 1,
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
