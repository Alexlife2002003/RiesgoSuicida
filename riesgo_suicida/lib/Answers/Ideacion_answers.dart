import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class IdeacionAnswersPage extends StatefulWidget {
  @override
  _IdeacionAnswersPageState createState() => _IdeacionAnswersPageState();
}

class _IdeacionAnswersPageState extends State<IdeacionAnswersPage> {
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
        {'text': 'Aproxidamente iguales', 'score': 1.00},
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
      'questionText': 'Control sobre la actividad suicida/deseos de acting out',
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
        {'text': 'Método y oportunidad accesibles', 'score': 2.00},
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
          'text': 'Parcial(ej. empieza a almacenar pastillas, etc)',
          'score': 1.00
        },
        {
          'text': 'Completa(ej. tiene las pastillas, pistola cargada, etc)',
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

  @override
  Widget build(BuildContext context) {
    String userId = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ideacion Suicida respuestas'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('IdeacionAnswers')
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
                            .map((answer) => Text('Answer: ${answer['text']}'))
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
