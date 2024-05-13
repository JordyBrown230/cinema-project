import 'package:flutter/material.dart';
import 'package:project/menu/menu.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
      return const Menu();
      // const MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   home: carrousel()
    // );
  }
}