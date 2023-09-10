import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PlutchikAnswersPage extends StatefulWidget {
  final String uid;
  const PlutchikAnswersPage({required this.uid});

  @override
  State<PlutchikAnswersPage> createState() => _PlutchikAnswersPageState();
}

class _PlutchikAnswersPageState extends State<PlutchikAnswersPage> {
  static const _data = [
    {
      'questionText':
          "¿Toma de forma habitual algún medicamento como aspirinas o pastillar para dormir?"
    },
    {'questionText': "¿Tiene dificultades para conciliar el sueño?"},
    {
      'questionText':
          "¿A veces nota que podría perder el control sobre sí mismo/a?"
    },
    {'questionText': "¿Tiene poco interés en relacionarse con la gente?"},
    {'questionText': "¿Ve su futuro con más pesimismo que optimismo?"},
    {'questionText': "¿Se ha sentido alguna vez inútil o inservible?"},
    {'questionText': "¿Ve su futuro sin ninguna esperanza?"},
    {
      'questionText':
          "¿Se ha sentido alguna vez tan fracasado/a que sólo quería meterse en la cama y abandonarlo todo?"
    },
    {'questionText': "¿Está deprimido/a ahora?"},
    {
      'questionText':
          "¿Está usted separado/a, divorciado/a o viudo/a o ha terminado recientemente una relación sentimental importante?"
    },
    {
      'questionText':
          "¿Sabe si alguien de su familia ha intentado suicidarse alguna vez?"
    },
    {
      'questionText':
          "¿Alguna vez se ha sentido tan enfadado/a que habría sido capaz de matar a alguien?"
    },
    {'questionText': "¿Ha pensado alguna vez en suicidarse?"},
    {
      'questionText':
          "¿Le ha comentado a alguien, en alguna ocasión, que quería suicidarse?"
    },
    {'questionText': "¿Ha intentado alguna vez quitarse la vida?"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plutchik respuestas'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('PlutchikAnswers')
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

          return Container(
            child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var answerData =
                    snapshot.data!.docs[index].data() as Map<String, dynamic>;
                var answer = answerData['answer'];

                return Container(
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.grey,
                            spreadRadius: 4,
                            blurRadius: 8,
                            offset: Offset(0, 3))
                      ]),
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
                              style: TextStyle(fontSize: 16))
                        ])),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          textAlign: TextAlign.start,
                          text: TextSpan(
                              style: DefaultTextStyle.of(context).style,
                              children: <TextSpan>[
                                const TextSpan(
                                  text: 'Respuesta:',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                TextSpan(
                                    text: ' $answer',
                                    style: TextStyle(fontSize: 16))
                              ]),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
