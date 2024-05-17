import 'package:flutter/material.dart';
import 'package:project/db/db_helper.dart';
import 'package:project/menu/menu.dart';
import 'package:project/register/register.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();
  bool showPassword = false;
  final db = DatabaseHelper();
  final _formKey = GlobalKey<FormState>(); 

  void login() async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    if (_formKey.currentState!.validate()) { 
      Map<String, dynamic>? user = await db.login(username.text, password.text);
      if (user != null) {
        navigateToHome();
      } else {
        scaffoldMessenger.showSnackBar(
          const SnackBar(
            showCloseIcon: true,
            closeIconColor: Colors.red,
            backgroundColor: Color(0xFFE8DFCA),
            content: Text(
              'Credenciales de acceso incorrectas',
              style: TextStyle(color: Colors.red), 
            ),
            duration: Duration(seconds: 5),
          ),
        );
      }
    }
  }

  void navigateToHome() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Menu()));
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
              key: _formKey, 
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Bienvenido',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Por favor ingresa tus credenciales',
                    style: TextStyle(color: Color(0xFF4F6F52)),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: username,
                    decoration: const InputDecoration(
                      labelText: 'Usuario',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Completa este campo';
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
                            : Icons.visibility_off),
                      ),
                    ),
                    obscureText: showPassword,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Completa este campo';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Register()));
                      },
                      child: const Text(
                        'Registrarme',
                        style: TextStyle(color: Color(0xFF4F6F52)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  Center(
                    child: SizedBox(
                      width: 300,
                      child: ElevatedButton.icon(
                        onPressed: login,
                        label: const Icon(Icons.login),
                        icon: const Text(
                          'INGRESAR',
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1A4D2E),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 17)),
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

