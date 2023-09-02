import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DesesperanzaAnswersPage extends StatefulWidget {
  const DesesperanzaAnswersPage({super.key});

  @override
  _DesesperanzaAnswersPageState createState() =>
      _DesesperanzaAnswersPageState();
}

class _DesesperanzaAnswersPageState extends State<DesesperanzaAnswersPage> {
  static const _data = [
    // Question 20
    {'questionText': "Espero el futuro con esperanza y entusiasmo"},
    // Question 19
    {
      'questionText':
          "Puedo darme por vencido, renunciar, ya que no puedo hacer las cosas por mi mismo"
    },
    // Question 18
    {
      'questionText':
          "Cuando las cosas van mal me alivia saber que las cosas no pueden permanecer tiempo así"
    },

    // Question 17
    {'questionText': "No puedo imaginar cómo será mi vida dentro de 10 años"},
    // Question 16
    {
      'questionText':
          "Tengo bastante tiempo para llevar a cabo las cosas que quisiera poder hacer"
    },
    // Question 15
    {
      'questionText': "En el futuro, espero conseguir lo que me pueda interesar"
    },

    // Question 14
    {'questionText': "Mi futuro me parece oscuro"},
    // Question 13
    {
      'questionText':
          "Espero más cosas buenas de la vida que lo que la gente suele conseguir por término medio"
    },

    // Question 12
    {
      'questionText':
          "No logro hacer que las cosas cambien, y no existen razones para creer que pueda en el futuro"
    },

    // Question 11
    {
      'questionText':
          "Mis pasadas experiencias me han preparado bien para el futuro"
    },
    // Question 10
    {
      'questionText':
          "Todo lo que puedo ver por delante de mí es más desagradable que agradable"
    },
    // Question 9
    {'questionText': "No espero conseguir lo que realmente deseo"},
    // Question 8
    {
      'questionText':
          "Cuando miro hacia el futuro, espero que seré más feliz de lo que soy ahora"
    },
    // Question 7
    {'questionText': "Las cosas no marchan como yo quisiera"},
    // Question 6
    {'questionText': "Tengo una gran confianza en el futuro"},
    // Question 5
    {
      'questionText':
          "Nunca consigo lo que deseo, por lo que es absurdo desear cualquier cosa"
    },
    // Question 4
    {
      'questionText':
          "Es muy improbable que pueda lograr una satisfacción real en el futuro"
    },
    // Question 3
    {'questionText': "El futuro me parece vago e incierto"},
    // Question 2
    {'questionText': "Espero más bien épocas buenas que malas"},
    // Question 1
    {
      'questionText':
          "No merece la pena que intente conseguir algo que desee, porque probablemente no lo lograré"
    },
  ];
  @override
  Widget build(BuildContext context) {
    String userId = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Desesperanza respuestas'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('DesesperanzaAnswers')
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
