# RiesgoSuicida
Es una aplicación desarrollada en flutter, la cual se apoya con firebase, para realizar un apoyo en la identificación de estudiantes universitarios en riesgo de suicidio.

## Modificaciones necesarias
### flutter_swipable.dart
en el pubsec podemos ver la dependencia flutter_swipable de la cual estamos usando la version `1.2.1`,
para su correcto funcionamiento, en su linea 132, es necesario hacer un cambio 
se debe cambiar `overflow:Overflow.visible` por `clipBehavior: Clip.none`
