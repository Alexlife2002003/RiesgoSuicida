import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riesgo_suicida/Answers/Desesperanza_answers.dart';
import 'package:riesgo_suicida/Answers/Ideacion_answers.dart';
import 'package:riesgo_suicida/Answers/Plutchik_answers.dart';
import 'package:riesgo_suicida/User/Screens/first_quiz.dart';
import 'package:riesgo_suicida/User/Screens/FourthQuiz.dart';
import 'package:riesgo_suicida/User/Screens/second_quiz.dart';
import 'package:riesgo_suicida/User/Screens/third_quiz.dart';
import 'package:riesgo_suicida/User/Screens/Dashboard.dart';
import 'package:riesgo_suicida/User/Screens/Instrucciones.dart';
import 'package:riesgo_suicida/User/Screens/Dashboard.dart' as glob;
import '../util/my_header_drawer.dart';

var currentPage = DrawerSections.dashboard;
IconData firstIcon = Icons.square_outlined;
IconData secondIcon = Icons.square_outlined;
IconData thirdIcon = Icons.square_outlined;
IconData fourthIcon = Icons.square_outlined;
var appbarTitle = '';

class Temp extends StatefulWidget {
  const Temp({super.key});
  @override
  State<Temp> createState() => _TempState();
}

class _TempState extends State<Temp> {
  final user = FirebaseAuth.instance.currentUser!;
  Future signUserOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    var container;
    Color appbarColor = const Color.fromRGBO(185, 236, 245, 1);

    switch (currentPage) {
      case DrawerSections.dashboard:
        appbarTitle = "";
        container = const Dashboard();
        break;
      case DrawerSections.instrucciones:
        appbarTitle = "";
        container = const Instrucciones();
        break;
      case DrawerSections.first:
        appbarTitle = "Cuestionario 1";
        container = const FirstQuiz();
        break;
      case DrawerSections.second:
        appbarTitle = "Cuestionario 2";
        container = const SecondQuiz();
        break;
      case DrawerSections.third:
        appbarTitle = "Cuestionario 3";
        container = const ThirdQuiz();
        break;
      case DrawerSections.Fourth:
        appbarTitle = "Cuestionario 4";
        container = const FourthQuiz();
        break;
      default:
        appbarTitle = " ";
        container = const Dashboard();
        break;
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbarColor,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          appbarTitle,
          style: TextStyle(color: Colors.black),
        ),
        elevation: 1,
        centerTitle: true,
      ),
      body: container,
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const MyHeaderDrawer(),
              myDrawerList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget myDrawerList() {
    return Container(
      padding: const EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        children: [
          menuItem(
            1,
            "Panel",
            Icons.dashboard_outlined,
          ),
          menuItem(
            7,
            "Instrucciones",
            Icons.list,
          ),
          menuItem(
            2,
            "Cuestionario 1",
            firstIcon,
          ),
          menuItem(3, "Cuestionario 2", secondIcon),
          menuItem(4, "Cuestionario 3", thirdIcon),
          menuItem(
            5,
            "Cuestionario 4",
            fourthIcon,
          ),
          menuItem(
            6,
            "Cerrar Sesión",
            Icons.exit_to_app,
          ),
        ],
      ),
    );
  }

  Widget menuItem(int id, String title, IconData icon) {
    Color darkblue = const Color.fromARGB(255, 0, 0, 139);
    Color backgorundDrawer = const Color.fromRGBO(3, 38, 173, .5);
    Color itemBackgroundColor =
        Colors.transparent; // Default background color is transparent

    // Determine the background color based on the current page

    if (currentPage == DrawerSections.dashboard && id == 1) {
      itemBackgroundColor = backgorundDrawer;
    } else if (currentPage == DrawerSections.first && id == 2) {
      itemBackgroundColor = backgorundDrawer;
    } else if (currentPage == DrawerSections.second && id == 3) {
      itemBackgroundColor = backgorundDrawer;
    } else if (currentPage == DrawerSections.third && id == 4) {
      itemBackgroundColor = backgorundDrawer;
    } else if (currentPage == DrawerSections.Fourth && id == 5) {
      itemBackgroundColor = backgorundDrawer;
    } else if (currentPage == DrawerSections.Fourth && id == 7) {
      itemBackgroundColor = backgorundDrawer;
    }

    return Material(
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            if (id == 1) {
              currentPage = DrawerSections.dashboard;
            }
            if (id == 7) {
              currentPage = DrawerSections.instrucciones;
            }
            if (id == 2 && glob.first == -1) {
              currentPage = DrawerSections.first;
            }
            if (glob.first > 0) {
              firstIcon = Icons.check_box;
            } else {
              firstIcon = Icons.square_outlined;
            }
            if (id == 3 && glob.second == -1) {
              currentPage = DrawerSections.second;
            }
            if (glob.second > 0) {
              secondIcon = Icons.check_box;
            } else {
              secondIcon = Icons.square_outlined;
            }
            if (id == 4 && glob.third == -1) {
              currentPage = DrawerSections.third;
            }
            if (glob.third > 0) {
              thirdIcon = Icons.check_box;
            } else {
              thirdIcon = Icons.square_outlined;
            }
            if (id == 5 && glob.fourth == -1) {
              currentPage = DrawerSections.Fourth;
            }
            if (glob.fourth > 0) {
              fourthIcon = Icons.check_box;
            } else {
              fourthIcon = Icons.square_outlined;
            }
            if (id == 6) {
              signUserOut();
            }
          });
        },
        child: Container(
          color: itemBackgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                Expanded(
                  child: Icon(
                    icon,
                    size: 20,
                    color: darkblue,
                  ),
                ),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(color: darkblue, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

enum DrawerSections {
  dashboard,
  instrucciones,
  first,
  second,
  third,
  Fourth,
  Fifth
}
//Remove answers pages