import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AnswersPage extends StatefulWidget {
  @override
  _AnswersPageState createState() => _AnswersPageState();
}

class _AnswersPageState extends State<AnswersPage> {
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

  @override
  Widget build(BuildContext context) {
    String userId = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        title: const Text('APGAR respuestas'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('APGARanswers')
            .doc(userId)
            .collection('Answers')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Text('No answers found.');
          }

          // Build and return a widget to display the answers
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var answerData =
                  snapshot.data!.docs[index].data() as Map<String, dynamic>;
              return ListTile(
                title: Text('Question: ${_data[index]['questionText']}'),
                subtitle: Column(
                  children: [   
                    // Adding the extraction logic here
                    ...(_data[index]['answers'] as List<Map<String, dynamic>>?)
                            ?.where((answer) => answer['score'] == 0.0)
                            .map((answer) =>
                                Text('Answer: ${answer['text']}'))
                            .toList() ??
                        [],
                        Text('Score: ${answerData['answerScore']}'),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
