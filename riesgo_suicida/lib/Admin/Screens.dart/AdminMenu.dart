import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riesgo_suicida/Admin/AdminMain.dart';
import 'package:riesgo_suicida/Answers/APGAR_answers.dart';
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
import 'package:riesgo_suicida/User/util/my_header_drawer.dart';

var currentPage = DrawerSections.dashboard;
IconData firstIcon = Icons.square_outlined;
IconData secondIcon = Icons.square_outlined;
IconData thirdIcon = Icons.square_outlined;
IconData fourthIcon = Icons.square_outlined;

class AdminMenu extends StatefulWidget {
  const AdminMenu({super.key});
  @override
  State<AdminMenu> createState() => _AdminMenuState();
}

class _AdminMenuState extends State<AdminMenu> {
  final user = FirebaseAuth.instance.currentUser!;
  Future signUserOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    var container;
    if (currentPage == DrawerSections.dashboard) {
      container = AdminMain();
    }

    return Scaffold(
      
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
            "Dashboard",
            Icons.dashboard_outlined,
          ),
          menuItem(
            6,
            "Sign Out",
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
    }

    return Material(
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            if (id == 1) {
              currentPage = DrawerSections.dashboard;
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
  Fifth,
  firstAnswers,
  secondAnswers,
  thirdAnswers,
  fourthAnswers
}
//Remove answers pages