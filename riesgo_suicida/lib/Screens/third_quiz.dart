import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    suma = 0;
    Color darkblue= const Color.fromARGB(255, 0, 0, 139);
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
          backgroundColor: Colors.transparent,
          body: Center(
            child: Stack(
              children: [
            Center(
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(3, 38, 173, 1.0)),
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
                child: const Text('Finalizar'),
              ),
            ),
            CardsThird(
              text: "¿Ha intentado alguna vez quitarse la vida?",
              color: darkblue,
              colorText: Colors.white,
              valueL: 0,
              valueR: 1,
            ),
            CardsThird(
              text:
                  "¿Le ha comentado a alguien, en alguna ocasión, que quería suicidarse?",
              color: Colors.white,
              colorText: Colors.black,
              valueL: 0,
              valueR: 1,
            ),
            CardsThird(
              text: "¿Ha pensado alguna vez en suicidarse?",
              color: darkblue,
              colorText: Colors.white,
              valueL: 0,
              valueR: 1,
            ),
            CardsThird(
              text:
                  "¿Alguna vez se ha sentido tan enfadado/a que habría sido capaz de matar a alguien?",
              color: Colors.white,
              colorText: Colors.black,
              valueL: 0,
              valueR: 1,
            ),
            CardsThird(
              text:
                  "¿Sabe si alguien de su familia ha intentado suicidarse alguna vez?",
              color: darkblue,
              colorText: Colors.white,
              valueL: 0,
              valueR: 1,
            ),
            CardsThird(
              text:
                  "¿Está usted separado/a, divorciado/a o viudo/a o ha terminado recientemente una relación sentimental importante?",
              color: Colors.white,
              colorText: Colors.black,
              valueL: 0,
              valueR: 1,
            ),
            CardsThird(
              text: "¿Está deprimido/a ahora?",
              color: darkblue,
              colorText: Colors.white,
              valueL: 0,
              valueR: 1,
            ),
            CardsThird(
              text:
                  "¿Se ha sentido alguna vez tan fracasado/a que sólo quería meterse en la cama y abandonarlo todo?",
              color: Colors.white,
              colorText: Colors.black,
              valueL: 0,
              valueR: 1,
            ),
            CardsThird(
              text: "¿Ve su futuro sin ninguna esperanza?",
              color: darkblue,
              colorText: Colors.white,
              valueL: 0,
              valueR: 1,
            ),
            CardsThird(
              text: "¿Se ha sentido alguna vez inútil o inservible?",
              color: Colors.white,
              colorText: Colors.black,
              valueL: 0,
              valueR: 1,
            ),
            CardsThird(
              text: "¿Ve su futuro con más pesimismo que optimismo?",
              color: darkblue,
              colorText: Colors.white,
              valueL: 0,
              valueR: 1,
            ),
            CardsThird(
              text: "¿Tiene poco interés en relacionarse con la gente?",
              color: Colors.white,
              colorText: Colors.black,
              valueL: 0,
              valueR: 1,
            ),
            CardsThird(
              text:
                  "¿A veces nota que podría perder el control sobre sí mismo/a?",
              color: darkblue,
              colorText: Colors.white,
              valueL: 0,
              valueR: 1,
            ),
            CardsThird(
              text: "¿Tiene dificultades para conciliar el sueño?",
              color: Colors.white,
              colorText: Colors.black,
              valueL: 0,
              valueR: 1,
            ),
            CardsThird(
              text:
                  "¿Toma de forma habitual algún medicamento como aspirinas o pastillar para dormir?",
              color: darkblue,
              colorText: Colors.white,
              valueL: 0,
              valueR: 1,
            ),
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
