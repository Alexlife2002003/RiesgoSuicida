import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:riesgo_suicida/User/Screens/ContactosDeAyuda.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;
final CollectionReference usersCollection = firestore.collection('Puntajes');

var first = 0;
var second = 0;
var third = 0;
var fourth = 0;
var percentage = 0.0;
var percentageText = '0%';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  void contactosAyuda() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ContactosDeAyuda(),
        ));
  }

  List<String> recommendations = [
    "Comienza tu día con positividad a través de una afirmación diaria.",
    "Registra tus emociones diariamente para descubrir patrones y desencadenantes.",
    "Realiza ejercicios guiados de respiración profunda y técnicas de relajación para aliviar el estrés y ansiedad.",
    "Tómate breves descansos a lo largo del día.",
    "Descubre artículos, videos y podcasts adaptados a tus necesidades.",
    "Establece y celebra objetivos personales",
    "Cultiva la gratitud registrando momentos diarios de aprecio.",
    "Participa en juegos interactivos, rompecabezas y actividades relajantes cuando neceiten un respiro de pensamientos negativos.",
  ];

  List<String> recommendations2 = [
    "Toma respiraciones lentas y profundas por la nariz y exhala por la boca para calmar tu mente y cuerpo.",
    "Siéntate en silencio y concéntrate en tu respiración, volviendo tu atención cada vez que tu mente se desvíe.",
    "Escribe un diario sobre tus pensamientos y sentimientos.",
    "Participa en una actividad creativa como dibujar, pintar o escribir para expresarte y canalizar tus emociones.",
    "Da un paseo relajado al aire libre para dejar tu mente y tomar aire fresco.",
    "Reproduce tu música favorita para elevar tu estado de ánimo y crear un ambiente relajante",
    "Utiliza tus sentidos para traerte al momento presente, identificando cosas que puedes ver, oír, tocar y oler.",
    "Imagina estar en un lugar tranquilo y sereno para reducir el estrés y la ansiedad.",
    "Divide los desafíos en pasos más pequeños y busca soluciones prácticas.",
    "Toma un baño relajante, practica la higiene personal o realiza actividades que te hagan sentir cuidado.",
    "Explora un nuevo pasatiempo, habilidad o tema de interés para mantener tu mente activa.",
    "Mira un programa de comedia.",
    "Aprieta una pelota antiestrés para liberar tensión y promover la relajación.",
    "Recuerda que sanar y progresar lleva tiempo. Sé paciente contigo mismo."
  ];

  List<String> recommendations3 = [
    "Crea un plan de seguridad personalizado.",
    "Establece obketivos diarios para fortalecer tu resiliencia emocional y celebra cada paso positivo que tomes.",
    "Set specific goals for your studies.",
    "Conéctate con profesionales de la salud mental y programa citas para recibir apoyo.",
    "Encuentra inspiración en historias de superación compartidas por otros usuarios. ",
  ];

  List<String> recommendations4 = [
    "Establece límites claros para protegerte emocionalmente y físicamente en situaciones que puedan ser perjudiciales.",
    "Practica la comunicación asertiva para expresar tus sentimientos y necesidades de manera clara y respetuosa.",
    "Identifica y enfócate en los aspectos positivos de tu vida fuera del ambiente familiar, como amigos, pasatiempos o metas personales.",
    "Prioriza tu bienestar emocional y físico.",
    "Cultiva relaciones cercanas fuera del ambiente familiar que te brinden apoyo.",
    "Diseña un plan para construir un ambiente familiar más saludable en el futuro.",
    "Identifica lugares o actividades fuera de casa donde puedas sentirte seguro y en paz cuando necesites un respiro.",
    "Imagina cómo te gustaría que fuera tu vida en el futuro y trabaja hacia esa visión, tomando pasos concretos para alejarte de un ambiente poco saludable."
  ];

  @override
  void initState() {
    super.initState();

    fetchUserData();
  }

  void setPercentage() {
    var temp = 0.0;
    var temptext = '';
    if (first > 0) {
      temp += .25;
    }
    if (second > 0) {
      temp += .25;
    }
    if (third > 0) {
      temp += .25;
    }
    if (fourth > 0) {
      temp += .25;
    }
    if (temp > 0) {
      temptext = (temp * 100).toString();
    }
    setState(() {
      percentage = temp;
      percentageText = "$temptext%";
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

  List<String> getRandomRecommendations(List<String> source) {
    List<String> randomizedRecommendations = List.from(source);
    randomizedRecommendations.shuffle();
    return randomizedRecommendations;
  }

  List<String> getTwoUniqueRandomRecommendations(List<String> recommendations) {
    if (recommendations.length <= 2) return recommendations;
    List<String> result = [];
    while (result.length < 2) {
      String randomRecommendation =
          recommendations[Random().nextInt(recommendations.length)];
      if (!result.contains(randomRecommendation)) {
        result.add(randomRecommendation);
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(255, 255, 255, 1),
              Color.fromRGBO(255, 255, 255, 1.0)
              //Color.fromRGBO(212, 248, 251, 1.0),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 60,
                ),
                CircularPercentIndicator(
                  animation: true,
                  radius: 300,
                  lineWidth: 30,
                  percent: percentage,
                  progressColor: const Color.fromRGBO(58, 135, 193, 1),
                  backgroundColor: const Color.fromARGB(255, 177, 203, 222),
                  circularStrokeCap: CircularStrokeCap.round,
                  center: Text(
                    "      $percentageText \nCompletado",
                    style: const TextStyle(fontSize: 40),
                  ),
                ),
                const SizedBox(height: 20),
                //Text(
                //  "First Quiz: ${first.toString()}\n"
                //  "Second Quiz: ${second.toString()}\n"
                //  "Third Quiz: ${third.toString()}\n"
                //  "Fourth Quiz: ${fourth.toString()}",
                //),
                const SizedBox(
                  height: 30,
                ),

                Visibility(
                  visible: percentage == 1.0,
                  child: Column(
                    children: [
                      if (first >= 0 &&
                          first <= 8 &&
                          second >= 0 &&
                          second <= 12 &&
                          third >= 0 &&
                          third <= 5 &&
                          fourth >= 7 &&
                          fourth <= 10)
                        const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            "¡Felicidades! ¡Has completado todos los cuestionarios!",
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(58, 135, 193, 1)),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          children: [
                            if (first >= 9 ||
                                second >= 13 ||
                                third >= 6 ||
                                fourth <= 6) ...{
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 25),
                                child: GestureDetector(
                                  onTap: contactosAyuda,
                                  child: Material(
                                    elevation: 5,
                                    borderRadius: BorderRadius.circular(12),
                                    child: Container(
                                      padding: const EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                        color: const Color.fromRGBO(
                                            58, 135, 193, 1),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: const Center(
                                          child: Text(
                                        'Contactos de ayuda',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      )),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              const Text(
                                "Aquí tienes algunas recomendaciones:",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            } else ...{
                              const Text(
                                "No se tienen recomendaciones.",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            },
                            const SizedBox(height: 10),
                            if (first >= 9) ...{
                              Column(
                                children: getTwoUniqueRandomRecommendations(
                                        recommendations)
                                    .map(
                                      (recommendation) => RecommendationCard(
                                          recommendation: recommendation),
                                    )
                                    .toList(),
                              ),
                            },
                            if (second >= 8) ...{
                              const SizedBox(height: 20),
                              Column(
                                children: getTwoUniqueRandomRecommendations(
                                        recommendations2)
                                    .map(
                                      (recommendation) => RecommendationCard(
                                          recommendation: recommendation),
                                    )
                                    .toList(),
                              ),
                            },
                            if (third >= 19) ...{
                              const SizedBox(height: 20),
                              Column(
                                children: getTwoUniqueRandomRecommendations(
                                        recommendations3)
                                    .map(
                                      (recommendation) => RecommendationCard(
                                          recommendation: recommendation),
                                    )
                                    .toList(),
                              ),
                            },
                            if (fourth <= 5) ...{
                              const SizedBox(height: 20),
                              Column(
                                children: getTwoUniqueRandomRecommendations(
                                        recommendations4)
                                    .map(
                                      (recommendation) => RecommendationCard(
                                          recommendation: recommendation),
                                    )
                                    .toList(),
                              ),
                            },
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RecommendationCard extends StatelessWidget {
  final String recommendation;

  const RecommendationCard({required this.recommendation});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400, // Adjust the width as needed
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Text(
        recommendation,
        style: const TextStyle(fontSize: 16),
        textAlign: TextAlign.center,
      ),
    );
  }
}
