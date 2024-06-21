import 'package:flutter/material.dart';
import 'package:project/genres/genres.dart';
import 'categories_movies.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2D2A32),
      body: ListView.builder(
        itemCount: genres.length,
        itemBuilder: (context, index) {
          final genre = genres[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: CategoriesMovies(
              category: genre['name'],
              gender: genre['id'],
            ),
          );
        },
      ),
    );
  }
}
