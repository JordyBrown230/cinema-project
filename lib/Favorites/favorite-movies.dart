import 'package:flutter/material.dart';
import 'package:project/MovieDetails/movie_details.dart';
import 'package:project/constants.dart';
import 'package:provider/provider.dart';
import 'package:project/Favorites/favorite-provider.dart';

class FavoriteMovies extends StatelessWidget {
  const FavoriteMovies({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Películas Favoritas'),
      ),
      body: Consumer<FavoritesProvider>(
        builder: (context, favoritesProvider, child) {
          final favoriteMovies = favoritesProvider.favoriteMovies;
          if (favoriteMovies.isEmpty) {
            return const Center(
              child: Text('No hay películas favoritas.'),
            );
          } else {
            return ListView.builder(
              itemCount: favoriteMovies.length,
              itemBuilder: (context, index) {
                final movie = favoriteMovies[index];
                return ListTile(
                  title: Text(
                    movie.title,
                    style: const TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(movie.releaseDate,
                      style: const TextStyle(color: Colors.white)),
                  leading: Image.network(
                    '${Constants.imagePath}${movie.posterPath}',
                    width: 50,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDetailsScreen(movie: movie),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
