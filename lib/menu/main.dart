import 'package:flutter/material.dart';
import 'package:project/Favorites/favorite-movies.dart';
import 'package:project/home/ListViewCategories/view_categories.dart';
import 'package:project/menu/menu_bar.dart';
import 'package:project/menu/submenu/home/home.dart';
import 'package:project/theme/app_theme.dart'; // Importa la pantalla de categorías


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomePage(),
    const CategoriesScreen(),
    const FavoriteMovies(),
    const Center(child: Text('PERFIL'))
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.themeData,
      home: Scaffold(
        body: Stack(
          children: [
            IndexedStack(
              index: _currentIndex,
              children: _screens,
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: CustomMenuBar(
                onTap: (menuIcon) {
                  setState(() {
                    _currentIndex = menuIcon.index;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
