import 'package:flutter/material.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sobre la App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Image.asset(
                      'assets/img/tmdb.jpg',
                      height: 100,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Esta aplicación utiliza la API de TMDB (The Movie Database) para obtener información sobre películas y actores. TMDB es una base de datos en línea de información sobre cine y televisión.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                'Desarrolladores',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const DeveloperInfo(
                name: 'Jordy Palacios Brown',
                role: 'Developer',
                imagePath: 'assets/img/jordy.jpg',
              ),
              const SizedBox(height: 16),
              const DeveloperInfo(
                name: 'Francisco Ortiz Ortiz',
                role: 'Developer',
                imagePath: 'assets/img/yo.jpg',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DeveloperInfo extends StatelessWidget {
  final String name;
  final String role;
  final String imagePath;

  const DeveloperInfo({
    super.key,
    required this.name,
    required this.role,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage(imagePath),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              role,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }
}
