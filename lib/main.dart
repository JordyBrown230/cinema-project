import 'package:flutter/material.dart';
import 'package:project/Favorites/favorite-provider.dart';
import 'package:project/navigation_bar.dart';
import 'package:provider/provider.dart';
import 'package:project/theme/app_theme.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.themeData,
        home: const Scaffold(
          body: MyBottomNavigationBar(),
        ),
      ),
    );
  }
}
