import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:riesgo_suicida/User/multchoice/quiz.dart';
import 'package:riesgo_suicida/User/Screens/temp.dart' as globals;

import 'package:riesgo_suicida/User/Screens/temp.dart';

class FourthQuiz extends StatefulWidget {
  const FourthQuiz({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FourthQuiz();
  }
}

class _FourthQuiz extends State<FourthQuiz> {
  final CollectionReference userAnswersCollection =
      FirebaseFirestore.instance.collection('APGARanswers');

  static const _data = [
    {
      'questionText':
          'Me satisface la forma en que mi familia y yo pasamos el tiempo juntos',
      'answers': [
        {'text': 'Casi nunca', 'score': 0.00},
        {'text': 'Algunas veces', 'score': 1.00},
        {'text': 'Casi Siempre', 'score': 2.00},
      ]
    },
    {
      'questionText':
          'Estoy satisfecho con el modo que tiene mi familia de hablar las cosas conmigo y de cómo compartimos los problemas',
      'answers': [
        {'text': 'Casi nunca', 'score': 0.00},
        {'text': 'Algunas veces', 'score': 1.00},
        {'text': 'Casi Siempre', 'score': 2.00},
      ]
    },
    {
      'questionText':
          'Me agrada pensar que mi familia acepta y apoya mis deseos de llevar a cabo nuevas actividades o seguir una nueva dirección',
      'answers': [
        {'text': 'Casi nunca', 'score': 0.00},
        {'text': 'Algunas veces', 'score': 1.00},
        {'text': 'Casi Siempre', 'score': 2.00},
      ]
    },
    {
      'questionText':
          'Me satisface el modo que tiene mi familia de expresar su afecto y cómo responde a mis emociones, como cólera, tristeza y amor',
      'answers': [
        {'text': 'Casi nunca', 'score': 0.00},
        {'text': 'Algunas veces', 'score': 1.00},
        {'text': 'Casi Siempre', 'score': 2.00},
      ]
    },
    {
      'questionText':
          'Me satisface la forma en que mi familia y yo pasamos el tiempo juntos',
      'answers': [
        {'text': 'Casi nunca', 'score': 0.00},
        {'text': 'Algunas veces', 'score': 1.00},
        {'text': 'Casi Siempre', 'score': 2.00},
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

    if (_indexQuestion == 5) {
      updateUserData(_totalScore.toInt());
      globals.fourthIcon = Icons.check_box;
    }
  }

  void updateUserData(int newValue) async {
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;

      await FirebaseFirestore.instance
          .collection('Puntajes')
          .doc(userId)
          .update({
        'cuarto': newValue,
      });
    } catch (error) {
      print('Error updating user data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(229, 251, 255, 1),
                Color.fromRGBO(229, 251, 255, 1),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: (_indexQuestion <= 4 && _indexQuestion >= 0)
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
              if (_indexQuestion >= 0 && _indexQuestion < 5) ...[
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Pregunta ${_indexQuestion + 1} / 5',
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                LinearProgressBar(
                  maxSteps: 5,
                  progressType: LinearProgressBar.progressTypeLinear,
                  currentStep: _indexQuestion + 1,
                  progressColor: const Color.fromARGB(255, 74, 101, 211),
                  backgroundColor: Colors.grey,
                ),
                const SizedBox(height: 25),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
