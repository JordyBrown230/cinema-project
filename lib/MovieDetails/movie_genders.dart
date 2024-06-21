import 'package:flutter/material.dart';

class MovieGenders extends StatelessWidget {
  const MovieGenders({
    super.key,
    required this.genres,
  });

  final List<String> genres;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        spacing: 8,
        children: genres.map((genre) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Material(
              color: const Color(0xFF382C3E),
              borderRadius: BorderRadius.circular(50),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 8),
                child: Text(
                  genre,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
