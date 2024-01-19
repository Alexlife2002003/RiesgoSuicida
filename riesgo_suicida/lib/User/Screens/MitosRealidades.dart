import 'package:flutter/material.dart';
import 'package:riesgo_suicida/User/Screens/Instrucciones.dart';

class MitosRealidades extends StatefulWidget {
  const MitosRealidades({super.key});

  @override
  State<MitosRealidades> createState() => _MitosRealidadesState();
}

class _MitosRealidadesState extends State<MitosRealidades> {
  @override
  Widget BuildDarkText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      // textAlign: TextAlign.justify,
    );
  }

  Widget Sections(String number, String title, String content) {
    return NumberedSection(number: number, title: title, content: content);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(229, 251, 255, 1),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              BuildDarkText(
                  "Para prevenir el suicidio es importante conocerlo de forma veraz, solo así podremos identificar adecuadamente las situaciones de riesgo y tomar las medidas necesarias."),
              SizedBox(
                height: 15,
              ),
              BuildDarkText(
                  "A continuación, se exponen algunos de los mitos más extendidos acerca del suicidio con sus correspondientes realidades y las consecuencias de los mismos:"),
              SizedBox(
                height: 10,
              ),

              Sections(
                  "1",
                  "Hablar sobre el suicidio desencadena ideas o conductas suicidas",
                  "Tratar el tema de forma respetuosa puede ser la oportunidad para que una persona en riesgo pida ayuda. Crear espacios donde hablar del suicidio puede aliviar a quienes se lo plantean, y arrojar luz sobre recursos para evitarlo y proporcionar algo de esperanza."),
            
              Sections(
                  "2",
                  "Quien lo dice no lo hace y quien lo hace no lo dice",
                  "En la mayoría de los casos, las personas en peligro comunican verbalmente o dejan entrever sus intenciones. Para prevenir esta problemática es esencial prestar atención y tomar medidas ante dichas señales. Aunque creamos que no existe una intención suicida real, siempre existe un riesgo."),
              Sections(
                  "3",
                  "Solo las personas mayores y con problemas graves se suicidan",
                  "Actualmente, para la población joven de entre 15 y 29 años es la principal causa de muerte. Además, ningún problema se ha de menospreciar, lo que para alguien no es importante para otra persona puede ser fundamental."),
              Sections("4", "“Quien se suicida tiene una enfermedad mental”",
                  "Tener trastornos mentales suponen un factor de riesgo para desarrollar conductas suicidas, pero no es un requisito necesario. La mayoría de las personas que se suicidan no tienen ninguna enfermedad mental."),
              Sections(
                  "5",
                  "La persona con conducta suicida está decidida a morir",
                  "Las personas que manifiestan conductas suicidas no quieren morir, solo quieren terminar con el dolor que sienten. En ese momento no ven otra alternativa a su sufrimiento."),
              Sections("6", "El suicidio no se puede prevenir",
                  "Las conductas suicidas se pueden y se deben prevenir. El conocimiento sobre el tema, la prevención de factores de riesgo y la promoción de factores protectores son esenciales contra el suicidio. El suicidio es difícil de predecir, pero se puede prevenir."),
              Sections("7", "El que se suicida es un cobarde/valiente",
                  "El suicidio no tiene nada que ver con la cobardía o la valentía sino con el sufrimiento y la desesperanza. Este mito puede fomentar actitudes de admiración o desprecio inadecuadas."),
              Sections(
                  "8",
                  "Si se reta a una persona en posible riesgo de suicidio, no lo intenta. ",
                  "La persona que está pensando en el suicidio está sufriendo intensamente y no encuentra como hacer frente a esa situación. Retarle es un acto irresponsable con el que la persona se siente todavía más sola e incomprendida.")
            ]),
          ),
        ),
      ),
    );
  }
}
