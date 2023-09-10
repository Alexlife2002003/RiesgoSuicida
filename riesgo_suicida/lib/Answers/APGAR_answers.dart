import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class APGARAnswersPage extends StatefulWidget {
  final String uid;

  const APGARAnswersPage({required this.uid});

  @override
  State<APGARAnswersPage> createState() => _APGARAnswersPageState();
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
    Color appbarColor = const Color.fromRGBO(185, 236, 245, 1);
    Color backgroundColor = const Color.fromRGBO(229, 251, 255, 1);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text(
          'APGAR respuestas',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: appbarColor,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('APGARanswers')
            .doc(widget.uid)
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
            return const Text('No fueron encontradas respuestas.');
          }

          // Build and return a widget to display the answers
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var answerData =
                  snapshot.data!.docs[index].data() as Map<String, dynamic>;
              return SizedBox(
                child: Container(
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.grey, // Set the shadow color to grey
                          spreadRadius: 4,
                          blurRadius: 8,
                          offset: Offset(0, 3)),
                    ],
                  ),
                  child: ListTile(
                    title: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          const TextSpan(
                            text: 'Pregunta:',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          TextSpan(
                              text: '\n${_data[index]['questionText']}',
                              style: const TextStyle(
                                fontSize: 16,
                              )),
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
                                .map((answer) =>
                                    Text('Answer: ${answer['text']}'))
                                .toList() ??
                            [],
                        RichText(
                          textAlign: TextAlign.start,
                          text: TextSpan(
                              style: DefaultTextStyle.of(context).style,
                              children: <TextSpan>[
                                const TextSpan(
                                  text: 'Score:',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                TextSpan(
                                    text: ' ${answerData['answerScore']}',
                                    style: const TextStyle(fontSize: 16)),
                              ]),
                        ),
                      ],
                    ),
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
