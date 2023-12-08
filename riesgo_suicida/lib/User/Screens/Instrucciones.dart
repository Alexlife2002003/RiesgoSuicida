import 'package:flutter/material.dart';

class Instrucciones extends StatelessWidget {
  const Instrucciones({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Instrucciones Quizzes y Salud Mental',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const InstructionsScreen(),
    );
  }
}

class InstructionsScreen extends StatelessWidget {
  const InstructionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromRGBO(255, 255, 255, 1),
            Color.fromRGBO(255, 255, 255, 1),
            //Color.fromRGBO(212, 248, 251, 1.0),
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Instrucciones para completar los quizzes y cuidar tu salud mental',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(58, 135, 193, 1),
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: 10),
                  Text(
                    '¡Bienvenido a nuestra app de Quizzes dedicada al bienestar mental! A continuación, te explicamos cómo completar los cuatro quizzes y recibir recomendaciones para tu salud mental. Sigue estos pasos para obtener una experiencia enriquecedora:',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: 10),
                  NumberedSection(
                    number: '1',
                    title: 'Acceso a los quizzes:',
                    content:
                        'En la pantalla principal, verás un cajón en la parte izquierda con los cuatro quizzes disponibles. Toca o selecciona este cajón para iniciar.',
                  ),
                  NumberedSection(
                    number: '2',
                    title: 'Elige un quiz:',
                    content:
                        'Una vez dentro del cajón, observarás los cuatro quizzes disponibles. Selecciona el quiz que deseas completar primero. Puedes completar los quizzes en diferentes momentos si así lo prefieres.',
                  ),
                  NumberedSection(
                    number: '3',
                    title: 'Tipos de quizzes:',
                    content:
                        'Encuentra dos tipos de quizzes: opción múltiple y tarjetas. Responde preguntas de opción múltiple seleccionando la respuesta correcta. Para los quizzes de tarjetas, desliza hacia la derecha si estás de acuerdo con el enunciado o hacia la izquierda si estás en desacuerdo].',
                  ),
                  NumberedSection(
                    number: '4',
                    title: 'Duración estimada:',
                    content:
                        'Completar los cuatro quizzes debería llevar entre 20 y 25 minutos. Puedes hacer un quiz y volver para completar los demás en otro momento.',
                  ),
                  NumberedSection(
                    number: '5',
                    title: 'Una oportunidad por quiz:',
                    content:
                        'Una vez que hayas completado un quiz, no podrás volver a realizarlo ni revisar tus respuestas. Asegúrate de revisar cuidadosamente antes de finalizar.',
                  ),
                  NumberedSection(
                    number: '6',
                    title: 'Recomendaciones para tu salud mental:',
                    content:
                        'Después de completar los cuatro quizzes, recibirás recomendaciones personalizadas para el cuidado de tu salud mental. Estas recomendaciones se basarán en tus respuestas y te proporcionarán valiosas herramientas y consejos para mejorar tu bienestar emocional.',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class NumberedSection extends StatelessWidget {
  final String number;
  final String title;
  final String content;

  const NumberedSection({
    super.key,
    required this.number,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$number. $title',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(58, 135, 193, 1),
          ),
          textAlign: TextAlign.justify,
        ),
        const SizedBox(height: 5),
       
        Padding(
          padding: const EdgeInsets.only(left:15.0),
          child: Text(
            content,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.black,
            ),
            textAlign: TextAlign.justify,
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
