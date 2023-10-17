import 'package:flutter/material.dart';
import 'package:riesgo_suicida/User/multchoice/quiz.dart';
import 'package:riesgo_suicida/User/Screens/temp.dart';
import 'package:riesgo_suicida/User/Screens/temp.dart' as globals;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';

class SecondQuiz extends StatefulWidget {
  const SecondQuiz({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SecondQuiz();
  }
}

class _SecondQuiz extends State<SecondQuiz> {
  final CollectionReference userAnswersCollection =
      FirebaseFirestore.instance.collection('IdeacionAnswers');

  static const _data = [
    {
      'questionText': 'Deseo de vivir',
      'answers': [
        {'text': 'Moderado a fuerte', 'score': 0.00},
        {'text': 'Débil', 'score': 1.00},
        {'text': 'Ninguno', 'score': 2.00},
      ]
    },
    {
      'questionText': 'Deseo de morir',
      'answers': [
        {'text': 'Ninguno', 'score': 0.00},
        {'text': 'Débil', 'score': 1.00},
        {'text': 'Moderado a fuerte', 'score': 2.00},
      ]
    },
    {
      'questionText': 'Razones para vivir/morir ',
      'answers': [
        {'text': 'Porque seguir viviendo vale más que morir', 'score': 0.00},
        {'text': 'Aproximadamente iguales', 'score': 1.00},
        {
          'text': 'Porque la muerte vale más que seguir viviendo',
          'score': 2.00
        },
      ]
    },
    {
      'questionText': 'Deseo de intentar activamente el suicidio',
      'answers': [
        {'text': 'Ninguno', 'score': 0.00},
        {'text': 'Débil', 'score': 1.00},
        {'text': 'Moderado a fuerte', 'score': 2.00},
      ]
    },
    {
      'questionText': 'Deseos pasivos de suicidio',
      'answers': [
        {
          'text': 'Puede tomar precauciones para salvaguardar la vida',
          'score': 0.00
        },
        {'text': 'Puede dejar de vivir/morir por casualidad', 'score': 1.00},
        {
          'text': 'Puede evitar las etapas necesarias para seguir con vida',
          'score': 2.00
        },
      ]
    },
    {
      'questionText':
          'Dimensión temporal (duración de la ideación/deseo suicida)',
      'answers': [
        {'text': 'Breve, períodos pasajeros', 'score': 0.00},
        {'text': 'Por amplios períodos de tiempo', 'score': 1.00},
        {'text': 'Continuo(crónico) o casi continuo', 'score': 2.00},
      ]
    },
    {
      'questionText': 'Dimensión temporal (frecuencia del suicidio)',
      'answers': [
        {'text': 'Raro, ocasional', 'score': 0.00},
        {'text': 'Intermitente', 'score': 1.00},
        {'text': 'Persistente o continuo', 'score': 2.00},
      ]
    },
    {
      'questionText': 'Actitud hacia la ideación/deseo',
      'answers': [
        {'text': 'Rechazo', 'score': 0.00},
        {'text': 'Ambivalente, indiferente', 'score': 1.00},
        {'text': 'Aceptación', 'score': 2.00},
      ]
    },
    {
      'questionText':
          'Control sobre la actividad suicida/deseos de comportamiento impulsivo',
      'answers': [
        {'text': 'Tiene sentido del control', 'score': 0.00},
        {'text': 'Inseguro', 'score': 1.00},
        {'text': 'No tiene sentido del control', 'score': 2.00},
      ]
    },
    {
      'questionText':
          'Disuasivos para un intento activo (familia, religión, irreversibilidad)',
      'answers': [
        {'text': 'Puede no intentarlo a causa de un disuasivo', 'score': 0.00},
        {
          'text': 'Alguna preocupación sobre los medios pueden disuadirlo',
          'score': 1.00
        },
        {
          'text': 'Mínima o ninguna preocupación o interés por ellos',
          'score': 2.00
        },
      ]
    },
    {
      'questionText': 'Razones para el intento contemplado',
      'answers': [
        {
          'text': 'Manipular el entorno, llamar la atención, vengarse',
          'score': 0.00
        },
        {'text': 'Combinación de las respuestas', 'score': 1.00},
        {
          'text':
              'Escapar, solucionar los problemas, finalizar de forma absoluta',
          'score': 2.00
        },
      ]
    },
    {
      'questionText':
          'Método (especificidad/planificación del intento contemplado)',
      'answers': [
        {'text': 'No considerado', 'score': 0.00},
        {'text': 'Considerado, pero detalles no calculados', 'score': 1.00},
        {'text': 'Detalles calculados/bien formulados', 'score': 2.00},
      ]
    },
    {
      'questionText':
          'Método (accesibilidad/oportunidad para el intento contemplado)',
      'answers': [
        {
          'text': 'Método no disponible, inaccesible. No hay oportunidad',
          'score': 0.00
        },
        {
          'text': 'El método puede tomar tiempo o esfuerzo. Oportunidad escasa',
          'score': 1.00
        },
        {
          'text':
              'Método y oportunidad accesibles: futura oportunidad o accesibilidad del método previsto',
          'score': 2.00
        },
      ]
    },
    {
      'questionText':
          'Sentido de <<capacidad>> para llevar adelante el intento ',
      'answers': [
        {
          'text': 'No tiene el valor, demasiado débil, miedoso, incompetente',
          'score': 0.00
        },
        {'text': 'Inseguridad sobre su valor', 'score': 1.00},
        {'text': 'Seguros de su valor, capacidad', 'score': 2.00},
      ]
    },
    {
      'questionText': 'Expectativas/espera del intento actual',
      'answers': [
        {'text': 'No', 'score': 0.00},
        {'text': 'Incierto', 'score': 1.00},
        {'text': 'Sí', 'score': 2.00},
      ]
    },
    {
      'questionText': 'Preparación actual para el intento contemplado',
      'answers': [
        {'text': 'Ninguna', 'score': 0.00},
        {
          'text': 'Parcial(p. ej. empieza a almacenar pastillas, etc)',
          'score': 1.00
        },
        {
          'text': 'Completa(p. ej. tiene las pastillas, pistola cargada, etc)',
          'score': 2.00
        },
      ]
    },
    {
      'questionText': 'Nota suicida',
      'answers': [
        {'text': 'Ninguna', 'score': 0.00},
        {'text': 'Piensa sobre ella o comenzada y no terminada', 'score': 1.00},
        {'text': 'Nota terminada', 'score': 2.00},
      ]
    },
    {
      'questionText':
          'Actos finales en anticipación de la muerte (ej. testamento, póliza de seguros, etc)',
      'answers': [
        {'text': 'Ninguno', 'score': 0.00},
        {'text': 'Piensa sobre ello o hace algunos arreglos', 'score': 1.00},
        {
          'text': 'Hace planes definitivos o terminó los arreglos finales',
          'score': 2.00
        },
      ]
    },
    {
      'questionText': 'Engaño/encubrimiento del intento contemplado',
      'answers': [
        {'text': 'Reveló las ideas abiertamente', 'score': 0.00},
        {'text': 'Frenó lo que estaba expresando', 'score': 1.00},
        {'text': 'Intentó engañar, ocultar, mentir', 'score': 2.00},
      ]
    },
  ];

