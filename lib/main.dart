import 'package:flutter/material.dart';
import 'package:project/menu/main.dart';
import 'package:project/theme/app_theme.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.themeData,
      home: const Scaffold(
        body: MyApp(),
      ),
    );
  }
}
