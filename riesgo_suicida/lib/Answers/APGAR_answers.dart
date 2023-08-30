import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class APGARAnswersPage extends StatefulWidget {
  @override
  _APGARAnswersPageState createState() => _APGARAnswersPageState();
}

class _APGARAnswersPageState extends State<APGARAnswersPage> {
  static const _data = [
    // Question 1
    {
      'questionText':
          'Me satisface la forma en que mi familia y yo pasamos el tiempo juntos',
      'answers': [
        {'text': 'Casi nunca', 'score': 0.00},
        {'text': 'Algunas veces', 'score': 1.00},
        {'text': 'Casi Siempre', 'score': 2.00},
      ]
    },
    // Question 2
    {
      'questionText':
          'Estoy satisfecho con el modo que tiene mi familia de hablar las cosas conmigo y de cómo compartimos los problemas',
      'answers': [
        {'text': 'Casi nunca', 'score': 0.00},
        {'text': 'Algunas veces', 'score': 1.00},
        {'text': 'Casi Siempre', 'score': 2.00},
      ]
    },
    // Question 3
    {
      'questionText':
          'Me agrada pensar que mi familia acepta y apoya mis deseos de llevar a cabo nuevas actividades o seguir una nueva dirección',
      'answers': [
        {'text': 'Casi nunca', 'score': 0.00},
        {'text': 'Algunas veces', 'score': 1.00},
        {'text': 'Casi Siempre', 'score': 2.00},
      ]
    },
    // Question 4
    {
      'questionText':
          'Me satisface el modo que tiene mi familia de expresar su afecto y cómo responde a mis emociones, como cólera, tristeza y amor',
      'answers': [
        {'text': 'Casi nunca', 'score': 0.00},
        {'text': 'Algunas veces', 'score': 1.00},
        {'text': 'Casi Siempre', 'score': 2.00},
      ]
    },
    // Question 5
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
              return Container(
                margin: EdgeInsets.all(16),
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  )
                ]),
                child: ListTile(
                  title: RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                        const TextSpan(
                          text: 'Pregunta:',
                          style:  TextStyle(
                            fontWeight:
                                FontWeight.bold, 
                                fontSize: 18
                          ),
                        ),
                        
                        TextSpan(
                          text: '\n${_data[index]['questionText']}',
                          style: TextStyle(fontSize: 16,)
                          
                        ),
                      ],
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Adding the extraction logic here
                      ...(_data[index]['answers']
                                  as List<Map<String, dynamic>>?)
                              ?.where((answer) => answer['score'] == 0.0)
                              .map(
                                  (answer) => Text('Answer: ${answer['text']}'))
                              .toList() ??
                          [],
                      RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          style: DefaultTextStyle.of(context).style,
                          children: <TextSpan>[
                            const TextSpan(
                              text:'Score:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18
                              ),
                            ),
                            TextSpan(
                              text: ' ${answerData['answerScore']}',
                              style: TextStyle(fontSize: 16)
                            ),
                          ]
                        ),
                      ),
                     
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