  var _indexQuestion = 0;
  double _totalScore = 0.00;

  void _answerQuestion(double score) async {
    _totalScore += score;

    String userId = FirebaseAuth.instance.currentUser!.uid;

    await userAnswersCollection
        .doc(userId)
        .collection('Answers')
        .doc(_indexQuestion.toString())
        .set({
      'questionIndex': _indexQuestion,
      'answerScore': score,
    });

    setState(() {
      _indexQuestion += 1;
    });

    if (_indexQuestion == 19) {
      updateUserData(_totalScore.toInt());
      globals.secondIcon = Icons.check_box;
    }
  }

  void updateUserData(int newValue) async {
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;

      await FirebaseFirestore.instance
          .collection('Puntajes')
          .doc(userId)
          .update({
        'segundo':
            newValue, // Provide the updated value for the 'primero' field
      });

      setState(() {
        globals.appbarTitle = "smkdlakfl";
      });
    } catch (error) {
      print('Error updating user data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromRGBO(229, 251, 255, 1),
              Color.fromRGBO(229, 251, 255, 1),
              //Color.fromRGBO(212, 248, 251, 1.0),
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          ),
          child: Column(
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: (_indexQuestion <= 18 && _indexQuestion >= 0)
                      ? Quiz(
                          answerQuestion: _answerQuestion,
                          indexQuestion: _indexQuestion,
                          data: _data)
                      : ElevatedButton(
                          onPressed: () {
                            globals.currentPage = DrawerSections.dashboard;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Temp()),
                            );
                          },
                          child: const Text('Finalizar'),
                        ),
                ),
              ),
              if (_indexQuestion >= 0 && _indexQuestion < 19) ...[
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Pregunta ${_indexQuestion + 1} / 19',
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                LinearProgressBar(
                  maxSteps: 19,
                  progressType: LinearProgressBar.progressTypeLinear,
                  currentStep: _indexQuestion + 1,
                  progressColor: const Color.fromARGB(255, 74, 101, 211),
                  backgroundColor: Colors.grey,
                ),
                const SizedBox(
                  height: 25,
                )
              ],
            ],
          ),
        ),
      ),
    );
  }
}
