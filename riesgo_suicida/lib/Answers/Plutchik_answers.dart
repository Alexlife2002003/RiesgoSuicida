import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PlutchikAnswersPage extends StatefulWidget {
  @override
  _PlutchikAnswersPageState createState() => _PlutchikAnswersPageState();
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
    String userId = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Plutchik respuestas'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('PlutchikAnswers')
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

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var answerData =
                  snapshot.data!.docs[index].data() as Map<String, dynamic>;
              var answer = answerData['answer'];

              return ListTile(
                title:
                    Text('Respuesta: $answer ${_data[index]['questionText']}'),
              );
            },
          );
        },
      ),
    );
  }
}
