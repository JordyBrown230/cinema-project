import 'package:flutter/material.dart';
import 'package:project/db/database_initializer.dart';
import 'package:project/login/login.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDatabase();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(debugShowCheckedModeBanner: false, home: Login());
  }
}
