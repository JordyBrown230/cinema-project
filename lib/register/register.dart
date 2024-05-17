import 'package:flutter/material.dart';
import 'package:project/login/login.dart';
import 'package:project/db/db_helper.dart';
import 'package:project/menu/menu.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController email = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final db = DatabaseHelper();
  bool showPassword = false;

  void navigateToHome(Map<String, dynamic>? user) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Menu()));
  }

  void createUser() async {
    if (formKey.currentState!.validate()) {
      String message = await validateExistence();
      if (message.isEmpty) {
        await insertUser();
      } else {
        showSnackBar(message);
      }
    }
  }

  Future<String> validateExistence() async {
    bool existEmail = await db.checkField('email', email.text);
    bool existUsername = await db.checkField('username', username.text);
    if (existEmail) {
      return 'Correo electrónico ingresado ya se encuentra registrado';
    } else if (existUsername) {
      return 'Nombre de usuario ya existe';
    } else {
      return '';
    }
  }

  void showSnackBar(String message) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    scaffoldMessenger.showSnackBar(
      SnackBar(
        showCloseIcon: true,
        closeIconColor: Colors.red,
        backgroundColor: const Color(0xFFE8DFCA),
        content: Text(
          message,
          style: const TextStyle(color: Colors.red),
        ),
        duration: const Duration(seconds: 5),
      ),
    );
  }

  Future<void> insertUser() async {
    Map<String, dynamic> user = {
      'email': email.text,
      'username': username.text,
      'password': password.text,
    };
    int result = await db.insertUser(user);
    if (result != -1) {
      Map<String, dynamic>? user = await db.getUser(username.text);
      if (user != null) {
        navigateToHome(user);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Crear Cuenta',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: email,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor complete este campo';
                      }
                      String pattern =
                          r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
                      RegExp regex = RegExp(pattern);
                      if (!regex.hasMatch(value)) {
                        return 'Ingrese un correo electrónico válido';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: username,
                    decoration: const InputDecoration(
                      labelText: 'Usuario',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor complete este campo';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: password,
                    decoration: InputDecoration(
                        labelText: 'Contraseña',
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                showPassword = !showPassword;
                              });
                            },
                            icon: Icon(showPassword
                                ? Icons.visibility
                                : Icons.visibility_off))),
                    obscureText: !showPassword,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor complete este campo';
                      }
                      if (value.length < 6) {
                        return 'La contraseña debe tener al menos 6 caracteres';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Login()));
                      },
                      child: const Text(
                        'Ya tengo una cuenta',
                        style: TextStyle(color: Color(0xFF4F6F52)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  Center(
                    child: SizedBox(
                      width: 300,
                      child: ElevatedButton(
                        onPressed: createUser,
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1A4D2E),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 17)),
                        child: const Text('CREAR CUENTA'),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
