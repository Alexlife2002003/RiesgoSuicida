import 'package:flutter/material.dart';
import 'package:riesgo_suicida/User/Screens/temp.dart';
import 'package:riesgo_suicida/User/Screens/temp.dart' as globals;
import 'package:riesgo_suicida/User/util/CardFirst.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';

var suma = 0;

class FirstQuiz extends StatefulWidget {
  const FirstQuiz({super.key});

  @override
  State<FirstQuiz> createState() => _FirstQuizState();
}

class _FirstQuizState extends State<FirstQuiz> {
  int cardCount = 0;

  @override
  @override
  void initState() {
    super.initState();
    suma = 0;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Schedule the dialog with a delay to avoid calling it during build
    Future.delayed(Duration.zero, () {
      showPlatformDialog(
        context: context,
        builder: (_) => Dialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 10,
              ),
              const Center(
                child: Text(
                  "Instrucciones",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10), // Adjust as needed for spacing
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.asset(
                  'lib/assets/GIFS/suicida.gif', // Replace with your GIF asset path
                  // Adjust the height as needed
                ),
              ),
              const SizedBox(height: 10), // Adjust as needed for spacing
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  BasicDialogAction(
                    title: const Text("OK"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
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
        bottomNavigationBar: BottomAppBar(
          color: const Color.fromARGB(0, 0, 0, 0),
          elevation: 0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Pregunta ${cardCount + 1}/20',
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
                  maxSteps: 19,
                  progressType: LinearProgressBar.progressTypeLinear,
                  currentStep: cardCount,
                  progressColor: darkblue,
                  backgroundColor: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.transparent,
        body: Center(
          child: Stack(
            children: [
              const Positioned(
                left: 50,
                bottom: 125,
                child: Text(
                  'No',
                  style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                ),
              ),
              const Positioned(
                right: 50,
                bottom: 125,
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
                    updateUserData(suma);
                    globals.firstIcon = Icons.check_box; //corregir
                    globals.currentPage = globals.DrawerSections.dashboard;
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

              CardsFirst(
                  id: 20,
                  text:
                      "No merece la pena que intente conseguir algo que desee, porque probablemente no lo lograré",
                  color: Colors.white,
                  colorText: Colors.black,
                  valueL: 0,
                  valueR: 1,
                  onSwiped: () {
                    setState(() {
                      cardCount = cardCount;
                    });
                  }), //20
              CardsFirst(
                  id: 19,
                  text: "Espero más bien épocas buenas que malas",
                  color: darkblue,
                  colorText: Colors.white,
                  valueL: 1,
                  valueR: 0,
                  onSwiped: () {
                    setState(() {
                      cardCount++;
                    });
                  }), //19

              CardsFirst(
                  id: 18,
                  text: "El futuro me parece vago e incierto",
                  color: Colors.white,
                  colorText: Colors.black,
                  valueL: 0,
                  valueR: 1,
                  onSwiped: () {
                    setState(() {
                      cardCount++;
                    });
                  }), //18
              CardsFirst(
                  id: 17,
                  text:
                      "Es muy improbable que pueda lograr una satisfacción real en el futuro",
                  color: darkblue,
                  colorText: Colors.white,
                  valueL: 0,
                  valueR: 1,
                  onSwiped: () {
                    setState(() {
                      cardCount++;
                    });
                  }), //17
              CardsFirst(
                  id: 16,
                  text:
                      "Nunca consigo lo que deseo, por lo que es absurdo desear cualquier cosa",
                  color: Colors.white,
                  colorText: Colors.black,
                  valueL: 0,
                  valueR: 1,
                  onSwiped: () {
                    setState(() {
                      cardCount++;
                    });
                  }), //16
              CardsFirst(
                  id: 15,
                  text: "Tengo una gran confianza en el futuro",
                  color: darkblue,
                  colorText: Colors.white,
                  valueL: 1,
                  valueR: 0,
                  onSwiped: () {
                    setState(() {
                      cardCount++;
                    });
                  }), //15
              CardsFirst(
                  id: 14,
                  text: "Las cosas no marchan como yo quisiera",
                  color: Colors.white,
                  colorText: Colors.black,
                  valueL: 0,
                  valueR: 1,
                  onSwiped: () {
                    setState(() {
                      cardCount++;
                    });
                  }), //14
              CardsFirst(
                  id: 13,
                  text:
                      "Cuando miro hacia el futuro, espero que seré más feliz de lo que soy ahora",
                  color: darkblue,
                  colorText: Colors.white,
                  valueL: 1,
                  valueR: 0,
                  onSwiped: () {
                    setState(() {
                      cardCount++;
                    });
                  }), //13
              CardsFirst(
                  id: 12,
                  text: "No espero conseguir lo que realmente deseo",
                  color: Colors.white,
                  colorText: Colors.black,
                  valueL: 0,
                  valueR: 1,
                  onSwiped: () {
                    setState(() {
                      cardCount++;
                    });
                  }), //12
              CardsFirst(
                  id: 11,
                  text:
                      "Todo lo que puedo ver por delante de mí es más desagradable que agradable",
                  color: darkblue,
                  colorText: Colors.white,
                  valueL: 0,
                  valueR: 1,
                  onSwiped: () {
                    setState(() {
                      cardCount++;
                    });
                  }), //11
              CardsFirst(
                  id: 10,
                  text:
                      "Mis pasadas experiencias me han preparado bien para el futuro",
                  color: Colors.white,
                  colorText: Colors.black,
                  valueL: 1,
                  valueR: 0,
                  onSwiped: () {
                    setState(() {
                      cardCount++;
                    });
                  }), //10
              CardsFirst(
                  id: 9,
                  text:
                      "No logro hacer que las cosas cambien, y no existen razones para creer que pueda en el futuro",
                  color: darkblue,
                  colorText: Colors.white,
                  valueL: 0,
                  valueR: 1,
                  onSwiped: () {
                    setState(() {
                      cardCount++;
                    });
                  }), //9
              CardsFirst(
                  id: 8,
                  text:
                      "Espero más cosas buenas de la vida que lo que la gente suele conseguir por término medio",
                  color: Colors.white,
                  colorText: Colors.black,
                  valueL: 1,
                  valueR: 0,
                  onSwiped: () {
                    setState(() {
                      cardCount++;
                    });
                  }), //8
              CardsFirst(
                  id: 7,
                  text: "Mi futuro me parece oscuro",
                  color: darkblue,
                  colorText: Colors.white,
                  valueL: 0,
                  valueR: 1,
                  onSwiped: () {
                    setState(() {
                      cardCount++;
                    });
                  }), //7
              CardsFirst(
                  id: 6,
                  text:
                      "En el futuro, espero conseguir lo que me pueda interesar",
                  color: Colors.white,
                  colorText: Colors.black,
                  valueL: 1,
                  valueR: 0,
                  onSwiped: () {
                    setState(() {
                      cardCount++;
                    });
                  }), //6
              CardsFirst(
                  id: 5,
                  text:
                      "Tengo bastante tiempo para llevar a cabo las cosas que quisiera poder hacer",
                  color: darkblue,
                  colorText: Colors.white,
                  valueL: 1,
                  valueR: 0,
                  onSwiped: () {
                    setState(() {
                      cardCount++;
                    });
                  }), //5
              CardsFirst(
                  id: 4,
                  text: "No puedo imaginar cómo será mi vida dentro de 10 años",
                  color: Colors.white,
                  colorText: Colors.black,
                  valueL: 0,
                  valueR: 1,
                  onSwiped: () {
                    setState(() {
                      cardCount++;
                    });
                  }), //4
              CardsFirst(
                  id: 3,
                  text:
                      "Cuando las cosas van mal me alivia saber que las cosas no pueden permanecer tiempo así",
                  color: darkblue,
                  colorText: Colors.white,
                  valueL: 1,
                  valueR: 0,
                  onSwiped: () {
                    setState(() {
                      cardCount++;
                    });
                  }), //3
              CardsFirst(
                  id: 2,
                  text:
                      "Puedo darme por vencido, renunciar, ya que no puedo hacer las cosas por mi mismo",
                  color: Colors.white,
                  colorText: Colors.black,
                  valueL: 0,
                  valueR: 1,
                  onSwiped: () {
                    setState(() {
                      cardCount++;
                    });
                  }), //2

              Container(
                child: CardsFirst(
                    id: 1,
                    text: "Espero el futuro con esperanza y entusiasmo",
                    color: darkblue,
                    colorText: Colors.white,
                    valueL: 1,
                    valueR: 0,
                    onSwiped: () {
                      setState(() {
                        cardCount++;
                      });
                    }),
              ),
            ],
          ),
        ),
      ),
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
