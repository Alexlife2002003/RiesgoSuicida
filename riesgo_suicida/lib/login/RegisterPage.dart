import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;
final CollectionReference usersCollection = firestore.collection('Puntajes');
final CollectionReference usersDetails = firestore.collection('Users');

void createUserDatabase(String UID, String firstName, String lastName,
    String age, String genero, String programaAcademico, String correo) {
  usersCollection.doc(UID).set({
    'primero': -1,
    'segundo': -1,
    'tercero': -1,
    'cuarto': -1,
  });

  usersDetails.doc(UID).set({
    'firstname': firstName,
    'lastname': lastName,
    'admin': false,
    'edad': age,
    'genero': genero,
    'programaAcademico': programaAcademico,
    'correo': correo,
    'timestamp': FieldValue.serverTimestamp(),
  });
}

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _ageController = TextEditingController();
  final _generoController =
      TextEditingController(text: "Masculino"); // Default value is "Masculino"
  final _programaAcademicoController = TextEditingController();

  Future<void> signUserUp() async {
    showDialog(
      context: context,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );
    try {
      if (_passwordController.text == _confirmPasswordController.text) {
        final userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

        final firstName = _firstNameController.text;
        final lastName = _lastNameController.text;
        final displayName = "$firstName $lastName";
        final age = _ageController.text;
        final genero = _generoController.text;
        final programaAcademico = _programaAcademicoController.text;
        final email = _emailController.text;

        userCredential.user!.updateDisplayName(displayName);
        createUserDatabase(userCredential.user!.uid, firstName, lastName, age,
            genero, programaAcademico, email);

        Navigator.of(context).pop();
      } else {
        showErrorMessage("Passwords don't match");
      }
    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop();
      if (e.code == 'email-already-in-use') {
        showErrorMessage("Email already in use");
      }
    }
  }

  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.lightBlue,
        title: Center(
          child: Text(
            message,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  void _showPrivacyPolicy() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.grey.withOpacity(0.9),
        title: const Text(
          'Políticas de privacidad',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        content: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Privacy policy content
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'Close',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _ageController.dispose();
    _generoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const btnColor = Color.fromARGB(255, 74, 101, 211);

    Widget buildStyledDropdown(
      String hintText,
      TextEditingController controller,
      List<String> items,
      ValueChanged<String?> onChanged,
    ) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: DropdownButtonFormField<String>(
              value: controller.text,
              items: items.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              onChanged: onChanged,
              decoration: InputDecoration(
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: TextStyle(
                    color: Colors.grey[200],
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
            ),
          ),
        ),
      );
    }

    Widget buildInputField(String hintText, TextEditingController controller,
        bool obscureText, TextInputType inputType) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: TextField(
              controller: controller,
              obscureText: obscureText,
              keyboardType: inputType,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(155, 212, 255, 1),
              Color.fromRGBO(155, 212, 255, 1),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'lib/assets/start.png',
                    width: 200,
                    height: 200,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Center(
                    child: Text(
                      'Hola nuevamente',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 36),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Center(
                    child: Text(
                      '¡Hagamos una cuenta para ti!',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                  const SizedBox(height: 40),
                  buildInputField('Nombre', _firstNameController, false,
                      TextInputType.text),
                  const SizedBox(height: 10),
                  buildInputField('Apellidos', _lastNameController, false,
                      TextInputType.text),
                  const SizedBox(height: 10),
                  buildInputField('Correo Electrónico', _emailController, false,
                      TextInputType.emailAddress),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
                        child: buildInputField('Edad', _ageController, false,
                            TextInputType.number),
                      ),
                      // Add some spacing between the input fields
                      Expanded(
                        flex: 3,
                        child: buildStyledDropdown(
                          'Género',
                          _generoController,
                          ["Masculino", "Femenino", "Otro"],
                          (newValue) {
                            setState(() {
                              _generoController.text = newValue!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  buildInputField('Programa Academico',
                      _programaAcademicoController, false, TextInputType.text),
                  const SizedBox(height: 10),
                  buildInputField('Contraseña', _passwordController, true,
                      TextInputType.text),
                  const SizedBox(height: 10),
                  buildInputField('Confirmar contraseña',
                      _confirmPasswordController, true, TextInputType.text),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: GestureDetector(
                      onTap: signUserUp,
                      child: Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: btnColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Center(
                            child: Text(
                              'Registrarte',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        '¿Ya tienes cuenta? ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const Text(
                          'Iniciar sesión',
                          style: TextStyle(
                            color: Color.fromARGB(255, 74, 101, 211),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: _showPrivacyPolicy,
                    child: const Text(
                      'Políticas de privacidad',
                      style: TextStyle(
                        color: Color.fromARGB(255, 25, 0, 255),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
