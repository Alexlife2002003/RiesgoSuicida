import 'package:flutter/material.dart';
import 'package:riesgo_suicida/Screens/temp.dart';
import 'package:riesgo_suicida/Screens/temp.dart' as globals;
import 'package:riesgo_suicida/util/CardFirst.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

var suma = 0;

class FirstQuiz extends StatefulWidget {
  const FirstQuiz({super.key});

  @override
  State<FirstQuiz> createState() => _FirstQuizState();
}

class _FirstQuizState extends State<FirstQuiz> {
  @override
  Widget build(BuildContext context) {
    suma = 0;
    Color darkblue = const Color.fromARGB(255, 0, 0, 139);
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
                      updateUserData(suma);
                      globals.firstIcon = Icons.check_box;//corregir
                      globals.currentPage = globals.DrawerSections.dashboard;
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Temp()),
                      );
                    },
                    
                    child: const Text('Finalizar'),
                  ),
                ),
                CardsFirst(
                    text:
                        "No merece la pena que intente conseguir algo que desee, porque probablemente no lo lograré",
                    color: Colors.white,
                    colorText: Colors.black,
                    valueL: 0,
                    valueR: 1), //20
                CardsFirst(
                    text: "Espero más bien épocas buenas que malas",
                    color: darkblue,
                    colorText: Colors.white,
                    valueL: 1,
                    valueR: 0), //19
                CardsFirst(
                    text: "El futuro me parece vago e incierto",
                    color: Colors.white,
                    colorText: Colors.black,
                    valueL: 0,
                    valueR: 1), //18
                CardsFirst(
                    text:
                        "Es muy improbable que pueda lograr una satisfacción real en el futuro",
                    color: darkblue,
                    colorText: Colors.white,
                    valueL: 0,
                    valueR: 1), //17
                CardsFirst(
                    text:
                        "Nunca consigo lo que deseo, por lo que es absurdo desear cualquier cosa",
                    color: Colors.white,
                    colorText: Colors.black,
                    valueL: 0,
                    valueR: 1), //16
                CardsFirst(
                    text: "Tengo una gran confianza en el futuro",
                    color: darkblue,
                    colorText: Colors.white,
                    valueL: 1,
                    valueR: 0), //15
                CardsFirst(
                    text: "Las cosas no marchan como yo quisiera",
                    color: Colors.white,
                    colorText: Colors.black,
                    valueL: 0,
                    valueR: 1), //14
                CardsFirst(
                    text:
                        "Cuando miro hacia el futuro, espero que seré más feliz de lo que soy ahora",
                    color: darkblue,
                    colorText: Colors.white,
                    valueL: 1,
                    valueR: 0), //13
                CardsFirst(
                    text: "No espero conseguir lo que realmente deseo",
                    color: Colors.white,
                    colorText: Colors.black,
                    valueL: 0,
                    valueR: 1), //12
                CardsFirst(
                    text:
                        "Todo lo que puedo ver por delante de mí es más desagradable que agradable",
                    color: darkblue,
                    colorText: Colors.white,
                    valueL: 0,
                    valueR: 1), //11
                CardsFirst(
                    text:
                        "Mis pasadas experiencias me han preparado bien para el futuro",
                    color: Colors.white,
                    colorText: Colors.black,
                    valueL: 1,
                    valueR: 0), //10
                CardsFirst(
                    text:
                        "No logro hacer que las cosas cambien, y no existen razones para creer que pueda en el futuro",
                    color: darkblue,
                    colorText: Colors.white,
                    valueL: 0,
                    valueR: 1), //9
                CardsFirst(
                    text:
                        "Espero más cosas buenas de la vida que lo que la gente suele conseguir por término medio",
                    color: Colors.white,
                    colorText: Colors.black,
                    valueL: 1,
                    valueR: 0), //8
                CardsFirst(
                    text: "Mi futuro me parece oscuro",
                    color: darkblue,
                    colorText: Colors.white,
                    valueL: 0,
                    valueR: 1), //7
                CardsFirst(
                    text:
                        "En el futuro, espero conseguir lo que me pueda interesar",
                    color: Colors.white,
                    colorText: Colors.black,
                    valueL: 1,
                    valueR: 0), //6
                CardsFirst(
                    text:
                        "Tengo bastante tiempo para llevar a cabo las cosas que quisiera poder hacer",
                    color: darkblue,
                    colorText: Colors.white,
                    valueL: 1,
                    valueR: 0), //5
                CardsFirst(
                    text:
                        "No puedo imaginar cómo será mi vida dentro de 10 años",
                    color: Colors.white,
                    colorText: Colors.black,
                    valueL: 0,
                    valueR: 1), //4
                CardsFirst(
                    text:
                        "Cuando las cosas van mal me alivia saber que las cosas no pueden permanecer tiempo así",
                    color: darkblue,
                    colorText: Colors.white,
                    valueL: 1,
                    valueR: 0), //3
                CardsFirst(
                    text:
                        "Puedo darme por vencido, renunciar, ya que no puedo hacer las cosas por mi mismo",
                    color: Colors.white,
                    colorText: Colors.black,
                    valueL: 0,
                    valueR: 1), //2
                CardsFirst(
                    text: "Espero el futuro con esperanza y entusiasmo",
                    color: darkblue,
                    colorText: Colors.white,
                    valueL: 1,
                    valueR: 0), //1
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
        'primero':
            newValue, // Provide the updated value for the 'primero' field
      });
    } catch (error) {
      print('Error updating user data: $error');
    }
  }
}
