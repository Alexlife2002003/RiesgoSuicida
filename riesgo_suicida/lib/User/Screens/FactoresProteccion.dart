import 'package:flutter/material.dart';
import 'package:riesgo_suicida/User/Screens/Instrucciones.dart';

class FactoresProteccion extends StatefulWidget {
  const FactoresProteccion({super.key});

  @override
  State<FactoresProteccion> createState() => _FactoresProteccionState();
}

class _FactoresProteccionState extends State<FactoresProteccion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(229, 251, 255, 1),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: const [
                NumberedSection(
                  number: "1",
                  title: "Factores Personales",
                  content: "● Tener un buen estado de salud física y mental.\n" +
                      "● Autoestima saludable.\n" +
                      "● Mostrar habilidades sociales y recursos de afrontamiento saludable ante dificultades.\n" +
                      "● Buenas habilidades de comunicación.\n" +
                      "● Capacidad para regular las propias emociones.\n" +
                      "● Existencia de creencias espirituales.\n" +
                      "● Valores de cooperación, respeto, amistad…\n" +
                      "● Una red social de apoyo y calidad.",
                ),
                NumberedSection(
                    number: "2",
                    title: "Factores Familiares",
                    content: "● Relaciones familiares saludables.\n" +
                        "● Buena cohesión entre los diferentes miembros familiares.\n" +
                        "● Existencia de confianza, respeto, flexibilidad y seguridad.\m"),
                NumberedSection(
                    number: "3",
                    title: "Factores Relacionados con la Sexualidad",
                    content: "● Acceso a recursos de ayuda.\n" +
                        "● Educación sexual de calidad.\n" +
                        "● Desenvolverse en un ambiente respetuoso con su identidad u orientación sexual.\n"),
                NumberedSection(
                    number: "4",
                    title: "Factores académicos y laborales",
                    content:
                        "● Relaciones saludables entre iguales y el resto de los miembros de la institución.\n" +
                            "● Existencia de formación y protocolos acerca de cómo prevenir y abordar la conducta suicida.\n" +
                            "● Conexión con recursos de ayuda externos."),
                NumberedSection(
                    number: "5",
                    title: "Factores comunitarios y sociales",
                    content: "● Apoyo social de calidad.\n" +
                        "● Acceso a recursos de ayuda eficaces.\n" +
                        "● Fomentar la concienciación social y la información veraz sobre esta problemática."),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
