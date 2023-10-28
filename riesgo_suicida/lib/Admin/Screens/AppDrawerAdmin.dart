import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:riesgo_suicida/Admin/AdminMainExpandable.dart';
import 'package:riesgo_suicida/Admin/Screens/agregarContactos.dart';

class AppDrawerMain extends StatelessWidget {
  final Widget content;
  final String currentPage;
  final String appbarText;

  AppDrawerMain(
      {required this.content,
      required this.currentPage,
      required this.appbarText});

  Future signUserOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    Color textcolor = const Color.fromARGB(255, 0, 0, 139);
    final user = FirebaseAuth.instance.currentUser!;
    String displayName = user.displayName ?? '';
    List<String> nameParts = displayName.split(' ');
    String firstName = nameParts.isNotEmpty ? nameParts.first : '';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(185, 236, 245, 1),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        title: Text(
          appbarText,
          style: TextStyle(color: Colors.black),
        ),
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 98,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: textcolor,
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop(); // Close the drawer
                  },
                  child: Container(
                    width: screenWidth,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Bienvenido, $firstName',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            ListTile(
              title: Row(
                children: [
                  SizedBox(
                    width: 25,
                  ),
                  Icon(
                    Icons.dashboard_outlined,
                    color: textcolor,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text('Evaluaciones realizadas',
                      style: TextStyle(color: textcolor, fontSize: 16)),
                ],
              ),
              onTap: () {
                if (currentPage != "AdminMainExpandable") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const AdminMainExpandable();
                      },
                    ),
                  );
                } else {
                  Navigator.pop(context);
                }
              },
            ),
            ListTile(
              title: Row(
                children: [
                  SizedBox(
                    width: 25,
                  ),
                  Icon(
                    Icons.contacts,
                    color: textcolor,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text('Contactos de ayuda',
                      style: TextStyle(color: textcolor, fontSize: 16)),
                ],
              ),
              onTap: () {
                if (currentPage != "agregarContactos") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const agregarContactos();
                      },
                    ),
                  );
                } else {
                  Navigator.pop(context);
                }
              },
            ),
            const Spacer(),
            ListTile(
              title: Row(
                children: [
                  SizedBox(
                    width: 25,
                  ),
                  Icon(
                    Icons.exit_to_app,
                    color: textcolor,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Cerrar sesión',
                    style: TextStyle(color: textcolor, fontSize: 16),
                  ),
                ],
              ),
              onTap: () {
                signUserOut();
              },
            ),
          ],
        ),
      ),
      body: content,
    );
  }
}
