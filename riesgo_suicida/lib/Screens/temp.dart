import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:riesgo_suicida/Screens/first_quiz.dart';
import 'package:riesgo_suicida/Screens/FourthQuiz.dart';
import 'package:riesgo_suicida/Screens/second_quiz.dart';
import 'package:riesgo_suicida/Screens/third_quiz.dart';
import 'package:riesgo_suicida/Screens/Dashboard.dart';
import 'package:riesgo_suicida/Screens/Dashboard.dart' as glob;
import '../util/my_header_drawer.dart';

var currentPage = DrawerSections.dashboard;
IconData firstIcon = Icons.square_outlined;
IconData secondIcon = Icons.square_outlined;
IconData thirdIcon = Icons.square_outlined;
IconData fourthIcon = Icons.square_outlined;

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
    if (currentPage == DrawerSections.dashboard) {
      container = const Dashboard();
    }
    if (currentPage == DrawerSections.first) {
      container = const FirstQuiz();
    }
    if (currentPage == DrawerSections.second) {
      container = const SecondQuiz();
    }
    if (currentPage == DrawerSections.third) {
      container = const ThirdQuiz();
    }
    if (currentPage == DrawerSections.Fourth) {
      container = const FourthQuiz();
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: const Text("Riesgo Suicida"),
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
            "dashboard",
            Icons.dashboard_outlined,
          ),
          menuItem(
            2,
            "Escala de Desesperanza de Beck",
            firstIcon,
          ),
          menuItem(3, "Escala de Ideación Suicida", secondIcon),
          menuItem(4, "Escala de Riesgo Suicida de Plutchik Quiz", thirdIcon),
          menuItem(
            5,
            "APGAR familiar",
            fourthIcon,
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
    return Material(
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            if (id == 1) {
              currentPage = DrawerSections.dashboard;
            }
            if (id == 2 && glob.first == 0) {
              currentPage = DrawerSections.first;
            }
            if (id == 3 && glob.second == 0) {
              currentPage = DrawerSections.second;
            }
            if (id == 4 && glob.third == 0) {
              currentPage = DrawerSections.third;
            }
            if (id == 5 && glob.fourth == 0) {
              currentPage = DrawerSections.Fourth;
            }
            if (id == 6) {
              signUserOut();
            }
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(children: [
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
          ]),
        ),
      ),
    );
  }
}

enum DrawerSections { dashboard, first, second, third, Fourth, Fifth }
