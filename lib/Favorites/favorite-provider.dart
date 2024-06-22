import 'package:flutter/material.dart';
import 'package:project/models/movie.dart';

class FavoritesProvider with ChangeNotifier {
  final List<Movie> _favoriteMovies = [];

  List<Movie> get favoriteMovies => _favoriteMovies;

  void toggleFavorite(Movie movie) {
    if (_favoriteMovies.contains(movie)) {
      _favoriteMovies.remove(movie);
    } else {
      _favoriteMovies.add(movie);
    }
    notifyListeners();
  }

  bool isFavorite(Movie movie) {
    return _favoriteMovies.contains(movie);
  }
}
